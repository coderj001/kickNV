-- mini.pairs configuration
local M = {}

function M.setup()
  -- You already have this in your config, just moved to a dedicated module
  require('mini.pairs').setup({
    mappings = {
      ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
      ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
    }
  })
end

return M
