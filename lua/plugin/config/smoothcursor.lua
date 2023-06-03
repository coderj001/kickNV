local M = {}

function M.setup()
  require("smoothcursor").setup({
    cursor = "",
    fancy = {
      enable = true,
      head = {
        cursor = "",
        texthl = "SmoothCursor",
        linehl = nil,
      }
    }
  })
end

return M
