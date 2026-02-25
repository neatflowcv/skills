# Repository Guidelines

## Project Structure & Module Organization
This repository contains Codex skills. Each skill lives in its own top-level folder and must include a `SKILL.md` file.

Important: skills are often executed from external repositories. Do not assume the current working directory is the skill folder.

Current layout:
- `markdown-linter/SKILL.md`: Skill definition, trigger description, and workflow.
- `markdown-linter/agents/openai.yaml`: UI metadata (`display_name`, `short_description`, `default_prompt`).
- `markdown-linter/scripts/`: Executable helpers (for example `run_markdownlint.sh`).
- `markdown-linter/references/`: Supporting guidance loaded only when needed.

When adding new skills, follow the same folder pattern: `<skill-name>/SKILL.md`, plus optional `agents/`, `scripts/`, `references/`, and `assets/`.

## External Usage Rule (Required)
Always document and use a `SKILL_DIR` variable for script execution:

```bash
SKILL_DIR="${CODEX_HOME:-$HOME/.codex}/skills/<skill-name>"
"$SKILL_DIR/scripts/<script-name>" <args>
```

Apply this pattern to every new skill, not only `markdown-linter`. Relative paths like `scripts/foo.sh` are not acceptable in usage docs because they fail outside the skill directory.

## Build, Test, and Development Commands
Use these commands from the repository root:

```bash
python3 ~/.codex/skills/.system/skill-creator/scripts/quick_validate.py ./markdown-linter
```
Validates skill frontmatter and structure.

```bash
bash -n ./markdown-linter/scripts/run_markdownlint.sh
```
Checks shell syntax for the lint helper script.

```bash
SKILL_DIR="${CODEX_HOME:-$HOME/.codex}/skills/markdown-linter"
"$SKILL_DIR/scripts/run_markdownlint.sh" README.md
```
Runs markdown fixes with the installed skill script.

## Coding Style & Naming Conventions
- Use lowercase hyphen-case for skill folder names (example: `markdown-linter`).
- Keep instructions concise and imperative in `SKILL.md`.
- Shell scripts should use `bash`, `set -euo pipefail`, and clear error behavior.
- In examples, prefer `SKILL_DIR`-based absolute paths over repository-relative script paths.
- Prefer ASCII unless non-ASCII is required by content.

## Testing Guidelines
There is no dedicated test framework in this repo yet. Minimum validation before commit:
- Run `quick_validate.py` on every modified skill.
- Run syntax checks for edited scripts (`bash -n`).
- If script behavior changes, execute at least one representative command and verify output.

## Commit & Pull Request Guidelines
Follow the existing commit style: short imperative summary (example: `Add markdown-linter skill with bunx fix workflow`).

For PRs, include:
- Purpose and scope of the skill/update.
- Files changed and why.
- Validation commands run and their results.
- Example invocation(s) if script behavior changed.
