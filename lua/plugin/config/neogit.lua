local M = {}
local neogit = require('neogit')

function M.setup()
  neogit.setup {
    kind = "vsplit",
    integrations = {
      telescope = true,
      diffview = true,

    }
  }
end

return M
