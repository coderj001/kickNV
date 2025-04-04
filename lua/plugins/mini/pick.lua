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
    window = {
      config = function()
        local height = math.floor(0.4 * vim.o.lines)
        local width = math.floor(0.99 * vim.o.columns)
        return {
          anchor = "NW",
          height = height,
          width = width,
          row = math.floor(0.85 * (vim.o.lines - height)),
          col = math.floor(0.0 * (vim.o.columns - width)),
        }
      end,
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
  map("n", "<leader>sf", ":Pick files<cr>", { noremap = true, silent = true, desc = "Search files" })
  map("n", "<leader>se", ":Pick explorer<cr>", { noremap = true, silent = true, desc = "Search in Explorer" })
  map("n", "<leader>sm", ":Pick hipatterns<cr>", { noremap = true, silent = true, desc = "Search for Markers" })
  map("n", "<leader>sgc", ':Pick git_commits path="%"<cr>',
    { noremap = true, silent = true, desc = "Search buffer commits" })
  map("n", "<leader>sgC", ":Pick git_commits<cr>", { noremap = true, silent = true, desc = "Search commits" })
  map("n", "<leader>sgb", ":Pick git_branches<cr>", { noremap = true, silent = true, desc = "Search branches" })
  map("n", "<leader>sgc", ':Pick git_commits path="%"<cr>',
    { noremap = true, silent = true, desc = "Search buffer commits" })
  map("n", "<leader>sgf", ":Pick git_files<cr>", { noremap = true, silent = true, desc = "Search git files" })
  map("n", "<leader>sgu", ':Pick git_hunks scope="unstaged"<cr>',
    { noremap = true, silent = true, desc = "Search git hunks unstaged" })
  map("n", "<leader><leader>", ":Pick buffers<cr>", { noremap = true, silent = true, desc = "Buffers" })
  map("n", "<leader>,", ":Pick resume<cr>", { noremap = true, silent = true, desc = "Resume" })
  map("n", "<leader>:", ":Pick commands<cr>", { noremap = true, silent = true, desc = "Commands" })
  map("n", "<leader>?", ":Pick oldfiles<cr>", { noremap = true, silent = true, desc = "Oldfiles" })
  map("n", "<leader>g", ":Pick grep pattern=<cword><cr>", { noremap = true, silent = true, desc = "Grep" })
  map("n", "<leader>/", ":Pick grep_live<cr>", { noremap = true, silent = true, desc = "Live Grep" })
  map("n", "<leader>y", ":Pick registers<cr>", { noremap = true, silent = true, desc = "Register" })
  -- Nmap("<leader>fX", ':Pick diagnostic scope="all"<CR>', "Search workspace diagnostics")
  -- Nmap("<leader>fY", ':Pick lsp scope="workspace_symbol"<CR>', "Search workspace symbols")
  -- Nmap("<leader>ft", ":Pick treesitter<CR>", "Search treesitter tree")
  -- Nmap("<leader>fx", ':Pick diagnostic scope="current"<CR>', "Search document diagnostics")
  -- Nmap("<leader>fy", ':Pick lsp scope="document_symbol"<CR>', "Search document symbols")
end

return M
