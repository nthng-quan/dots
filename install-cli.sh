#!/usr/bin/env bash
# Terminal-only setup for SSH/dev hosts: zsh, tmux, git, Neovim. No desktop packages or configs.
set -euo pipefail
root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
case "${1:---dry-run}" in
  --dry-run)
    "$root/install-deps.sh" --dry-run --profile cli
    "$root/install.sh" --dry-run --profile cli
    ;;
  --apply)
    "$root/install-deps.sh" --apply --profile cli
    "$root/install.sh" --profile cli
    "$root/sync-plugins.sh"
    ;;
  *) echo 'Usage: ./install-cli.sh [--dry-run|--apply]' >&2; exit 2 ;;
esac
