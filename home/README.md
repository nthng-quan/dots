# Shell, tmux, Git

Files here are linked into `~` by `install.sh`. Component docs:
[i3 + bar](.config/i3/README.md) · [kitty](.config/kitty/README.md) ·
[Neovim](.config/nvim/README.md)

## Zsh (`.zshrc`, `.zsh_aliases`)

oh-my-zsh (`git` plugin), autosuggestions, syntax highlighting, autocomplete,
Starship prompt, zoxide, fzf. Mason's bin dir is on `PATH`.

| Alias | Command |
|---|---|
| `gs`, `gdiff` | `git status`, `git diff` |
| `sss` | reload `~/.zshrc` |
| `update`, `upgrade` | `sudo apt update`, `sudo apt upgrade` |
| `s` | `kitten ssh` (when kitty is installed) |

Machine-only settings and secrets: `~/.zshrc.local` (sourced if present).

## tmux (`.tmux.conf`)

Prefix `Ctrl+b`. Mouse on, status bar on top, wheel scrolls 1 line.

| Key (after prefix) | Action |
|---|---|
| `\|` / `-` | split right / below, in the current directory |
| `h/j/k/l` | select pane (also `Ctrl+h/j/k/l` with Neovim via vim-tmux-navigator) |
| `H/J/K/L` | resize pane (repeatable) |
| `Ctrl+p` / `Ctrl+n` | previous / next window |
| `x` | kill pane |
| `C` | split with `claude` |
| `r` | reload config |

Plugins (tpm): resurrect + continuum (sessions survive reboots), yank, open,
cpu. Passthrough is on so terminal images work inside tmux.

## Git (`.gitconfig`, `.config/git/`)

Shared defaults only. Identity and credential helper go in `~/.gitconfig.local`:

```sh
git config --file ~/.gitconfig.local user.name 'Your Name'
git config --file ~/.gitconfig.local user.email 'you@example.com'
```
