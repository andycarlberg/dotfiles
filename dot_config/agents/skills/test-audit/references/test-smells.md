# Test smell catalog

Loaded by SKILL.md only when actively inspecting changed tests or checking
coverage of changed production code. Use this as a checklist, not a script —
not every item applies to every language/framework.

## Coverage smells (tests that exist but don't verify anything)

- **Tautological assertion** — asserts a value against itself, or asserts a
  constant that can't change (`expect(2 + 2).toBe(4)`, `assert result is not None`
  on a function that never returns None).
- **No-op on revert** — mentally revert the production change; if the test
  still passes, it isn't testing the change. This is the single highest-value
  check in this skill.
- **Snapshot-only** — a snapshot/golden-file test with no accompanying
  assertion about *why* the output is correct; regressions get rubber-stamped
  by re-recording the snapshot instead of being caught.
- **Happy-path-only** — no test exercises an error, empty input, boundary
  value, or concurrent/duplicate case where the change plausibly matters.

## Implementation-coupling smells (tests that break for the wrong reasons)

- **Private/internal reach-in** — test calls or inspects private methods,
  internal state, or module-private symbols instead of the public contract.
- **Over-mocked** — every collaborator is mocked, so the test verifies "my
  code calls the mock the way I wrote it to call the mock," not real behavior.
  Look for mock assertion counts as the *only* assertions in the test.
  Or, in "the sociable vs. solitary" tension: prefer real collaborators unless
  the collaborator is slow, non-deterministic, or external (network, clock,
  filesystem, randomness) — those are legitimate mock/fake boundaries.
- **Order-coupled mock verification** — asserting exact call order/count on
  a mock when the production code's correctness doesn't actually depend on
  that order.
- **Brittle exact-match on generated/formatted output** (timestamps, UUIDs,
  full object equality) where only specific fields matter.

## Structural smells (harder to trust or maintain)

- **Unclear test name** — name doesn't state the behavior under test and the
  expected outcome (`test_1`, `test_edge_case`, `test_works`).
- **Multiple unrelated assertions in one test** — failure doesn't localize to
  a cause; consider whether it should be split.
- **Conditional logic inside a test** (`if`/loops determining what's asserted)
  — usually means the test needs parametrization or is testing too much at once.
- **Shared mutable fixture state** across tests without isolation/reset,
  producing order-dependent pass/fail.
- **Time/order/network dependent** — flaky by construction (real sleeps,
  unseeded randomness, real clocks, real network calls) rather than using the
  project's existing fake/mock/freeze utilities for these.

## Severity guidance for the report

- **High** — no-op-on-revert, missing coverage for changed error path, flaky
  by construction.
- **Medium** — over-mocked to the point of not testing real behavior,
  implementation-coupling that will break on a harmless refactor.
- **Low** — naming, structure, minor duplication.
