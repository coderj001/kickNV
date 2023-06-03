local M = {}

function M.setup()
  require("notify").setup({
    stages = "fade_in_slide_out",
    render = "compact",
    timeout = 1500,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
    background_colour = "Normal",
    minimum_width = 26,
    icons = {
      ERROR = "",
      WARN = "",
      INFO = "",
      DEBUG = "",
      TRACE = "✎"
    }
  })
end

return M
