# Andy Carlberg's Dotfiles

A portable, cross-platform configuration managed with [chezmoi](https://www.chezmoi.io/). This repository contains my personal shell environments, editor configurations, and system-wide settings optimized for performance and consistency across macOS, Arch Linux (CachyOS), and Windows (WSL).

## One-Liner Bootstrap

On a fresh machine, run:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply andycarlberg
```

This command downloads a standalone `chezmoi` binary, initializes the repository, and executes all installation scripts (Homebrew, packages, and shell configuration) autonomously.

## Tech Stack and Philosophy

My setup is built around several core principles: speed, security, and universality.

- **Shells:** 
  - **Zsh:** My primary driver, configured with [Antidote](https://github.com/mattmc3/antidote) for fast plugin management and [Powerlevel10k](https://github.com/romkatv/powerlevel10k) for a responsive UI.
  - **Fish:** Integrated via a custom POSIX-bridge to share aliases and paths with POSIX shells seamlessly.
  - **Bash:** Maintained as a fallback with shared environment logic.
- **Package Management:** 
  - Managed via a centralized `.chezmoidata/packages.yaml` categorized by OS (macOS, Arch, Debian).
  - **Runtimes:** [Mise](https://mise.jdx.dev/) manages programming language runtimes (Node, Python, Go) for cross-project consistency.
- **Editors and Tools:**
  - **Helix:** A post-modern modal text editor.
  - **Ghostty:** A fast, GPU-accelerated terminal emulator (native Linux/macOS).
  - **Yazi:** A terminal-based file manager.
  - **Zellij:** A modern terminal workspace and multiplexer.

## Architecture

The repository follows a strict separation of concerns based on the Flowblok "Shell Startup" philosophy:

- **Environment (`dot_shell/env`)**: Centralized exports, umask settings, and tool initializations (Homebrew, Mise).
- **Paths (`dot_shell/common_paths.tmpl`)**: A single source of truth for `$PATH` entries, shared across all shells.
- **Interactive (`dot_shell/interactive`)**: Shared aliases and shell functions.
- **Identity (`.chezmoi.toml.tmpl`)**: Dynamic prompting for name, email, and work/personal context.
- **Git Automation (`run_after_configure-git-remote.sh.tmpl`)**: Automatically transitions the local clone to SSH, supporting custom host aliases (e.g., `github.com-personal`).

## Author

**Andy Carlberg**  

---

*Disclaimer: This is a personal project intended for my specific workflow. Feel free to fork or reference, but use at your own risk.*
