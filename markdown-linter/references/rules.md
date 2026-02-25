# Markdown Linting Rules Reference

Use this file for common decisions while fixing violations.

## Default posture

- Prefer fix-first runs: `scripts/run_markdownlint.sh <paths>`
- Review changed lines and keep semantic meaning intact.
- Avoid style-only churn outside the requested files.

## Frequent rules and practical fixes

- `MD013` (line length): break long prose lines; avoid breaking URLs if it hurts readability.
- `MD022` (headings surrounded by blank lines): add a blank line before and after headings.
- `MD024` (duplicate heading): rename ambiguous repeated headings in the same scope.
- `MD025` (single top-level heading): keep one `#` heading per document.
- `MD032` (lists surrounded by blank lines): add blank lines around list blocks.
- `MD031`/`MD040` (fenced code blocks): keep fences surrounded by blank lines and include a language label when possible.

## Config file conventions

If `.markdownlint.yaml` is missing, create it with:

```yaml
MD060: false
```
Use minimal, explicit rule overrides and include a short rationale comment per override.
