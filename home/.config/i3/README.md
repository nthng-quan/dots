# i3 + i3blocks

Window manager config (`config`), status bar blocks (`*-block.sh`, laid out in
[`../i3blocks/config`](../i3blocks/config)) and helper scripts. Catppuccin Mocha
colors come from `colors.sh`; blocks print through `output` in `block.sh`.

## Keys (`$mod` = Super)

| Key | Action |
|---|---|
| `$mod+Return` / `$mod+Shift+Return` | terminal (kitty) / browser |
| `$mod+d`, `+Shift+d`, `+Ctrl+d` | rofi: apps, windows, run |
| `$mod+h/j/k/l` (+`Shift`) | focus (move) window |
| `$mod+b` / `$mod+v` | next window opens beside / below |
| `$mod+e` / `+s` / `+w` | toggle split direction / stacked / tabbed |
| `$mod+f`, `$mod+Shift+space` | fullscreen, floating |
| `$mod+1…0` (+`Shift`) | go to (move window to) workspace |
| `$mod+r` | resize mode |
| `$mod+Shift+q` | close window |
| `$mod+x` / `$mod+Shift+x` | lock / lock and suspend |
| `$mod+Ctrl+n` | next wallpaper |
| `$mod+Ctrl+Shift+c` | caffeine (no sleep) |
| `$mod+Ctrl+u` | toggle English / Vietnamese input |
| `$mod+Shift+b`, `$mod+Ctrl+b` | Bluetooth power, bluetoothctl |
| `$mod+Ctrl+w`, `$mod+Ctrl+p` | nmtui, power profile |
| `$mod+Shift+m` | pavucontrol |
| `Print`, `Shift+Print`, `Ctrl+Print` | flameshot area, full, launcher |
| Media / volume / mic / brightness keys | as labelled; the bar updates instantly |
| `$mod+Shift+c` / `$mod+Shift+r` / `$mod+Shift+e` | reload / restart / exit i3 |

## Bar blocks (left to right)

| Block | Shows | Click |
|---|---|---|
| window | focused window title | |
| caffeine | `CAF` when sleep is blocked | toggle |
| media | player and title, max 40 chars; green while playing | control menu |
| ⏮ ⏯ ⏭ | media buttons | prev / play-pause / next |
| volume | output volume, `MUTE` | left: mute, scroll: ±2%, right: pavucontrol |
| display | `HDMI - eDP`, active screens lit, primary first; only with an external monitor | left: external only ↔ laptop only, right: both (external primary, at its highest refresh rate) |
| mic | `MIC 80%`, red `MIC OFF` | left: mute, scroll: ±5%, right: pavucontrol inputs |
| brightness | `BRT %` | |
| vpn | green `VPN` when the private `vvpn` (openvpn3 wrapper) is connected; hidden when `vvpn` isn't on `PATH` | |
| power | power profile | |
| battery, date | | |

## Background scripts

- `wallpaper-cycle.sh`: rotates images in `~/Pictures/wallpapers/ocean` every 15
  min (`WALLPAPER_INTERVAL` seconds). The images aren't in this repo.
- `monitor-watch.sh`: when the last external monitor is unplugged, turns the
  laptop screen back on, so an external-only layout can't leave you with no screen.
- `local.sh` (untracked, optional, executable): per-machine extras such as
  touchpad, monitor layout or a fixed wallpaper; i3 runs it on every start/restart.
