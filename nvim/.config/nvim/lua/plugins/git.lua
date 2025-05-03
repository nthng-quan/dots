return {
  { "tpope/vim-fugitive" },
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      opts.signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = ">" },
        topdelete = { text = ">" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      }
      opts.signs_staged = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = ">" },
        topdelete = { text = ">" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      }
      opts.current_line_blame = true
    end,
  },
}
