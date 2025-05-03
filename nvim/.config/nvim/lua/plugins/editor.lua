return {
  { "github/copilot.vim" },
  { "echasnovski/mini.pairs", enabled = false },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  {
    "folke/flash.nvim",
    keys = {
      { "s", false },
      { "t", false },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      scroll = { enabled = false },
      picker = {
        sources = {
          explorer = { layout = { layout = { position = "right" } } },
        },
        hidden = true,
        ignored = true,
      },
    },
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
    keys = (function()
      local keys = {}
      for i = 1, 9 do
        table.insert(keys, {
          "gb" .. i,
          string.format("<cmd>LualineBuffersJump! %d<cr>", i),
          desc = "Go to buffer " .. i,
        })
      end
      return keys
    end)(),
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
