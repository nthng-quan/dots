#!/bin/sh
# kitty scrollback_pager: show stdin (ANSI scrollback) in nvim with colors.
# Args from kitty: INPUT_LINE_NUMBER CURSOR_LINE CURSOR_COLUMN, used to put the
# nvim cursor where the terminal cursor was (falls back to the last line).
# Unique temp file + no swap (-n) so a killed pager never blocks the next one.
input_line=${1:-0} cursor_line=${2:-0} cursor_col=${3:-0}
f=$(mktemp /tmp/kitty-scrollback.XXXXXX)
cat >"$f"
exec nvim -n -u NONE \
  -c 'set nonumber norelativenumber nolist showtabline=0 foldcolumn=0 laststatus=0 signcolumn=no clipboard=unnamedplus' \
  -c 'nnoremap <silent> q :qa!<CR>' \
  -c "terminal cat '$f'; rm -f '$f'; exec sleep 2147483647" \
  -c "call timer_start(150, {-> $cursor_line > 0 ? cursor(max([0, $input_line - 1]) + $cursor_line, $cursor_col) : [execute('normal! G'), search('\\S', 'bW')]})"
