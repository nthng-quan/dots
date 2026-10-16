#!/usr/bin/env bash
# Ubuntu 24.04 amd64. Run as your normal user; only apt uses sudo.
set -euo pipefail
root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
mode=${1:---dry-run}
case "$mode" in --dry-run|--apply) ;; *) echo 'Usage: ./install-deps.sh [--dry-run|--apply]' >&2; exit 2;; esac
. /etc/os-release
[[ "$ID" == ubuntu && "$VERSION_ID" == 24.04 && $(uname -m) == x86_64 ]] || { echo 'Supported target: Ubuntu 24.04 x86_64' >&2; exit 1; }
packages=(git curl ca-certificates unzip python3 python3-pip python3-venv build-essential cmake ninja-build gettext pkg-config libtool-bin autoconf automake zsh tmux vim fzf ripgrep fd-find eza zoxide jq nodejs npm xclip xsel i3-wm i3blocks i3lock rofi dunst picom alacritty flameshot thunar firefox feh xss-lock x11-xserver-utils x11-utils xinput xfce4-clipman network-manager network-manager-gnome wireplumber pipewire playerctl pavucontrol bluez ibus ibus-unikey power-profiles-daemon libnotify-bin brightnessctl bc fontconfig fonts-dejavu)
if [[ "$mode" == --dry-run ]]; then
  printf 'sudo apt-get install -y'; printf ' %q' "${packages[@]}"; printf '\n'
  python3 "$root/scripts/bootstrap.py" --dry-run
  exit
fi
[[ $EUID != 0 ]] || { echo 'Run as your normal user, not root.' >&2; exit 1; }
sudo apt-get update
sudo apt-get install -y "${packages[@]}"
python3 "$root/scripts/bootstrap.py"
printf '\nNext: ./install.sh, then ./sync-plugins.sh\n'
