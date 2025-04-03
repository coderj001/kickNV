-- mini.notify configuration
local M = {}

function M.setup()
  local notify = require('mini.notify')

  notify.setup({
    lsp_progress = {
      enable = true,
      level = 'INFO',
      duration_last = 1000,
    },

    -- Window settings
    window = {
      history = true,
      max_height_per_notify = 5,
      max_width_share = 0.382,
      winblend = 25,
    },
  })

  vim.notify = notify.make_notify({
    ERROR = { duration = 5000 },
    WARN = { duration = 4000 },
    INFO = { duration = 3000 },
  })
end

return M
