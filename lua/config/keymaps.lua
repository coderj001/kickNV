local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("n", "<leader><Enter>", ":nohlsearch<cr>", {})
keymap("n", "<leader>aa", ":hide<cr>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("n", "<leader>v", ":vsp<cr>", opts)
keymap("n", "<leader>V", ":sp<cr>", opts)
