# AGENTS.md

This file provides guidance to AI coding agents when working with code in this repository.

## What this is

A [chezmoi](https://www.chezmoi.io/)-managed dotfiles repo for macOS, Arch Linux (CachyOS), and WSL. Fish is the primary shell, with Zsh/Bash/POSIX sh as fallbacks. See `README.md` for the full stack table, architecture diagrams, and shell startup chains — read it before making cross-shell changes.

## Commands

```bash
chezmoi diff                 # preview what applying the source state would change
chezmoi apply                # apply source state to the actual home directory
chezmoi apply -v             # verbose apply, shows each change
chezmoi cd                   # cd into the source directory (this repo)
chezmoi execute-template < file.tmpl   # render a .tmpl file to check templating logic
chezmoi state ...            # inspect chezmoi's persistent state (run_once script tracking)
```

There is no build/lint/test suite — this is a config repo. Validate changes with `chezmoi diff` and, for shell logic, by sourcing the affected file manually.

## Naming conventions (chezmoi source state)

Files in this repo are chezmoi source-state names, not literal target paths:

- `dot_foo` → `~/.foo`
- `private_dot_foo` → `~/.foo` with `0600` perms
- `exact_foo` → directory whose contents exactly mirror the source (extra files in target get removed)
- `symlink_foo` → creates a symlink; file content is the link target
- `.tmpl` suffix → Go template, rendered with data from `.chezmoi.toml.tmpl` and `.chezmoidata/`
- `run_once_*` → script run once ever (tracked in chezmoi state)
- `run_onchange_*` → script re-run when its own content hash changes
- `run_after_*` / `run_once_after_*` → ordered to run after other apply operations

When editing, always edit the source-state file in this repo — never edit `~/.foo` directly, since `chezmoi apply` would overwrite it.

## Architecture essentials

- **Cross-shell sharing lives in `dot_shell/`** — the single source of truth consumed by sh/bash/zsh/fish. Fish can't source POSIX files, so aliases/env vars go in `interactive_aliases`/`env_vars` (shared via `posix_source`), while shell-specific logic (functions, fish-native paths/Homebrew/Mise activation) lives per-shell. See README's "Cross-shell sharing" and "Shell startup chains" sections for the exact sourcing order — get this wrong and a variable/alias silently won't reach one shell.
- **`.chezmoidata/packages.yaml`** drives generated PATH entries (`dot_shell/common_paths.tmpl`) and OS package installation (`run_onchange_install-packages.sh.tmpl`), which branches per OS package manager (Homebrew, Pacman/Paru, Apt).
- **`.chezmoi.toml.tmpl`** defines the one-time init prompts (email, name, work-machine flag, SSH host alias, install toggles) — data referenced throughout templates as `.email`, `.is_work`, `.install_packages`, etc.
- **Work-machine SSH multi-identity**: on work machines chezmoi manages `~/.ssh/config.d/github.conf` for a personal GitHub SSH alias; `run_once_after_configure-ssh-includes.sh.tmpl` wires the `Include` directive into `~/.ssh/config`.
- **`dot_claude/` and `dot_gemini/`** are symlinked (not copied) into place — `symlink_CLAUDE.md`, `symlink_skills`, `symlink_GEMINI.md`, `symlink_extensions` — so edits to the actual agent config files should happen through the symlink target, and this repo's copies are the source of truth.
- `run_onchange_*` scripts key off content hashes, so a no-op edit (e.g. reformatting) will still trigger a re-run on next `chezmoi apply`.
