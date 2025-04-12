-- mini.bufremove configuration
local M = {}
local keymap = vim.api.nvim_set_keymap

function M.setup()
  require('mini.bufremove').setup({
    set_vim_settings = true,
    silent = true,
  })
  keymap("n", "<leader>bl", ":lua MiniBufremove.unshow()<cr>", { silent = true, noremap = true, desc = "Buffer unshow" })
  keymap("n", "<leader>bk", ":lua MiniBufremove.wipeout()<cr>", { silent = true, noremap = true, desc = "Buffer unshow" })
end

return M

