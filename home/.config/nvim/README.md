# Neovim (LazyVim)

[LazyVim](https://github.com/LazyVim/LazyVim) on Neovim 0.11. `<leader>` = Space;
press it and wait for the which-key menu to list everything. Extras are enabled
in `lua/config/lazy.lua`; overrides and extra plugins live in `lua/plugins/`.

## Look (`ui.lua`, `lualine.lua`)

| Plugin | What it does here |
|---|---|
| [catppuccin](https://github.com/catppuccin/nvim) | Mocha theme, transparent background (the kitty background shows through) |
| [lualine](https://github.com/nvim-lualine/lualine.nvim) | status line: mode, branch, diff, DAP state, filetype, **active Python venv**, position. Tabline lists open buffers; `gb1`…`gb9` jumps to buffer N |
| [incline](https://github.com/b0o/incline.nvim) | floating file name + icon in the top-right of each split |
| Snacks dashboard | start screen without the ASCII header |
| ~~bufferline~~ | disabled (`disable.lua`): lualine's buffer tabline replaces it |

## Editing (LazyVim extras)

| Plugin | Use |
|---|---|
| [blink.cmp](https://github.com/Saghen/blink.cmp) | completion menu (LSP, snippets, paths, buffer words); snippets in `snippets/` |
| [yanky](https://github.com/gbprod/yanky.nvim) | yank history: `p` then `[y` / `]y` cycles older yanks; `<leader>p` opens the history |
| [inc-rename](https://github.com/smjonas/inc-rename.nvim) | `<leader>cr` renames a symbol with a live preview of every change |
| [mini.comment](https://github.com/echasnovski/mini.comment) | `gcc` comments a line, `gc` + motion / visual comments a range |
| [mini.surround](https://github.com/echasnovski/mini.surround) | `gsa` add, `gsd` delete, `gsr` replace surrounding quotes/brackets/tags |
| [flash](https://github.com/folke/flash.nvim) | jump labels; its `s` and `t` keys are turned off, so they keep Vim's meaning |
| ~~mini.pairs~~ | disabled: no auto-inserted closing brackets |

## Files and search

| Plugin | Use |
|---|---|
| Snacks picker | fuzzy finder: `<leader><space>` files, `<leader>/` grep, `<leader>,` buffers. Shows hidden and git-ignored files |
| Snacks explorer | file tree on the **right**: `<leader>e` |
| [mini.files](https://github.com/echasnovski/mini.files) | column file browser, edit the listing like a buffer to rename/move: `<leader>fm` |
| [yazi.nvim](https://github.com/mikavilpas/yazi.nvim) | Yazi in a float: `<leader>zf` at the current file, `<leader>zc` at the cwd, `Ctrl+Up` resumes the last session |

## Git (`git.lua`)

| Plugin | Use |
|---|---|
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | `:Git` status (stage with `s`, commit with `cc`), `:Git blame`, `:Gdiffsplit` |
| [gitsigns](https://github.com/lewis6991/gitsigns.nvim) | gutter marks `+` / `~` / `>`; `]h` / `[h` next/prev hunk, `<leader>gh…` hunk actions |

## Python (`python.lua`, `coding.lua`)

| Plugin | Use |
|---|---|
| [vim-slime](https://github.com/jpalardy/vim-slime) | REPL workflow: run `ipython` in the tmux pane on the right, split code with `# %%`, then `<leader>rc` sends the cell, `<leader>rs` (visual) the selection, `<leader>rC` re-targets |
| [venv-selector](https://github.com/linux-cultist/venv-selector.nvim) | `<leader>vs` pick a venv / conda env (also from `$CONDA_ENVS`), `<leader>vS` reuse the cached one; the LSP restarts in it and lualine shows it |
| [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) | debug adapter for the selected venv, pulled in by venv-selector. No debug keymaps are set (the LazyVim `dap.core` extra is off); lualine shows the DAP status |
| basedpyright | type checker LSP in `standard` mode, reports unused imports |
| [conform](https://github.com/stevearc/conform.nvim) | format on save: `ruff_format` (Python), `stylua`, `shfmt` |

## Languages

JSON (schemas via SchemaStore) and Markdown (preview with `<leader>cp`, render in
buffer, `marksman` LSP) extras. Mason installs language servers and formatters
on first interactive launch; headless bootstrap skips it (`bootstrap.lua`).

## Versions

Pinned in `lazy-lock.json`; `nvim-plugins.lock.json` in the repo root must match
it. `sync-plugins.sh` restores both. Upgrade with `:Lazy update`, then review the
lockfile diff.
