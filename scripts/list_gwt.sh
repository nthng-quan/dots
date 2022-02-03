#!/bin/bash

# CONFIG
CACHE_FILE="$HOME/.gitrepo_cache"

if [[ ! -f "$CACHE_FILE" ]]; then
  echo "Cache not found: $CACHE_FILE"
  echo "Run the scanning script first."
  exit 1
fi

# COLLECT WORKTREES
WORKTREES=()

while IFS= read -r repo; do
  if [[ -d "$repo" ]]; then
    cd "$repo" || continue
    git worktree list --porcelain | awk -v repo="$repo" '
            /^worktree / {
                wt=$2;
                if (wt == repo) {
                    print "main ─ " wt
                } else {
                    print "extra ─ " wt
                }
            }
        '
  fi
done <"$CACHE_FILE" >/tmp/git_worktrees_list.txt

# CHECK IF EMPTY
if [[ ! -s /tmp/git_worktrees_list.txt ]]; then
  echo "No Git worktrees found in cache."
  exit 0
fi

# FZF MENU
SELECTED=$(fzf --prompt="Git Worktrees > " --height=40% --reverse </tmp/git_worktrees_list.txt)

# EXTRACT PATH
CHOSEN_PATH=$(echo "$SELECTED" | sed -E 's/.*─ //g')

if [[ -n "$CHOSEN_PATH" ]]; then
  echo "Selected: $CHOSEN_PATH"
  # Optional: cd into it
  cd "$CHOSEN_PATH"
  exec $SHELL
fi
