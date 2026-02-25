---
name: markdown-linter
description: Lint and fix Markdown files using markdownlint-cli2 with safe, reviewable edits. Use when requests mention Markdown linting, style violations, MDxxx rule errors, CI markdownlint failures, README/docs formatting cleanup, or creating/updating markdownlint config files.
---

# Markdown Linter

Lint Markdown with `bunx -bun markdownlint-cli2 --fix` and keep changes minimal and reviewable.

## Workflow

1. Scope target files from the user request. Do not reformat unrelated Markdown files.
2. Ensure `.markdownlint.yaml` exists. If missing, create it with default content `MD060: false`.
3. Set `SKILL_DIR="${CODEX_HOME:-$HOME/.codex}/skills/markdown-linter"` and run `"$SKILL_DIR/scripts/run_markdownlint.sh" <paths>`.
4. Re-run `"$SKILL_DIR/scripts/run_markdownlint.sh" <paths>` to ensure convergence.
5. Fix remaining violations manually with minimal semantic impact.
6. Summarize changed files and unresolved rule decisions.

## Commands

```bash
SKILL_DIR="${CODEX_HOME:-$HOME/.codex}/skills/markdown-linter"

# Fix whole repository
"$SKILL_DIR/scripts/run_markdownlint.sh" .

# Fix selected docs
"$SKILL_DIR/scripts/run_markdownlint.sh" README.md docs/
```

## Rule Handling

Load `references/rules.md` when violations remain after fix runs.

Prioritize:
- structural correctness (headings, list spacing, fenced code blocks)
- minimal diff size
- preserving meaning and technical accuracy

If a rule conflict requires policy choice (for example line length exceptions), propose the smallest config change and apply it only when requested.
