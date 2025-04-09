-- mini.operators configuration
local M = {}

function M.setup()
  require('mini.operators').setup({
    replace = {
      prefix = 'ge',
    },
  })
end

return M
