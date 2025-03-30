return {
    "cpea2506/relative-toggle.nvim",
    config = function()
      local status, relativetoggle = pcall(require, "relative-toggle")
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
  }
