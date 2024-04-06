require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
local color_scheme = require("config.defaults").config.colorscheme
vim.cmd("colorscheme " .. color_scheme)
if not vim.fn.exists('$TMUX') then
  if vim.fn.has('nvim') == 1 then
    -- For Neovim 0.1.3 and 0.1.4
    vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
  end
  -- For Neovim > 0.1.5 and Vim > patch 7.4.1799
  -- Based on Vim patch 7.4.1770 (`guicolors` option)
  if vim.fn.has('termguicolors') == 1 then
    vim.opt.termguicolors = true
  end
end

