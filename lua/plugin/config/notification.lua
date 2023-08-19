local M = {}
local notify = require("notify")

function M.setup()
  notify.setup({
    stages = "fade_in_slide_out",
    render = "compact",
    timeout = 1500,
    fps = 20,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
    background_colour = "#000000",
    minimum_width = 26,
    icons = {
      ERROR = "",
      WARN = "",
      INFO = "",
      DEBUG = "",
      TRACE = "✎",
    }
  })
  vim.notify = notify
end

return M
