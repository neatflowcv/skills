---
name: go-linter
description: Run golangci-lint with automatic fixes when Go files change in a project. Use when requests involve linting Go code, fixing golangci-lint issues, enforcing Go lint checks after edits, installing missing golangci-lint, or creating a baseline .golangci.yaml configuration.
---

# Go Linter

Run `golangci-lint run --fix` only when changed `.go` files are present, and keep setup deterministic.

## Workflow

1. Set `SKILL_DIR="${CODEX_HOME:-$HOME/.codex}/skills/go-linter"`.
2. Run `"$SKILL_DIR/scripts/run_golangci_lint.sh" <project-dir>`.
3. If no path is provided, script uses current directory.
4. Review and summarize lint-driven code edits and any new config file creation.

## Commands

```bash
SKILL_DIR="${CODEX_HOME:-$HOME/.codex}/skills/go-linter"

# Run in current repository
"$SKILL_DIR/scripts/run_golangci_lint.sh"

# Run in a specific repository
"$SKILL_DIR/scripts/run_golangci_lint.sh" /path/to/repo
```

## Script behavior

`run_golangci_lint.sh` performs the following steps:

1. Detect changed `.go` files (staged, unstaged, and untracked in Git repositories).
2. Skip linting when no changed Go files are found.
3. Install `golangci-lint` using `go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest` when missing.
4. Create `.golangci.yaml` in the project root when missing:

```yaml
version: "2"
linters:
  default: all
  disable:
    - revive
    - depguard
```

5. Run `golangci-lint run --fix` in the target project.
