local M = {}

function M.setup()
  vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
  require('indent_blankline').setup {
    char = '┊',
    buftype_exclude = { "terminal" },
    show_trailing_blankline_indent = false,
    show_current_context = true,
    -- show_current_context_start = true,
    filetype_exclude = {
      "help",
      "terminal",
      "alpha",
      "nvim-tree",
      "neogit",
      "diffview",
      "NeogitPopup"
    },
    context_patterns = {
      "class",
      "function",
      "method",
      "^if",
      "^while",
      "^for",
      "^object",
      "^table",
      "^type",
      "^import",
      "block",
      "arguments"
    },
    use_treesitter = true,
    space_char_blankline = " ",
    char_highlight_list = {
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent2",
      "IndentBlanklineIndent3",
      "IndentBlanklineIndent4",
      "IndentBlanklineIndent5",
      "IndentBlanklineIndent6",
      "IndentBlanklineIndent7",
      "IndentBlanklineIndent8",
      "IndentBlanklineIndent9",
      "IndentBlanklineIndent10",
    },
  }
end

return M
