return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "pylint",
        "pyright",
        "python-lsp-server",
        "ruff",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "hadolint",
        "isort",
        "jq",
        "json-lsp",
        "lua-language-server",
        "markdown-toc",
        "markdownlint-cli2",
        "marksman",
        "mypy",
        "prettier",
        "shfmt",
        "sql-formatter",
        "sqlfmt",
        "stylua",
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    default_opts = {
      -- LazyVim will use these options when formatting with the conform.nvim formatter
      format = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
      },
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
        -- python = { "black" },
        python = { "ruff_format" },
        json = { "jq" },
      },
      -- The options you set here will be merged with the builtin formatters.
      -- You can also define any custom formatters here.
      formatters = {
        injected = { options = { ignore_errors = true } },
        -- black = {
        --   prepend_args = { "--line-length", "80" },
        -- },
      },
      linters = {
        python = {
          source = { "flake8" },
          args = { "--ignore", "E501,E203" },
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pycodestyle = {
                  ignore = { "E501", "W503" },
                  maxLineLength = 90,
                },
              },
            },
          },
        },
      },
    },
  },
}
