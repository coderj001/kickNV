local M = {}

function M.setup()
  require("relative-toggle").setup({
    pattern = "*",
    events = {
      on = { "BufEnter", "FocusGained", "InsertLeave", "WinEnter", "CmdlineLeave" },
      off = { "BufLeave", "FocusLost", "InsertEnter", "WinLeave", "CmdlineEnter" },
    },
  })
end

return M
