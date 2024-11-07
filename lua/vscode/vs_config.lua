local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

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
keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)

require "vscode".action("editor.action.formatDocument")

vim.api.nvim_create_user_command('Nu', function()
  vim.api.nvim_create_user_command("Nu", function()
    require "vscode".call("settings.cycle.relativeLineNumbers")
  end, {})

  vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    callback = function()
      vim.cmd("Nu")
    end,
  })

  vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
      vim.cmd("Nu")
    end,
  })
end, {})


vim.api.nvim_set_keymap('n', '<C-j>', '<cmd>lua require("vscode").action("workbench.action.navigateDown")<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', '<C-j>', '<cmd>lua require("vscode").action("workbench.action.navigateDown")<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua require("vscode").action("workbench.action.navigateUp")<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', '<C-k>', '<cmd>lua require("vscode").action("workbench.action.navigateUp")<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-h>', '<cmd>lua require("vscode").action("workbench.action.navigateLeft")<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', '<C-h>', '<cmd>lua require("vscode").action("workbench.action.navigateLeft")<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<cmd>lua require("vscode").action("workbench.action.navigateRight")<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', '<C-l>', '<cmd>lua require("vscode").action("workbench.action.navigateRight")<CR>', {noremap = true, silent = true})

