return {
  'mawkler/modicator.nvim',
  init = function()
    vim.o.cursorline = true
    vim.o.number = true
    vim.o.termguicolors = true
  end,
  opts = {
    show_warnings = true,
    highlights = {
      defaults = {
        bold = true,
        italic = true,
      }
    }
  }
}
