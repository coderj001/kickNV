-- Status Line

return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("plugins.extras.lualine").setup()
  end,
  dependencies = {
    "kyazdani42/nvim-web-devicons",
  }
}
