# Report format

Loaded by SKILL.md only at the reporting step.

Lead with a one-line verdict, then findings ranked High → Medium → Low, then
a short coverage summary. No fixes applied unless asked.

```
## Test audit: <scope, e.g. "working diff" or "PR #123">

**Verdict:** <one sentence — e.g. "Coverage is adequate but two tests
wouldn't catch a regression in the new logic.">

### Findings

- **[High]** `path/to/file.py:42` — <smell name>: <one-line reason, concrete>
- **[Medium]** `path/to/test_file.py:18` — ...
- **[Low]** `path/to/test_file.py:5` — ...

### Coverage gaps

- <changed behavior with no test at all, if any — file:line of the
  production change, not the missing test>

### Not audited

- <anything explicitly out of scope, e.g. "e2e layer — project has none">
```

Omit sections with nothing to report rather than writing "None." Keep each
finding to one line; expand only if the user asks for detail on a specific one.
