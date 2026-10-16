#!/usr/bin/env bash
set -euo pipefail
export PATH="$HOME/.local/bin:$PATH"
root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
command -v nvim >/dev/null
python3 "$root/scripts/bootstrap.py" --nvim-only
lock="$root/home/.config/nvim/lazy-lock.json"
backup=$(mktemp)
cp -- "$lock" "$backup"
trap 'cp -- "$backup" "$lock"; rm -f -- "$backup"' EXIT
export DOTFILES_BOOTSTRAP=1
nvim --headless '+Lazy! restore' +qa
printf 'Neovim plugins restored from lazy-lock.json.
'
