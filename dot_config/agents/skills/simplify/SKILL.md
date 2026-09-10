---
name: simplify
description: Review changed code for reuse, simplification, efficiency, and unnecessary abstraction, then apply the fixes directly. Quality-only — it does not hunt for correctness bugs; use code-review for that. Use when asked to "simplify this", "clean this up", "reduce duplication", or as a follow-up to a code-review pass to address its non-bug findings.
---

# Simplify

Clean up changed code for reuse, simplification, efficiency, and "altitude"
(right-sized abstraction) — then apply the fixes directly. This skill does
not hunt for correctness bugs; that's `code-review`.

## Scope

The current uncommitted diff by default, or a commit range / path the user
names. Only touch code that's actually part of the change under review —
don't wander into unrelated files.

## What to look for

- **Duplicated logic** that should call an existing function or util instead
  of restating it.
- **Unnecessary abstraction or indirection** — a layer, config option, or
  hook added for a requirement that doesn't exist yet.
- **Dead code** — unused params, imports, branches, or leftover debug code.
- **Real inefficiency** — needless O(n²) where O(n) is easy, repeated work,
  avoidable allocations. Skip micro-optimizations with no measured or
  obvious benefit.
- **Wrong altitude** — a one-off over-engineered into a framework, or real
  duplication left un-abstracted.

## What NOT to do

- Don't look for correctness bugs, missing tests, or security issues —
  report those via `code-review` instead.
- Don't introduce a new abstraction to "simplify" — prefer deleting or
  inlining over adding indirection.
- Don't change behavior. A simplification that alters output or side effects
  is a refactor bug, not a simplification.

## Apply and report

Make the edits directly, matching the existing code style and conventions.
Then give a terse summary: one line per change, naming the file and what
changed. If nothing needed simplifying, say so — don't force changes to
justify the pass.
