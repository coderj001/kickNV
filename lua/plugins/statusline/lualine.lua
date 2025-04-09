if true then
  return {
    "nvim-lualine/lualine.nvim",
    name = "lualine",
    event = "UIEnter",
    -- dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("utils.lualine").setup()
    end
  }
end
