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
end

return M
