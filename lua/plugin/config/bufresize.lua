local M = {}
local opts = require("core.default_config").opts

function M.setup()
  require("bufresize").setup({
    register = {
      keys = {
        { "n", "<leader>=", "<C-w>=", opts },
        { "n", "<leader>|", "<C-w>|", opts },
      },
      trigger_events = { "BufWinEnter", "WinEnter" },
    },
    resize = {
      keys = {},
      trigger_events = { "VimResized" },
      increment = false,
    },
  })
end

return M
