local keymap = vim.api.nvim_set_keymap
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local expr_opts = { expr = true, silent = true }

keymap("n", "<leader>aa", ":hide<cr>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("n", "<leader>v", ":vsp<cr>", opts)
keymap("n", "<leader>V", ":sp<cr>", opts)

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", expr_opts)
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", expr_opts)

-- Resize window using <ctrl> arrow keys
map("n", "<C-Down>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Up>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move text up and down
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Clear search with <leader><Enter>
map({ "i", "n" }, "<leader><Enter>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Save file
map("n", "<leader>w", "<cmd>w<cr>", opts)

function load_extra_options()
  local function bind_extra_cmd(options)
    for optionCount = 1, #options do vim.cmd(options[optionCount]) end
  end
  local options = {
    "filetype plugin on", "filetype indent on", "cabbr Q q", "cabbr Q! q!",
    "cabbr W! w!", "cabbr W w", "cabbr WA wa", "cabbr Wa wa", "cabbr Wq wq",
    "cabbr WQ wq", "cabbr Qa qa", "cabbr QA qa"
  }
  bind_extra_cmd(options)
end

load_extra_options()
