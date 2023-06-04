local M = {}
local smart_splits = require "smart-splits"
local opts = require("core.default_config").opts
local keymap = require("core.default_config").keymap

function M.setup()
  smart_splits.setup {
    ignored_filetypes = { 'nofile', 'quickfix', 'prompt' },
    ignored_buftypes = { 'NvimTree' },
    resize_mode = {
      silent = true,
      hooks = {
        on_leave = require("bufresize").register
      }
    }
  }

  -- keymaps
  keymap("n", "<C-j>", ":lua require('smart-splits').move_cursor_down()<cr>", opts)

  -- Move to the split below the current one
  keymap("n", "<C-k>", ":lua require('smart-splits').move_cursor_up()<cr>", opts)

  -- Move to the split to the left of the current one
  keymap("n", "<C-h>", ":lua require('smart-splits').move_cursor_left()<cr>", opts)

  -- Move to the split to the right of the current one
  keymap("n", "<C-l>", ":lua require('smart-splits').move_cursor_right()<cr>",
    opts)
end

return M
