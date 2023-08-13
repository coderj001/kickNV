local M = {}

function M.setup()
  require('gitsigns').setup {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 1000,
      ignore_whitespace = false
    },
    current_line_blame_formatter_opts = { relative_time = true },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = 40000,
    preview_config = {
      border = "shadow",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1
    }
  }
end

return M
