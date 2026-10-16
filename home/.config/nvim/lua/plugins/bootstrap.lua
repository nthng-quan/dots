-- Language tools install on interactive startup, not during a headless restore.
if vim.env.DOTFILES_BOOTSTRAP == "1" then
  return {
    { "mason-org/mason.nvim", enabled = false },
    { "mason-org/mason-lspconfig.nvim", enabled = false },
  }
end
return {}
