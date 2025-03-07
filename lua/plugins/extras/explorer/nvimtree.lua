return {
  "nvim-tree/nvim-tree.lua",
  version = "nightly",
  event = "VimEnter",
  keys = {
    { "<leader>n", mode = { "n" }, "<CMD>NvimTreeToggle<CR>", desc = "NvimTree Explorer" },
  },
  config = function()
    require("utils.nvimtree").setup()
  end,
}
