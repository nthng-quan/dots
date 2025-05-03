return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    local actived_venv = function()
      local venv_name = require("venv-selector").get_active_venv()
      if venv_name ~= nil then
        return string.gsub(venv_name, ".*/conda_home/envs/", "")
      else
        return "-"
      end
    end

    local icons = LazyVim.config.icons
    vim.o.laststatus = vim.g.lualine_laststatus
    local opts = {
      options = {
        theme = "auto",
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = {
          statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" },
          winbar = { "dashboard", "alpha", "ministarter", "snacks_dashboard" },
          tabline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" },
        },
        -- component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        section_separators = "",
        component_separators = "|",
        always_show_tabline = true,
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return str:sub(1, 3)
            end,
          },
        },
        lualine_b = {
          { "branch" },
          { "diff" },
        },
        lualine_c = {
          {
            LazyVim.lualine.pretty_path({ filename_hl = "Bold", modified_sign = "[+]" }),
            separator = "", -- align with navic
          },
          { "navic", color_correction = "dynamic" },
        },
        lualine_x = {
          Snacks.profiler.status(),
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = function() return { fg = Snacks.util.color("Statement") } end,
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = function() return { fg = Snacks.util.color("Constant") } end,
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = function() return { fg = Snacks.util.color("Debug") } end,
          },
          -- stylua: ignore
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function() return { fg = Snacks.util.color("Special") } end,
          },
        },
        lualine_y = {
          { "filetype", icon_only = false, separator = "", padding = { left = 1, right = 0 } },
          {
            function()
              local venv_name = actived_venv()
              if venv_name ~= nil and vim.bo.filetype == "python" then
                return "@ " .. venv_name
              else
                return "-"
              end
            end,
          },
          -- { "branch" },
        },
        lualine_z = {
          { "progress", separator = "|", padding = { left = 1, right = 1 } },
          { "location", padding = { left = 0, right = 1 } },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          { LazyVim.lualine.pretty_path() },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      --
      -- TABLINE
      --
      tabline = {
        lualine_a = {
          {
            "buffers",
            show_filename_only = true,
            hide_filename_extension = false,
            show_modified_status = true,
            mode = 2,
          },
        },
        lualine_b = {
          { "diagnostics" },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          { "tabs", mode = 2 },
        },
      },
      extensions = { "neo-tree", "lazy", "fzf" },
    }

    return opts
  end,
}
