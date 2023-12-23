local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local opts = {
  install = {
    colorscheme = {},
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
}

local color_scheme = require("config.defaults").config.colorscheme

require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.lsp" },
    { import = "plugins.extras.explorer" },
    -- ColorScheme
    { import = "plugins.colorschemes." .. color_scheme },
    -- StatusLine Select One
    -- { import = "plugins.extras.statusline.lualine" },
    { import = "plugins.extras.statusline.luafancy" },
    -- { import = "plugins.extras.statusline.galaxyline" },
    -- Added required configs
    -- { import = "plugins.extras.lsp" },
    { import = "plugins.extras.dashboard.bufferline" },
    { import = "plugins.extras.wilder" },
    { import = "plugins.extras.figlet" },
    { import = "plugins.extras.tmux" },
    { import = "plugins.extras.scalpel" },
    { import = "plugins.extras.harpoon" },
    { import = "plugins.extras.coding.refactoring" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  checker = { enabled = false },
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
}, opts)
