local M = {}

function M.setup()
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

  local core = require("core")
  local plugin_specs = {}
  
  -- LSP config
  if core.plugin_groups.lsp then
    table.insert(plugin_specs, { import = "plugins.lsp" })
  end

  -- Git
  if core.plugin_groups.git then
    table.insert(plugin_specs, { import = "plugins.git" })
  end

  -- Mini
  table.insert(plugin_specs, {
    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function ()
      if core.plugin_groups.mini.core then
        require("plugins.mini.pairs").setup()
        require("plugins.mini.surround").setup()
        require("plugins.mini.ai").setup()
        require("plugins.mini.indentscope").setup()
        require("plugins.mini.clue").setup()
      end
    end
    })
  
  require("lazy").setup(plugin_specs, {
    install = { colorscheme = { "nightfox", "tokyonight" } },
    checker = { enabled = true, notify = false },
    change_detection = { notify = false },
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin",
        }
      }
    }
  })
end

return M
