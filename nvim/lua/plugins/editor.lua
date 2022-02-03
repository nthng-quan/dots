return {
  { "github/copilot.vim" },
  { "echasnovski/mini.pairs", enabled = false },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  {
    "folke/flash.nvim",
    keys = { { "s", false } },
  },
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      LazyVim.lsp.on_attach(function(client, buffer)
        if client.supports_method("textDocument/documentSymbol") then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = function()
      return {
        separator = "  ",
        highlight = true,
        depth_limit = 5,
        icons = LazyVim.config.icons.kinds,
        lazy_update_context = true,
      }
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    keys = {
      { "<leader>1", "<cmd>LualineBuffersJump! 1<cr>", desc = "Go to buffer 1" },
      { "<leader>2", "<cmd>LualineBuffersJump! 2<cr>", desc = "Go to buffer 2" },
      { "<leader>3", "<cmd>LualineBuffersJump! 3<cr>", desc = "Go to buffer 3" },
      { "<leader>4", "<cmd>LualineBuffersJump! 4<cr>", desc = "Go to buffer 4" },
      { "<leader>5", "<cmd>LualineBuffersJump! 5<cr>", desc = "Go to buffer 5" },
    },
  },
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = { "folke/snacks.nvim" },
    keys = {
      { "<leader>zf", mode = { "n", "v" }, "<cmd>Yazi<cr>", desc = "Open yazi at the current file" },
      { "<leader>zc", "<cmd>Yazi cwd<cr>", desc = "Open the file manager in nvim's working directory" },
      { "<c-up>", "<cmd>Yazi toggle<cr>", desc = "Resume the last yazi session" },
    },

    ---@type YaziConfig | {}
    opts = {
      open_for_directories = false,
      keymaps = { show_help = "<f1>" },
    },
    init = function()
      vim.g.loaded_netrwPlugin = 1
    end,
  },
}
