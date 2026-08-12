# Detecting an existing ADR convention

Loaded by SKILL.md only when checking whether a project already has an ADR
practice, before suggesting MADR as a default.

Check, roughly in order of how common each is:

- `docs/decisions/` or `docs/decision-records/` — MADR's own default
- `docs/adr/` or `doc/adr/` — the older Nygard-style default
- `docs/architecture/decisions/`
- An `.adr-dir` file at the repo root (used by `adr-tools`) — its contents
  name the actual directory
- Any directory of numbered markdown files (`0001-*.md`, `001-*.md`) even in
  an unlisted location — grep for `# 1. ` or `## Status` / `## Context` /
  `## Decision` / `## Consequences` headers, the common ADR template shape
- A mention of "ADR" or "architecture decision" in `CONTRIBUTING.md`,
  `README.md`, or a docs index

If found, read one or two existing entries to infer:

- File naming/numbering scheme
- Section headers used (MADR, Nygard, Y-statements, or a custom template)
- Status values used (`proposed`, `accepted`, `deprecated`, `superseded`, ...)

Match all of it — don't normalize an existing project's format toward MADR.

If nothing is found, treat the project as having no convention.
