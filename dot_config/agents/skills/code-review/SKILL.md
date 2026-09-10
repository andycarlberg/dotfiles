---
name: code-review
description: Review the current diff, or a named PR/branch/path, for correctness bugs and reuse/simplification/efficiency issues, at a chosen effort level. Report-first — does not modify code unless the user asks for a fix pass. Use when asked to "review this", "code review", "check this diff/PR/branch for bugs", or before merging a non-trivial change. Not for auditing test quality specifically (use test-audit) or for applying cleanups without hunting for bugs (use simplify).
---

# Code Review

Find real problems in a change: correctness bugs first, reuse/simplification/
efficiency issues second. This is a report — don't edit code as a side effect
of reviewing it.

## Pick an effort level

- **low / medium** — fewer, high-confidence findings only. Default when the
  user gives no level and none was used earlier in the conversation.
- **high / xhigh / max** — broader coverage; may surface findings you're less
  certain about. Label uncertain findings as such rather than overstating
  confidence.

If the user re-invokes without naming a level, reuse the level from the last
invocation in this conversation.

## Scope the review

1. Determine the target: uncommitted working diff by default, or whatever the
   user names — a PR number, a branch, a commit range, a path.
2. Get the diff: `git diff`, `git diff main...HEAD`, or `gh pr diff <n>` if a
   PR was named and `gh` is available.
3. Read enough surrounding code to judge each hunk correctly — callers,
   related tests, the function's existing contract. Don't read the whole repo.

## Fan out if subagents are available

If the environment has a subagent/Task tool for spawning parallel agents,
use it at high/xhigh/max levels: split the review into facets — e.g. bug
scan, reuse/simplification/efficiency scan, and (for a named PR/branch) a
git-blame/history pass for context-based issues — and run them concurrently,
each reading only the diff plus context it needs. Merge and dedupe their
findings before reporting. At low/medium, or when no subagent tool exists,
do the same checks yourself sequentially in one pass — the checklist below
doesn't change, only whether it runs in parallel.

## What to flag

- **Correctness bugs**: wrong logic, unhandled edge cases, off-by-ones, race
  conditions, resource leaks, broken error handling — anything that produces
  a wrong result or crash under plausible inputs.
- **Reuse / simplification / efficiency**: duplicated logic that should call
  an existing function, unnecessary abstraction or indirection for the size
  of the actual requirement, and real (not micro-optimization) inefficiency.

## What to skip

- Anything a linter, type checker, or formatter would already catch.
- Pre-existing issues not introduced by this change.
- Pedantic nitpicks a senior engineer wouldn't raise.
- Issues explicitly silenced in code (e.g. a lint-ignore comment) unless the
  silencing itself is wrong.
- General coverage/documentation complaints not tied to a concrete defect —
  that's `test-audit`'s job, not this skill's.

## Report

Rank findings most-severe first. Each finding: file:line, a one-sentence
description of the defect, and the concrete failure scenario (what input or
state triggers it). Say "no issues found" plainly if the review turns up
nothing — don't manufacture findings to justify the pass.

## Optional fix / comment pass

- Only apply findings to the working tree if the user explicitly asks for a
  fix pass (e.g. `--fix`) — always report the findings first, then fix.
- Only post findings as PR comments if the user explicitly asks and the
  target is a real PR with `gh` available and authenticated.

## Boundaries

This skill reports; it does not refactor, does not chase test-quality gaps
(`test-audit`), and does not apply pure cleanups with no bug-hunting
(`simplify`).
