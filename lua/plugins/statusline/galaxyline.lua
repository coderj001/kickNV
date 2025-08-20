return {
  "glepnir/galaxyline.nvim",
  name = "galaxyline",
  event = "VeryLazy",
  requires = { "nvim-tree/nvim-web-devicons", opt = true },
  config = function()
    require("utils.galaxyline").setup()
  end,
}
