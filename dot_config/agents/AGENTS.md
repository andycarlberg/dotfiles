# Communication Style

- Be terse and concise by default. Minimize tokens.
- After a change, give a brief summary of what was done and why. Do not over-explain.
- If I want more detail, I'll ask for it — don't front-load explanation.
- Ask clarifying questions before large or ambiguous changes rather than guessing.

# Autonomy & Permissions

Free to do without asking:
- Read-only commands (`git status`, `git log`, `git diff`, `ls`, `grep`, etc.)
- Running tests, linters, builds
- Staging changes (`git add`)
- Creating or switching local git branches

Always ask before:
- `git commit`
- `git push` (including force-push — treat force-push as high-risk regardless of context)
- Deleting files or branches
- Installing/removing/updating dependencies (including lockfile-only version bumps)
- Any destructive or irreversible operation

Goal: keep a clean, coherent, intentional git history. I review staged diffs before commit.

# Git Conventions

- Use **Conventional Commits** by default (`feat:`, `fix:`, `refactor:`, `test:`, `chore:`, etc.).
- Defer to a project's own commit convention if one is defined (e.g. `.gitmessage`, CONTRIBUTING.md, existing commit history pattern) — don't impose Conventional Commits over an established local standard.
- Prefer **trunk-based development**: short-lived branches off the trunk, merged back quickly, rather than long-lived feature branches.
- Branch naming: conventional-commit-style prefixes — `feat/…`, `fix/…`, `release/…`, etc. — unless the project already has its own pattern, in which case follow that.

# Code Standards & Workflow

- I'm a polyglot — never assume a stack. Detect and follow what the project already uses.
- Prefer strict mode / strict type-checking, whatever that means for the given language
  (e.g. `strict` in tsconfig, `mypy --strict`, Rust's default strictness, etc.).
- **Never introduce a new testing framework, linter, or formatter into a project that
  doesn't already have one**, unless explicitly told to. If none exists, say so instead
  of silently picking one.
- **TDD when a test framework is present**: write/adjust the failing test first, then implement.
- Tests should exist at all levels the project already has, at the depth the change
  warrants — but don't introduce a new test level that doesn't already exist in the
  project. E.g. a new command needs unit, integration, and e2e/functional coverage if
  the project has those layers; a small change to one function may only need a unit test.
- Formatting is handled by my editor on save — don't run a formatter as part of a change.
- A change is not "done" until it has appropriate test coverage and passes the
  project's existing lint check. Run the linter once at the end of the change, not
  after every individual edit — fix everything it flags in one pass.
- Design principles: single responsibility, low coupling, high cohesion, clear
  separation of concerns, small functions/units that do one thing, dependencies
  pointing toward stable abstractions rather than concrete details.
- Comments explain **why**, not **what**. Keep them concise. Only add a comment when the
  logic isn't obvious from the code itself. Favor self-documenting code; avoid restating
  what the code already says.

# Problem-Solving Approach

- **Explore, then plan, then act.** Before editing, read enough of the relevant code
  to understand how the change fits — don't start writing code from a guess at the
  structure. For anything nontrivial, state a short plan before acting; a one-line
  plan is enough for small changes.
  - **Switch to plan mode** before making a change that touches 3+ files, or alters
    architecture, design, or an interface (API, CLI/command surface, data model,
    schema). Plan mode output can be more verbose than normal — that's expected, not
    a violation of "terse."
- **Diagnose root cause, not symptoms.** When fixing a bug, understand *why* it happens
  before patching *where* it happens. Don't paper over a failing test or error with a
  workaround (e.g. widening a type, catching and swallowing an exception, special-casing
  an input) unless the root cause is genuinely out of scope — and if so, say that
  explicitly rather than silently taking the shortcut.
- **Self-review before calling it done.** For any nontrivial change, do a review pass
  over the diff before handing it back — check for correctness bugs, leftover debug
  code, missed edge cases, and simplification opportunities. If the environment has a
  dedicated review tool/command, use it instead of a manual pass.

# Environment & Tooling

- `pnpm` over `npm`; `mise` for version management.
- My interactive environment is fish + zellij + helix + yazi — relevant if writing
  something meant for me to run manually, though Claude Code's own tool calls run via
  `sh`/`bash` regardless.
