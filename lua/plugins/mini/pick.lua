-- mini.pick configuration
local M = {}
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

function M.setup()
  require('mini.pick').setup({
    delay = {
      async = 10,
      busy = 50,
    },
    mappings = {
      caret_left        = '<Left>',
      caret_right       = '<Right>',

      choose            = '<CR>',
      choose_in_split   = '<C-s>',
      choose_in_tabpage = '<C-t>',
      choose_in_vsplit  = '<C-v>',
      choose_marked     = '<M-CR>',

      delete_char       = '<BS>',
      delete_char_right = '<Del>',
      delete_left       = '<C-u>',
      delete_word       = '<C-w>',

      mark              = '<C-x>',
      mark_all          = '<C-a>',

      move_down         = '<C-j>',
      move_start        = '<C-g>',
      move_up           = '<C-k>',

      paste             = '<C-r>',

      refine            = '<C-Space>',
      refine_marked     = '<M-Space>',

      scroll_down       = '<C-f>',
      scroll_left       = '<C-h>',
      scroll_right      = '<C-l>',
      scroll_up         = '<C-b>',

      stop              = '<C-c>',

      toggle_info       = '<S-Tab>',
      toggle_preview    = '<Tab>',
    },
    options = {
      content_from_bottom = true,
      use_cache = true,
    },
  })
  -- file picker
  map("n", "<leader>sf", ":Pick files<cr>", opts)
  map("n", "<leader><leader>", ":Pick buffers<cr>", opts)
  map("n", "<leader>,", ":Pick resume<cr>", opts)
  map("n", "<leader>g", ":Pick grep<cr>", opts)
  map("n", "<leader>/", ":Pick live_grep<cr>", opts)
end

return M
