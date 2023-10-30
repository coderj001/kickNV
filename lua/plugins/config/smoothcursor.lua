local M = {}

function M.setup()
  require("smoothcursor").setup({
    cursor = "",
    disable_float_win = true,
    fancy = {
      enable = true,
      head = {
        cursor = "",
        texthl = "SmoothCursor",
        linehl = "cursorline",
      }
    }
  })
end

return M
