# Dotfiles

Personal dotfiles managed with [Dotbot](https://github.com/anishathalye/dotbot) and [Mackup](https://github.com/lra/mackup) (for private config backups).

## Prerequisites

- [Homebrew](https://brew.sh)
- Git (`brew install gh` for quick login)

## Installation

```bash
git clone --recursive https://github.com/kylebelt/dots.git ~/.dotfiles
cd ~/.dotfiles
make install
```

This will:
1. Pull latest changes and initialize submodules
2. Symlink public configs (nvim, zsh, tmux, etc.)
3. Symlink private configs and restore Mackup backup (if Mackup cloud storage is available)
4. Install private work configs (only on work machines)

## Usage

All commands should be run from `~/.dotfiles/`.

| Command | Description |
|---------|-------------|
| `make install` | Full install (public + private + work) |
| `make install_public` | Install only public dotfiles |
| `make install_private` | Install private dotfiles + mackup restore |
| `make install_personal` | Install personal configus only |
| `make install_work` | Install work dotfiles (skipped on non-work machines) |
| `make update` | Pull latest changes from git |
| `make link` | Symlink public dotfiles only |
| `make clean` | Remove dead symlinks |
| `make brew_install` | Install packages from Brewfile |
| `make backup` | Backup everything (brew dump + mackup) |
| `make mackup` | Sync mackup ignore list and run backup |
| `make brew_dump` | Update Brewfile with currently installed packages |
| `make help` | Show available targets |

### Dry Run

Preview changes without applying them (brew will be skipped):

```bash
make install DRY_RUN=1
```

## Private Repository

Sensitive configs (SSH, AWS, work tools) live in a private submodule at `private/`. This repo is optional — `make install_public` works without it.

The private repo also controls:
- Which machines are considered "work" (via `work_hostnames`)
- Mackup backup destinations (Google Drive, OneDrive)
- Work-specific Brewfile exclusions

## Mackup

Mackup backs up app configs that are **not** managed by Dotbot (e.g. app preferences, GUI tool settings, dotfiles with PII). The `sync-mackup.sh` script automatically detects conflicts between Dotbot and Mackup and updates mackup files accordingly.
