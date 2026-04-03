vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.wrap = false
opt.linebreak = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.updatetime = 200
opt.timeoutlen = 400
opt.ignorecase = true
opt.smartcase = true
opt.splitbelow = true
opt.splitright = true
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.breakindent = true
opt.clipboard = "unnamedplus"
opt.completeopt = { "menuone", "noselect" }

vim.diagnostic.config({
  signs = true,
  underline = true,
  virtual_text = false,
  update_in_insert = false,
  severity_sort = true,
})
