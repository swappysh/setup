local specs = {
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-tree/nvim-web-devicons", lazy = true },
}

vim.list_extend(specs, require("plugins.editor"))
vim.list_extend(specs, require("plugins.lsp"))

return specs
