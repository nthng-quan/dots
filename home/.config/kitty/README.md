# kitty

Default terminal (i3 `$term`). Iosevka Nerd Font Mono 14, Catppuccin Mocha,
powerline tab bar at the bottom, low-latency rendering, copy on select.

| Key | Action |
|---|---|
| `Ctrl+Shift+=` / `-` / `Backspace` | font bigger / smaller / reset |
| `Ctrl+Shift+Space` | scrollback in nvim (opens at the cursor position; `q` or the same key closes) |
| `Shift+Enter` | sends `Esc Enter` (newline in CLI agents) |
| `Ctrl+Shift+F5` | reload config |

- `scrollback-pager.sh`: shows the scrollback with colors in a bare nvim
  (`-u NONE`, no swap file), via a temp file.
- Remote control is on a per-instance socket (`unix:@kitty-<pid>`), so
  `kitten @` works from inside kitty.
- `kitten ssh` (alias `s` in `.zsh_aliases`) copies kitty's terminfo to hosts.
- Images in tmux: `.tmux.conf` enables passthrough, and `.zshrc` sets the omp
  image env vars when the tmux client is kitty.
