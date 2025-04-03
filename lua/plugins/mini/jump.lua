-- mini.jump configuration
local M = {}

function M.setup()
  require('mini.jump').setup({
    delay = {
      highlight = 350,
      idle_stop = 10000000,
    },
    silent = true,
  })
end

return M
