# Dotfiles

Minimal configuration for Ubuntu 24.04 x86_64: Zsh, tmux, Git, Alacritty,
i3/i3blocks, rofi, dunst, picom, LazyVim, and Yazi.

```sh
git clone https://github.com/nthng-quan/dotfiles.git ~/repo/dotfiles
cd ~/repo/dotfiles
./install-deps.sh --dry-run
./install-deps.sh --apply
./install.sh --dry-run
./install.sh
./sync-plugins.sh
```

Run as your normal user. Only apt uses sudo. Open a new terminal afterward.
Select the i3 session on the login screen. Change your login shell explicitly
with `chsh -s "$(command -v zsh)"` if desired. No shell or session is changed automatically.

## What gets installed

Versions and commits are pinned in the lock files listed below; those files are
the source of truth. ✓ = installed by that profile.

### Tools (checksummed GitHub releases, `releases.lock.json`)

| Tool | Version | Purpose | cli | desktop |
|---|---|---|:-:|:-:|
| [Neovim](https://github.com/neovim/neovim) | v0.11.5 | Editor | ✓ | ✓ |
| [Starship](https://github.com/starship/starship) | v1.24.2 | Shell prompt | ✓ | ✓ |
| [Yazi](https://github.com/sxyazi/yazi) | v25.5.31 | Terminal file manager | ✓ | ✓ |
| [lazygit](https://github.com/jesseduffield/lazygit) | v0.55.1 | Git TUI | ✓ | ✓ |
| [Iosevka Nerd Font](https://github.com/ryanoasis/nerd-fonts) | v3.4.0 | Terminal font with icons | | ✓ |

Installed to `~/.local/share/dotfiles/<name>` and linked into `~/.local/bin`.

### Shell and tmux plugins (Git commits, `plugins.lock.json`)

| Plugin | Purpose |
|---|---|
| [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) | Zsh framework (`git` plugin) |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | History-based suggestions |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Command highlighting |
| [zsh-autocomplete](https://github.com/marlonrichert/zsh-autocomplete) | Live completion menu |
| [tpm](https://github.com/tmux-plugins/tpm) | tmux plugin manager |
| [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) + [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) | Save/restore sessions |
| [tmux-yank](https://github.com/tmux-plugins/tmux-yank) | Copy to system clipboard |
| [tmux-open](https://github.com/tmux-plugins/tmux-open) | Open selection as file/URL/search |
| [tmux-cpu](https://github.com/tmux-plugins/tmux-cpu) | CPU/RAM in status bar |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Move between tmux panes and Neovim splits |

Both profiles install all of these.

### Neovim (`lazy-lock.json`, `nvim-plugins.lock.json`)

[LazyVim](https://github.com/LazyVim/LazyVim) with the Catppuccin Mocha theme and
these extras: blink.cmp, yanky, inc-rename, JSON, Markdown, mini.comment,
mini.surround, mini.files, Snacks explorer and picker. Also vim-fugitive,
vim-slime, venv-selector with nvim-dap-python, and incline. bufferline and
mini.pairs are disabled. Treesitter's `tree-sitter` CLI and language servers are
installed by Mason on first launch.

### Ubuntu packages (`install-deps.sh`, via apt)

| Group | Packages | cli | desktop |
|---|---|:-:|:-:|
| Base | git, curl, ca-certificates, unzip, jq | ✓ | ✓ |
| Build / runtimes | build-essential, python3, python3-pip, python3-venv, nodejs, npm | ✓ | ✓ |
| Shell / terminal | zsh, tmux, fzf, ripgrep, fd-find, eza, zoxide | ✓ | ✓ |
| Extra build tools | cmake, ninja-build, gettext, pkg-config, libtool-bin, autoconf, automake, vim | | ✓ |
| Window manager | i3-wm, i3blocks, i3lock, xss-lock, rofi, dunst, picom, feh, libnotify-bin | | ✓ |
| Apps | alacritty, firefox, thunar, flameshot, xfce4-clipman, pavucontrol | | ✓ |
| X11 / clipboard | xclip, xsel, x11-xserver-utils, x11-utils, xinput | | ✓ |
| Network / audio / Bluetooth | network-manager, network-manager-gnome, pipewire, wireplumber, playerctl, bluez | | ✓ |
| Input / power / display | ibus, ibus-unikey, power-profiles-daemon, brightnessctl, bc | | ✓ |
| Fonts | fontconfig, fonts-dejavu | | ✓ |

### Configs linked by `install.sh`

| Path | cli | desktop |
|---|:-:|:-:|
| `.zshrc`, `.zsh_aliases` | ✓ | ✓ |
| `.tmux.conf` | ✓ | ✓ |
| `.gitconfig`, `.config/git/` | ✓ | ✓ |
| `.config/nvim/` | ✓ | ✓ |
| `.config/i3/`, `.config/i3blocks/` | | ✓ |
| `.config/rofi/`, `.config/dunst/`, `.config/picom/` | | ✓ |
| `.config/alacritty/` | | ✓ |

## Terminal-only (SSH/dev hosts)

For servers you SSH into, install just zsh, tmux, Git and Neovim, with no
desktop packages, i3/rofi/dunst/picom/alacritty configs, or Nerd Font:

```sh
./install-cli.sh --dry-run
./install-cli.sh --apply
```

It runs `install-deps.sh --profile cli`, `install.sh --profile cli` and
`sync-plugins.sh`. The CLI profile links `.zshrc`, `.zsh_aliases`, `.tmux.conf`,
`.gitconfig`, `.config/git` and `.config/nvim`, and installs Neovim, Starship,
Yazi, lazygit and the shell/tmux plugins. Icons render with the font of the
terminal you connect from, so the server needs no font.

The dependency installer installs Ubuntu packages, checksummed Neovim, Starship,
Yazi, lazygit, Iosevka Nerd Font, and shell/tmux plugins at locked Git commits.
Neovim plugin repositories are first checked out using `nvim-plugins.lock.json`,
then restored using `lazy-lock.json`; first interactive launch may download language
servers through Mason. Node/npm and Python build prerequisites are included.
Ubuntu packages and Mason downloads follow their upstream repositories; this is
a reproducible configuration bootstrap, not a byte-identical OS image.
Network access and sudo are needed for a fresh dependency installation.

`install.sh` links individual files, leaving unrelated files in place. Existing
conflicting files (including broken symlinks) move to
`~/.local/state/dotfiles/backups/<timestamp>/` with their relative paths preserved.
Repeat runs skip correct links. To restore, remove the relevant symlink and move
the matching backup file back to its original location. Keep this repo in place:
the links point into it. `--target /some/home` supports testing or alternate homes.
Symlinked parent directories are refused to prevent writes into another tree.

## Local settings

Keep secrets, company aliases, cloud setup, and machine details outside this repo:

- `~/.zshrc.local`: tokens, private aliases, NVM/cloud initialization, private PATH additions.
- `~/.gitconfig.local`: Git identity and an appropriate installed credential helper.
- `~/.config/i3/local.sh`: optional executable for wallpaper, monitor layout and input-device settings.

Example Git identity:

```sh
git config --file ~/.gitconfig.local user.name 'Your Name'
git config --file ~/.gitconfig.local user.email 'you@example.com'
```

The VPN status block appears only if a local `vvpn` command is available. VPN
software and credentials are intentionally not installed. Vietnamese input uses
the packaged IBus Unikey engine; choose/configure it in `ibus-setup` once per user.
Brightness uses brightnessctl and its system-provided device permissions; hardware
without a backlight may show `?`. Audio requires a functioning user PipeWire session.
Bluetooth and power controls depend on available hardware and supported profiles.
Firefox installation may use Ubuntu's Snap integration. Ghostty's existing config
was empty, so no Ghostty dependency or empty config is included.
AI CLIs and work-specific tmux launch commands require your separately installed CLIs.

## Updates and checks

Edit linked configs normally, inspect `git diff`, then commit and push. Never copy
all of `~/.config` into this repo. Histories, browser profiles, credentials, caches,
installed plugins, backups and work scripts are excluded.

```sh
python3 -m unittest discover -s tests -v
bash -n install.sh install-deps.sh sync-plugins.sh
./install-deps.sh --dry-run
```

Update release URLs and SHA256 digests in `releases.lock.json` together after
reviewing upstream releases. Update Git SHAs in `plugins.lock.json` deliberately. Keep `nvim-plugins.lock.json`
commits aligned with `home/.config/nvim/lazy-lock.json` when upgrading Neovim plugins.
The installer refuses dirty plugin checkouts and existing non-symlink executables.
Neovim bootstrap follows its lockfile commit. `sync-plugins.sh` restores locked
revisions; use `:Lazy update` deliberately and review lockfile changes to upgrade.

Installation references: [Neovim](https://neovim.io/doc/install/),
[Starship](https://starship.rs/guide/), [Nerd Fonts](https://www.nerdfonts.com/font-downloads).
