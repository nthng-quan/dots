#!/bin/sh
# kitty scrollback_pager: show stdin (ANSI scrollback) in nvim with colors.
# Unique temp file + no swap (-n) so a killed pager never blocks the next one.
f=$(mktemp /tmp/kitty-scrollback.XXXXXX)
cat >"$f"
exec nvim -n -u NONE \
  -c 'set nonumber norelativenumber nolist showtabline=0 foldcolumn=0 laststatus=0 signcolumn=no clipboard=unnamedplus' \
  -c 'nnoremap <silent> q :qa!<CR>' \
  -c "terminal cat '$f'; rm -f '$f'; exec sleep 2147483647" \
  -c 'call timer_start(150, {-> [execute("normal! G"), search("\\S", "bW")]})'
