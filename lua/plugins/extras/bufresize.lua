local M                = {}
local opts             = require("config.default").opts
local status, bufresize = pcall(require, "bufresize")

function M.setup()
  if (not status) then return end
  bufresize.setup({
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
