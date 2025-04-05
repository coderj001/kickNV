-- mini.files configuration
local M = {}

function M.setup()
  local mini_files = require('mini.files')

  mini_files.setup({
    -- Customization options
    options = {
      use_as_default_explorer = true,
      windows = {
        -- Floating window settings
        preview = true,
        width_focus = 30,
        width_preview = 40,
      },

      mappings = {
        close       = 'q',
        go_in       = 'l',
        go_in_plus  = 'L',
        go_out      = 'h',
        go_out_plus = 'H',
        reset       = '<BS>',
        reveal_cwd  = '@',
        show_help   = 'g?',
        synchronize = '=',
        trim_left   = '<',
        trim_right  = '>',
      },
    },
  })

  -- Add keybindings for mini.files
  -- <leader>fe - Open file explorer at current file
  vim.keymap.set("n", "<leader>fe", function()
    mini_files.open(vim.api.nvim_buf_get_name(0))
  end, { desc = "Open file explorer at current file" })

  -- <leader>fE - Open file explorer at current working directory
  vim.keymap.set("n", "<leader>fE", function()
    mini_files.open()
  end, { desc = "Open file explorer at cwd" })

  -- <leader>ft - Toggle file explorer at current file
  vim.keymap.set("n", "<leader>ft", function()
    if not mini_files.close() then
      mini_files.open(vim.api.nvim_buf_get_name(0))
    end
  end, { desc = "Toggle file explorer" })
end

return M
