-- mini.surround configuration
local M = {}

function M.setup()
  -- You already have this in your config, just moved to a dedicated module
    require('mini.surround').setup({
-- Configure mappings if needed
  mappings = {
    add = 'sa', -- Add surrounding
    delete = 'sd', -- Delete surrounding
    find = 'sf', -- Find surrounding (to the right)
    find_left = 'sF', -- Find surrounding (to the left)
    highlight = 'sh', -- Highlight surrounding
    replace = 'sr', -- Replace surrounding
    update_n_lines = 'sn', -- Update `n_lines`
  },
  })
end

return M
