---
name: adr
description: Notice when a decision in conversation is significant enough to warrant an Architecture Decision Record (ADR) — a non-obvious choice, a rejected alternative, a trade-off, or something costly to reverse — and surface that it should be captured. Use whenever a technical/architectural decision is being made or just got made ("let's use X instead of Y", "we decided to go with...", "why don't we just use Z" being answered with a trade-off), or when asked to check/write/find ADRs. Never creates an ADR file unprompted, even when the checklist is met.
---

# ADR (Architecture Decision Record)

Think of an ADR as a comment for architecture: it exists so a future reader
doesn't have to re-derive *why* something is the way it is, especially when a
more obvious alternative was available and rejected for a reason not visible
in the code.

## When a decision warrants an ADR

Both conditions must hold:

- **Non-obvious** — a competent engineer new to the codebase, looking only at
  the code/config, would likely guess wrong or have no way to know an
  alternative was considered.
- **Would be asked about later** — someone will plausibly wonder "why not the
  other way?" and the answer isn't recoverable from the code alone.

Checklist (any one is a strong signal; more than one is a clear signal):

- A reasonable alternative was seriously considered and rejected
- The choice trades one desirable property for another (perf vs. simplicity,
  consistency vs. availability, speed vs. cost, etc.)
- Someone unfamiliar with the discussion would likely propose "just do X
  instead" and be wrong
- The decision is expensive or awkward to reverse
- The user explicitly signals a decision mid-conversation ("let's go with X
  because Y")

Reversibility is a multiplier, not a gate — cheap-to-reverse-but-non-obvious
can still warrant a short ADR; expensive-to-reverse is just the strongest
version of the signal. A **negative decision** ("we evaluated X and didn't do
it") counts even with no accompanying code change.

Don't flag routine choices with no real trade-off (default config values,
naming, anything a linter would enforce anyway).

## When the checklist is met

1. **Check for an existing ADR convention first.** Look in the project for
   `docs/decisions/`, `docs/adr/`, or similar before assuming there's none.
   See `references/detection.md` for what to check, loaded at this step only.
2. **Convention exists:** follow it — same location, same format. Never
   impose MADR or any other format over an established local one.
3. **No convention exists:** do not create anything. Tell the user this
   decision probably warrants an ADR, and suggest adopting one — default
   suggestion is `docs/decisions/` using the MADR format. See
   `references/madr-format.md` for the template, loaded only once the user
   wants to actually set this up or draft an entry.
4. **Authoring:** only draft ADR content if the user explicitly asks in a
   follow-up. Noticing and suggesting are the only unprompted actions this
   skill takes — never write a file as a side effect of noticing a trigger.

## Boundaries

- This skill surfaces and suggests; it does not create files unprompted.
- Don't invent or impose a format/location the project hasn't already chosen,
  outside of proposing MADR as the default suggestion when nothing exists.
- Don't flag every decision — only ones meeting the checklist above.
