-- File manager
return {
  "nvim-tree/nvim-tree.lua",
  version = "nightly",
  event = "VimEnter",
  config = function()
    require("plugins.extras.nvimtree").setup()
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
