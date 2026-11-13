# Dotfiles

Ubuntu 24.04 x86_64: zsh, tmux, Git, kitty, i3/i3blocks, rofi, dunst, picom,
LazyVim, Yazi. Catppuccin Mocha everywhere.

```sh
git clone https://github.com/nthng-quan/dots.git ~/repo/dotfiles && cd ~/repo/dotfiles
./install-deps.sh --dry-run && ./install-deps.sh --apply   # apt (sudo) + pinned tools
./install.sh --dry-run && ./install.sh                     # link configs into ~
./sync-plugins.sh                                          # shell/tmux/nvim plugins
```

Servers (zsh, tmux, Git, Neovim only, no desktop): `./install-cli.sh --apply`.
Nothing changes your login shell or session; `chsh -s "$(command -v zsh)"` and
pick the i3 session yourself.

## Components

| Docs | Covers |
|---|---|
| [Shell, tmux, Git](home/README.md) | zsh aliases, tmux keys and plugins, Git identity |
| [i3 + bar](home/.config/i3/README.md) | keybindings, status bar blocks, wallpaper, monitor handling |
| [kitty](home/.config/kitty/README.md) | terminal keys, scrollback in nvim, images in tmux |
| [Neovim](home/.config/nvim/README.md) | LazyVim extras, custom keys, plugin locks |

Also linked: `.config/{rofi,dunst,picom,alacritty}`.

## How it works

- **`install-deps.sh`**: apt packages, plus checksummed releases from
  `releases.lock.json` (Neovim, Starship, Yazi, lazygit, Iosevka Nerd Font) into
  `~/.local/share/dotfiles`, linked into `~/.local/bin`. `--profile cli` skips
  desktop packages and the font.
- **`install.sh`**: symlinks each file under `home/` into `~` (READMEs excluded).
  Conflicting files move to `~/.local/state/dotfiles/backups/<timestamp>/`.
  Keep the repo in place; the links point into it.
- **Locks**: `plugins.lock.json` (shell/tmux plugin commits),
  `nvim-plugins.lock.json` + `lazy-lock.json` (Neovim). Bump deliberately.

## Local settings (not tracked)

| File | For |
|---|---|
| `~/.zshrc.local` | secrets, work aliases, nvm/cloud init, extra PATH |
| `~/.gitconfig.local` | Git identity, credential helper |
| `~/.config/i3/local.sh` | touchpad, monitor layout, other machine-only setup |

`vvpn` is a private work-VPN wrapper around `openvpn3` (`~/scripts/vvpn`,
profile with credentials in `~/vpn/`); it is not in this repo, and the bar's
VPN block only appears when `vvpn` is on `PATH`. AI CLIs and credentials are
not installed either. Vietnamese input: pick Unikey in `ibus-setup` once.

## Checks

```sh
python3 -m unittest discover -s tests -v
bash -n install.sh install-deps.sh sync-plugins.sh
```
