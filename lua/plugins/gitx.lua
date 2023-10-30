-- Git Integration
return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.extras.gitsigns").setup()
    end
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "sindrets/diffview.nvim",
        lazy = true,
        enabled = true,
        event = "BufRead",
      }
    },
    config = function()
      require("plugins.extras.neogit").setup()
    end
  },
}
