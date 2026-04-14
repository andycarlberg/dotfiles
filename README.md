# Andy Carlberg's Dotfiles

A portable, cross-platform configuration managed with [chezmoi](https://www.chezmoi.io/). Optimised for macOS, Arch Linux (CachyOS), and WSL, with Fish as the primary shell and clean fallbacks for Zsh, Bash, and POSIX sh.

## Bootstrap

On a fresh machine:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply andycarlberg
```

This downloads a standalone `chezmoi` binary, prompts for a few configuration values, then runs all install scripts (Homebrew, packages, shell default, SSH config) autonomously.

### Init prompts

| Prompt | Default | Purpose |
|---|---|---|
| Email | — | Git identity |
| Full name | Andy Carlberg | Git identity |
| Work machine? | false | Enables work-specific SSH config |
| Personal GitHub SSH host | github.com | Host alias for personal key on work machines |
| Install packages and tools? | true | Set false for config-only setup (skips Homebrew, packages, mise) |
| Set fish as default shell? | true | Runs `chsh` to set fish as login shell |

## Stack

| Category | Tools |
|---|---|
| **Primary shell** | [Fish](https://fishshell.com/) |
| **Fallback shells** | Zsh, Bash, POSIX sh |
| **Editor** | [Helix](https://helix-editor.com/) (`hx`) |
| **Terminal** | [Ghostty](https://ghostty.org/) |
| **Multiplexer** | [Zellij](https://zellij.dev/) |
| **File manager** | [Yazi](https://yazi-rs.github.io/) |
| **Prompt** | [Starship](https://starship.rs/) (Fish, Zsh, Bash) |
| **Runtime manager** | [Mise](https://mise.jdx.dev/) (Node, Python, Go) |
| **Package manager** | Homebrew (macOS + Linux), Pacman/Paru (Arch), Apt (Debian) |

## Architecture

### Cross-shell sharing (`dot_shell/`)

The core design goal is a single source of truth for configuration that all four shells consume. Fish cannot source POSIX files natively, so there is a defined boundary:

| File | Shared how | Available in |
|---|---|---|
| `env_vars` | `. ~/.shell/env_vars` / `posix_source` | sh, bash, zsh, **fish** |
| `interactive_aliases` | `. ~/.shell/interactive` / `posix_source` | sh, bash, zsh, **fish** |
| `interactive_functions` | `. ~/.shell/interactive` | sh, bash, zsh |
| `env` | `. ~/.shell/env` | sh, bash, zsh |
| `common_paths.tmpl` | `. ~/.shell/env` | sh, bash, zsh |

Fish paths and Homebrew/Mise activation live in `dot_config/fish/conf.d/env.fish` since they require fish-native syntax.

The practical rule: **command shortcuts go in `interactive_aliases`** (all shells get them); logic goes where it lives (fish functions for fish, POSIX functions for fallback shells).

### Shell startup chains

```
sh:   ~/.profile → ~/.sh/env → ~/.shell/env
      $ENV      → ~/.sh/interactive → ~/.shell/interactive

bash: ~/.bash_profile → ~/.bash/env → ~/.shell/env
                      → ~/.bash/interactive → ~/.shell/interactive
      ~/.bashrc       → ~/.bash/env + ~/.bash/interactive

zsh:  ~/.zshenv → ~/.zsh/env → ~/.shell/env
      ~/.zshrc  → ~/.zsh/interactive → ~/.shell/interactive

fish: ~/.config/fish/conf.d/env.fish        (paths, brew, mise, posix_source env_vars)
      ~/.config/fish/conf.d/interactive.fish (posix_source aliases, starship, fzf)
```

### Chezmoi templates

- **`.chezmoi.toml.tmpl`** — prompts for identity and machine context once per machine using `promptStringOnce`/`promptBoolOnce`
- **`dot_shell/common_paths.tmpl`** — generates PATH entries from the `paths` list in `.chezmoidata/packages.yaml`
- **`dot_config/mise/config.toml.tmpl`** — runtime tool versions

### SSH multi-identity (work machines)

On work machines with a custom `github_ssh_host`, chezmoi manages `~/.ssh/config.d/github.conf` with the personal GitHub host alias (e.g. `github.com-personal → github.com` via a specific SSH key). A `run_once_after_` script adds `Include ~/.ssh/config.d/*` to `~/.ssh/config`. The chezmoi repo remote is automatically converted to SSH using the configured host alias.

### Install scripts

All install scripts (except fisher) are skipped when `install_packages = false`.

| Script | Trigger | Purpose |
|---|---|---|
| `run_once_install-homebrew.sh.tmpl` | Once | Installs Homebrew |
| `run_onchange_install-packages.sh.tmpl` | packages.yaml changes | Installs OS packages |
| `run_onchange_after_install-mise-tools.sh.tmpl` | mise config changes | Installs runtime tools |
| `run_onchange_after_install-fisher.sh.tmpl` | fish_plugins changes | Bootstraps fisher and syncs plugins |
| `run_once_after_set-default-shell.sh.tmpl` | Once | Sets fish as login shell |
| `run_once_after_configure-ssh-includes.sh.tmpl` | Once (work machines) | Wires up SSH config.d |
| `run_after_configure-git-remote.sh.tmpl` | Always | Converts chezmoi remote to SSH |

## Local overrides

| File | Purpose |
|---|---|
| `~/.shell/env_local` | Machine-specific env vars (sourced by all POSIX shells) |
| `~/.config/fish/local.fish` | Machine-specific fish config |

---

*Personal project — fork or reference freely, use at your own risk.*
