return {
  "nvim-tree/nvim-tree.lua",
  version = "nightly",
  event = "VimEnter",
  keys = {
    { "<leader>e", mode = { "n" }, "<CMD>NvimTreeToggle<CR>", desc = "NvimTree Explorer" },
  },
  config = function()
    require("utils.nvimtree").setup()
  end,
  dependencies = {
    {
      "antosha417/nvim-lsp-file-operations",
      config = function()
        require("lsp-file-operations").setup()
      end
    }
  }
}
