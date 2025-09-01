-- mini.animation configuration
local M = {}

function M.setup()
  require('mini.animate').setup {
    cursor = {
      enable = false,
    },
    open = {
      enable = true,
    },
    close = {
      enable = true,
    },
    scroll = {
      enable = false,
    },
  }
end

return M
