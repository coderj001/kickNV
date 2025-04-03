-- mini.jump2d configuration
local M = {}

function M.setup()
  require('mini.jump2d').setup({
    view = {
      dim = true,
      n_steps_ahead = 0,
    },
    mappings = {
      start_jumping = 's'
    },
    allowed_windows = {
      current = true,
      not_current = false,
    },

  })
end

return M
