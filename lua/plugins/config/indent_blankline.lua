-- Your Neovim Lua configuration
local M = {}

function M.setup()
  -- Highlight colors for indent levels
  local highlight = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
    "IndentBlanklineIndent7",
  }

  local hooks = require "ibl.hooks"
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "IndentBlanklineIndent2", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "IndentBlanklineIndent3", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "IndentBlanklineIndent4", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "IndentBlanklineIndent5", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "IndentBlanklineIndent6", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "IndentBlanklineIndent7", { fg = "#56B6C2" })
  end)


  require('ibl').setup {
    indent = { highlight = highlight, char = '┊', },
    whitespace = {
      highlight = highlight,
      remove_blankline_trail = false,
    },
  }
end

return M
