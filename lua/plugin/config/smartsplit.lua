local M = {}
local smart_splits = require "smart-splits"

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
  vim.api.nvim_set_keymap("n", "<C-j>", ":lua require('smart-splits').move_cursor_down()<cr>",
    { noremap = true, silent = true })

  -- Move to the split below the current one
  vim.api.nvim_set_keymap("n", "<C-k>", ":lua require('smart-splits').move_cursor_up()<cr>",
    { noremap = true, silent = true })

  -- Move to the split to the left of the current one
  vim.api.nvim_set_keymap("n", "<C-h>", ":lua require('smart-splits').move_cursor_left()<cr>",
    { noremap = true, silent = true })

  -- Move to the split to the right of the current one
  vim.api.nvim_set_keymap("n", "<C-l>", ":lua require('smart-splits').move_cursor_right()<cr>",
    { noremap = true, silent = true })
end

return M
