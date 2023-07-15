local M = {}
local neogit = require('neogit')

function M.setup()
  neogit.setup {
    kind = "floating"
  }
end

return M

