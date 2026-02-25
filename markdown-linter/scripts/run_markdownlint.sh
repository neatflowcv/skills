#!/usr/bin/env bash
set -euo pipefail

# Run markdownlint-cli2 fixes with bunx only.
# Usage: run_markdownlint.sh [paths...]

if [[ ! -f .markdownlint.yaml ]]; then
  cat > .markdownlint.yaml <<'YAML'
MD060: false
YAML
fi

if [[ "$#" -eq 0 ]]; then
  set -- .
fi

exec bunx -bun markdownlint-cli2 --fix "$@"
