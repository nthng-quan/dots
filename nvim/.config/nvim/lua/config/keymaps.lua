-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
-- local opts = { noremap = true, silent = true }

keymap.set("i", "jj", "<ESC>", { silent = true })
-- <leader>su
-- keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle)

-- Vibé
vim.g.copilot_no_tab_map = true
keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})

vim.diagnostic.config({
  signs = true,
  underline = true,
  float = {
    border = "rounded",
    focusable = true,
  },
})
