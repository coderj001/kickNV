-- mini.comment configuration
local M = {}

function M.setup()
  require('mini.comment').setup({
 mappings = {
    comment = 'gc',
    comment_line = 'gcc',
    comment_visual = 'gc',
    textobject = 'gc',
  },
  -- Hook functions to be executed at certain stage of commenting
  hooks = {
    -- Before successful commenting. Does nothing by default.
    pre = function() end,
    -- After successful commenting. Does nothing by default.
    post = function() end,
  },
    })
end

return M

