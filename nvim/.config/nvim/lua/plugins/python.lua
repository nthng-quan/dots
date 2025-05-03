return {
  {
    "jpalardy/vim-slime",
    keys = {
      { "<leader>rC", "<cmd>SlimeConfig<cr>", desc = "Slime Config" },
      { "<leader>rc", "<Plug>SlimeSendCell<BAR>/^# %%<CR>", desc = "Slime Send Cell" },
      { "<leader>rs", ":<C-u>'<,'>SlimeSend<CR>", mode = "v", desc = "Slime Send Selection" },
    },
    config = function()
      vim.g.slime_no_mappings = 1 -- disable C-c default mapping
      vim.g.slime_target = "tmux"
      vim.g.slime_cell_delimiter = "# %%"
      vim.g.slime_default_config = { socket_name = "default", target_pane = "{right-of}" }
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_bracketed_paste = 1
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    opts = {
      search = false, -- only use envs from the list
      auto_refresh = false,
      -- use env CONDA_ENVS (conda info -- envs directories)
      stay_on_this_version = true,
      anaconda_envs_path = os.getenv("CONDA_ENVS"),
      -- anaconda_envs_path = "/home/nthquan/mnt/data/conda_home/envs/",
    },
    event = "VeryLazy",
    keys = {
      { "C-c", false }, -- disable Ctrl-C
      { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Python venv" },
      { "<leader>vS", "<cmd>VenvSelectCached<cr>", desc = "Select Python venv (cached)" },
    },
  },
}
