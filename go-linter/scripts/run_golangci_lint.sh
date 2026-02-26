#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${1:-$PWD}"

if [[ ! -d "$TARGET_DIR" ]]; then
  echo "error: target directory does not exist: $TARGET_DIR" >&2
  exit 1
fi

# Return 0 if changed .go files are detected, 1 otherwise.
has_changed_go_files() {
  if command -v git >/dev/null 2>&1 && git -C "$TARGET_DIR" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    local changed
    changed="$({
      git -C "$TARGET_DIR" diff --name-only -- '*.go'
      git -C "$TARGET_DIR" diff --cached --name-only -- '*.go'
      git -C "$TARGET_DIR" ls-files --others --exclude-standard -- '*.go'
    } | sed '/^$/d' | sort -u)"

    [[ -n "$changed" ]]
    return
  fi

  # Fallback for non-git directories.
  if command -v rg >/dev/null 2>&1; then
    rg --files -g '*.go' "$TARGET_DIR" >/dev/null 2>&1
    return
  fi

  find "$TARGET_DIR" -type f -name '*.go' | grep -q .
}

ensure_golangci_lint() {
  if command -v golangci-lint >/dev/null 2>&1; then
    return
  fi

  if ! command -v go >/dev/null 2>&1; then
    echo "error: golangci-lint is missing and go is not available for installation" >&2
    exit 1
  fi

  echo "golangci-lint not found. Installing..."
  go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest

  local gobin
  gobin="$(go env GOBIN)"
  if [[ -z "$gobin" ]]; then
    gobin="$(go env GOPATH)/bin"
  fi
  export PATH="$gobin:$PATH"

  if ! command -v golangci-lint >/dev/null 2>&1; then
    echo "error: golangci-lint installation completed but binary is not in PATH" >&2
    exit 1
  fi
}

ensure_config() {
  local config_path="$TARGET_DIR/.golangci.yaml"
  if [[ -f "$config_path" ]]; then
    return
  fi

  cat > "$config_path" <<'YAML'
version: "2"
linters:
  default: all
  disable:
    - revive
    - depguard
YAML

  echo "created $config_path"
}

if ! has_changed_go_files; then
  echo "No changed Go files detected. Skipping golangci-lint."
  exit 0
fi

ensure_golangci_lint
ensure_config

(
  cd "$TARGET_DIR"
  golangci-lint run --fix
)
