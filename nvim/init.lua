local source = debug.getinfo(1, "S").source
local config_root = vim.fn.stdpath("config")

if source:sub(1, 1) == "@" then
  config_root = vim.fn.fnamemodify(source:sub(2), ":p:h")
end

vim.opt.runtimepath:prepend(config_root)

require("config.options")
require("config.keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local clone = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({ { clone, "ErrorMsg" } }, true, {})
    error("failed to clone lazy.nvim")
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
