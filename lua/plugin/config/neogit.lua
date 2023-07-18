local M = {}
local neogit = require('neogit')

function M.setup()
  neogit.setup {
    kind = "floating",
    integrations = {
      telescope = true,
      diffview = true,

    }
  }
end

return M
