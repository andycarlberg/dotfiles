# MADR format (default suggestion when no convention exists)

Loaded by SKILL.md only once the user wants to set up an ADR practice or
draft an entry. MADR (Markdown Architecture Decision Records) is the current
de facto community standard: https://adr.github.io/madr/

## Location and naming

`docs/decisions/NNNN-title-with-dashes.md`, zero-padded, sequential, never
reused even if an ADR is later superseded.

Example: `docs/decisions/0001-use-postgres-for-primary-datastore.md`

## Template (minimal MADR)

```markdown
# <short noun phrase describing the decision>

* Status: proposed | accepted | rejected | deprecated | superseded by [ADR-000X](000X-title.md)
* Date: YYYY-MM-DD

## Context and Problem Statement

<What is the issue we're seeing that motivates this decision? 2-4 sentences.>

## Considered Options

* <Option A>
* <Option B>
* <Option C>

## Decision Outcome

Chosen option: "<Option X>", because <justification — the trade-off actually
being made, not a restatement of the option>.

### Consequences

* Good, because <positive consequence>
* Bad, because <negative consequence / accepted downside>
```

Full MADR also supports `## Pros and Cons of the Options` per option and a
`## More Information` section — include them only if the decision is complex
enough to need them. Prefer the minimal template above by default.

## Suggesting setup

When proposing MADR for a project with no convention, suggest only:

1. Create `docs/decisions/`
2. Optionally add a `0000-adopt-adr-process.md` documenting the adoption
   itself (dogfooding — a decision about how to record decisions is itself
   ADR-worthy)

Don't scaffold tooling (`adr-tools`, CI checks, templates directory) unless
asked — that's beyond "suggest a framework."
