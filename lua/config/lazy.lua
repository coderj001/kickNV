local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local success, maybe_error = pcall(
    vim.fn.system, {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    }
  )
  if not success then
    require('plugins.config.notification').error("ERROR: Fail to install plugin manager lazy.nvim", maybe_error)
    require('plugins.config.notification').info("You can cleanup the " .. lazypath .. " and start again")
    return
  end
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.lsp" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = { colorscheme = { "catppuccin" } },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})


require("plugins.config.colorscheme").setup()

-------------------------------
------------ keymaps ----------
-------------------------------
require("config.default").keymaps.default()
