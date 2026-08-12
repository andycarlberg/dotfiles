---
name: test-audit
description: Audit the tests for a change (working diff, a commit range, or a PR) for usefulness, effectiveness, and coverage — not just presence. Use whenever asked to "audit tests", "check test coverage/quality", "are these tests any good", "review the tests for this change", or before treating a change as done when test quality itself is in question (not just whether tests exist or pass). Do not use for writing tests test-first (TDD) or for general code review — use this only for assessing existing/new test quality.
---

# Test Audit

Assess whether the tests touched by a change actually verify behavior, not just
whether tests exist. This is a report-first skill: default to surfacing gaps,
not silently fixing them.

## Scope the audit

1. Determine the diff to audit: uncommitted changes by default, or a commit
   range / PR if the user names one (`git diff`, `git diff main...HEAD`, `gh pr diff`).
2. From the diff, separate:
   - **Production code changed** — needs test coverage for new/changed behavior.
   - **Test code changed** — needs quality review in its own right.
3. Identify the project's existing test layers (unit / integration / e2e) by
   looking at what's already there (test dirs, CI config, package manifest
   scripts). Never introduce a layer the project doesn't already have —
   flag a missing layer as a gap to raise with the user, not something to add.

## For each changed production unit

Check, don't assume:

- Is there a test that would **fail if this change were reverted**? If a test
  passes identically whether the new logic exists or not, it isn't coverage.
- Are edge cases and error paths covered, not just the happy path?
- Do tests cover the actual behavioral contract (inputs/outputs, side effects,
  errors) rather than implementation details (private methods, internal call
  order, exact mock invocation counts) that would break on harmless refactors?

For the specific smells to grep for and how to phrase findings, read
`references/test-smells.md` — load it only when you're at this step, not
up front.

## For each changed test file

Skim for structural quality issues: unclear names, tautological assertions,
over-mocked setups that test the mock instead of the code, missing negative
cases. Same smell catalog in `references/test-smells.md` applies here too.

## Report

Use the format in `references/report-format.md`. Load it when you're ready to
write output, not before. Keep the report itself terse — findings ranked by
severity, each with a file:line and a one-line reason. No fixes applied
unless the user explicitly asks for `--fix` behavior in the same turn.

## Boundaries

- This skill assesses; it does not rewrite tests unless asked.
- Don't invent a test level, framework, or convention absent from the project.
- If the diff has no production code changes (docs/config only), say so and skip
  the audit rather than inventing findings.
