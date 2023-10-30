local M = {}

function M.setup()
  require("modes").setup({
    colors = {
      normal = "#ffcb6b",
      insert = "#c3e88d",
      delete = "#f07178",
      copy   = "#f78c6c",
      visual = "#82aaff",
    },
    line_opacity = 0.25,
    set_cursor = true,
    ignore_filetypes = {
      "alpha",
      "NvimTree",
      "TelescopePrompt",
      "NeogitStatus",
      "NeogitPopup",
    }
  })
end

return M
