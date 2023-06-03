local M = {}

function M.setup()
  require("modes").setup({
    colors = {
      normal = "#8ba4b0",
      insert = "#98bb6c",
      delete = "#ff5370",
      copy = "#f78c6c",
      visual = "#8992a7"
    },
    line_opacity = 0.25,
    set_cursor = true,
    ignore_filetypes = {
      "NvimTree",
      "TelescopePrompt",
    }
  })
end

return M
