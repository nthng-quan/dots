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
