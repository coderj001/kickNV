local M = {}
local status, relativetoggle = pcall(require, "relative-toggle")

function M.setup()
  if (not status) then return end
  relativetoggle.setup({
    pattern = "*",
    events = {
      on = {
        "BufEnter",
        "FocusGained",
        "InsertLeave",
        "WinEnter",
        "CmdlineLeave",
      },
      off = {
        "BufLeave",
        "FocusLost",
        "InsertEnter",
        "WinLeave",
        "CmdlineEnter",
      },
    },
  })
end

return M
