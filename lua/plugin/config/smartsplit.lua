local M = {}

function M.setup()
  -- Smart Split Config
  require("smart-splits").setup {
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
