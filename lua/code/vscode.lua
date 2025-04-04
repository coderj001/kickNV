local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", ",", "", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

keymap("n", "<leader><Enter>", ":nohlsearch<CR>", opts)

-- better indent handling
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- move text up and down
keymap("v", "J", ":m .+1<CR>==", opts)
keymap("v", "K", ":m .-2<CR>==", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- paste preserves primal yanked piece
keymap("v", "p", '"_dP', opts)

-- removes highlighting after escaping vim search
keymap("n", "<Esc>", "<Esc>:nohl<CR>", opts)

require "vscode".action("editor.action.formatDocument")



vim.api.nvim_set_keymap('n', '<C-j>', '<cmd>lua require("vscode").action("workbench.action.navigateDown")<CR>',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '<C-j>', '<cmd>lua require("vscode").action("workbench.action.navigateDown")<CR>',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua require("vscode").action("workbench.action.navigateUp")<CR>',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '<C-k>', '<cmd>lua require("vscode").action("workbench.action.navigateUp")<CR>',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<cmd>lua require("vscode").action("workbench.action.navigateLeft")<CR>',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '<C-h>', '<cmd>lua require("vscode").action("workbench.action.navigateLeft")<CR>',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<cmd>lua require("vscode").action("workbench.action.navigateRight")<CR>',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '<C-l>', '<cmd>lua require("vscode").action("workbench.action.navigateRight")<CR>',
  { noremap = true, silent = true })

keymap("x", "gc", "<Plug>VSCodeCommentary", { silent = true })
keymap("n", "gc", "<Plug>VSCodeCommentary", { silent = true })
keymap("o", "gc", "<Plug>VSCodeCommentary", { silent = true })
keymap("n", "gcc", "<Plug>VSCodeCommentaryLine", { silent = true })


-- harpoon keymaps
keymap({ "n", "v" }, "<leader>ha", "<cmd>lua require('vscode').action('vscode-harpoon.addEditor')<CR>", opts)
keymap({ "n", "v" }, "<leader>ho", "<cmd>lua require('vscode').action('vscode-harpoon.editorQuickPick')<CR>", opts)
keymap({ "n", "v" }, "<leader>he", "<cmd>lua require('vscode').action('vscode-harpoon.editEditors')<CR>", opts)
keymap({ "n", "v" }, "<leader>h1", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor1')<CR>", opts)
keymap({ "n", "v" }, "<leader>h2", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor2')<CR>", opts)
keymap({ "n", "v" }, "<leader>h3", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor3')<CR>", opts)
keymap({ "n", "v" }, "<leader>h4", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor4')<CR>", opts)
keymap({ "n", "v" }, "<leader>h5", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor5')<CR>", opts)
keymap({ "n", "v" }, "<leader>h6", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor6')<CR>", opts)
keymap({ "n", "v" }, "<leader>h7", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor7')<CR>", opts)
keymap({ "n", "v" }, "<leader>h8", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor8')<CR>", opts)
keymap({ "n", "v" }, "<leader>h9", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor9')<CR>", opts)

local fold = {
  toggle = function()
    vim.fn.VSCodeNotify("editor.toggleFold")
  end,

  all = function()
    vim.fn.VSCodeNotify("editor.foldAll")
  end,
  openAll = function()
    vim.fn.VSCodeNotify("editor.unfoldAll")
  end,

  close = function()
    vim.fn.VSCodeNotify("editor.fold")
  end,
  open = function()
    vim.fn.VSCodeNotify("editor.unfold")
  end,
  openRecursive = function()
    vim.fn.VSCodeNotify("editor.unfoldRecursively")
  end,

  blockComment = function()
    vim.fn.VSCodeNotify("editor.foldAllBlockComments")
  end,

  allMarkerRegion = function()
    vim.fn.VSCodeNotify("editor.foldAllMarkerRegions")
  end,
  openAllMarkerRegion = function()
    vim.fn.VSCodeNotify("editor.unfoldAllMarkerRegions")
  end,
}



--folding
keymap({ 'n' }, "zr", fold.openAll)
keymap({ 'n' }, "zO", fold.openRecursive)
keymap({ 'n' }, "zo", fold.open)
keymap({ 'n' }, "zm", fold.all)
keymap({ 'n' }, "zb", fold.blockComment)
keymap({ 'n' }, "zc", fold.close)
keymap({ 'n' }, "zg", fold.allMarkerRegion)
keymap({ 'n' }, "zG", fold.openAllMarkerRegion)
keymap({ 'n' }, "za", fold.toggle)
--#endregion keymap
