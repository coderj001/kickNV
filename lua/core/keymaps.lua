---@diagnostic disable: lowercase-global
local keymap = vim.api.nvim_set_keymap
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local expr_opts = { expr = true, silent = true }

keymap('n', '<leader>aa', ':hide<cr>', { silent = true, noremap = true, desc = 'hide' })
keymap('n', 'q', '<CMD>cclose<CR>', { noremap = true, silent = true, desc = 'quit quickfix' })

-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- better up/down
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", expr_opts)
map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", expr_opts)
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", expr_opts)
map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", expr_opts)

-- Resize window using <ctrl> arrow keys
map('n', '<C-Down>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
map('n', '<C-Up>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
map('n', '<C-Right>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
map('n', '<C-Left>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

-- Clear search with <leader><Enter>
vim.keymap.set('n', '<leader><CR>', ':nohlsearch<CR>', {
  silent = true,
  noremap = true,
  desc = 'Clear highlight',
})

-- Save file
map('n', '<leader>w', '<cmd>w<cr>', { noremap = true, silent = true, desc = 'Save file' })

-- Buffer navigation
map('n', '<leader>bn', '<cmd>bnext<cr>', { noremap = true, silent = true, desc = 'Next buffer' })
map('n', '<leader>bp', '<cmd>bprev<cr>', { noremap = true, silent = true, desc = 'Previous buffer' })
map('n', '<leader>bd', '<cmd>bd<cr>', { noremap = true, silent = true, desc = 'Delete buffer' })
map('n', '<leader>bD', '<cmd>bd!<cr>', { noremap = true, silent = true, desc = 'Force delete buffer' })

-- Window navigation (Alt + hjkl)
map('n', '<A-h>', '<C-w>h', { noremap = true, silent = true, desc = 'Window left' })
map('n', '<A-j>', '<C-w>j', { noremap = true, silent = true, desc = 'Window down' })
map('n', '<A-k>', '<C-w>k', { noremap = true, silent = true, desc = 'Window up' })
map('n', '<A-l>', '<C-w>l', { noremap = true, silent = true, desc = 'Window right' })

-- Window splits
map('n', '<leader>ws', '<cmd>split<cr>', { noremap = true, silent = true, desc = 'Split horizontal' })
map('n', '<leader>wv', '<cmd>vsplit<cr>', { noremap = true, silent = true, desc = 'Split vertical' })
map('n', '<leader>wc', '<cmd>close<cr>', { noremap = true, silent = true, desc = 'Close window' })

-- Quick actions
map('n', '<leader>q', '<cmd>q<cr>', { noremap = true, silent = true, desc = 'Quit' })
map('n', '<leader>Q', '<cmd>q!<cr>', { noremap = true, silent = true, desc = 'Quit without saving' })
map('n', '<leader>x', '<cmd>x<cr>', { noremap = true, silent = true, desc = 'Save and quit' })

-- Quick format (conform)
map('n', '<leader>f', function()
  local conform = require('conform')
  if conform then
    conform.format { async = true, lsp_fallback = true }
  end
end, { noremap = true, silent = true, desc = 'Format buffer (conform)' })

-- Diagnostics navigation
map('n', '[d', vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = 'Previous diagnostic' })
map('n', ']d', vim.diagnostic.goto_next, { noremap = true, silent = true, desc = 'Next diagnostic' })
map('n', '<leader>de', vim.diagnostic.open_float, { noremap = true, silent = true, desc = 'Show diagnostic' })

function load_extra_options()
  local function bind_extra_cmd(options)
    for optionCount = 1, #options do
      vim.cmd(options[optionCount])
    end
  end
  local options = {
    'filetype plugin on',
    'filetype indent on',
    'cabbr Q q',
    'cabbr Q! q!',
    'cabbr W! w!',
    'cabbr W w',
    'cabbr WA wa',
    'cabbr Wa wa',
    'cabbr Wq wq',
    'cabbr WQ wq',
    'cabbr Qa qa',
    'cabbr QA qa',
  }
  bind_extra_cmd(options)
end

load_extra_options()
