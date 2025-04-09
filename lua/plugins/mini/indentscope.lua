-- mini.indentscope configuration
local M = {}

function M.setup()
  -- Migrated from your existing config
  require('mini.indentscope').setup({
    symbol = '│',
    options = { try_as_border = true },
    -- Additional options
    draw = {
      -- Delay (in ms) between event and start of drawing scope indicator
      delay = 100,

      -- Animation rule for scope's first drawing. A function which, given
      -- next and total step numbers, returns wait time (in ms). See
      -- |MiniIndentscope.gen_animation| for builtin options.
      -- animation = --<function: implements constant 20ms between steps>,
    },
  })
end

return M
