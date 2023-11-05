if true then
  return {
    "nvim-lualine/lualine.nvim",
    event = "UIEnter",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
      "meuter/lualine-so-fancy.nvim",
    },
    config = function()
      require("utils.luafancy").setup()
    end,
  }
end

