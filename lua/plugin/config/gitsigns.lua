local M = {}

function M.setup()
  require('gitsigns').setup {
    signs = {
      add = {
        -- text = '+',
        text = "▎",
        hl = "GitSignsAdd",
        numhl = "GitSignsAddNr",
        linehl = "GitSignsAddLn",
      },
      delete = {
        -- text = "-",
        text = "_",
        hl = "GitSignsDelete",
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
      change = {
        -- text = "±",
        text = "▎",
        hl = "GitSignsChange",
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
      changedelete = {
        -- text = '~',
        text = "▎",
        hl = "GitSignsDelete",
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
      topdelete = {
        text = '‾',
        hl = "GitSignsDelete",
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
    },
    numhl = false,
    linehl = false,
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
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
