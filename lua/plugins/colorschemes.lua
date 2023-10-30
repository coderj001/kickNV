local ui = require('config.default').ui

return {
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        style = "moon",
        light_style = "night",
        transparent = ui.transparency,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = { italic = true },
          variables = { italic = true },
          sidebars = "dark",
          floats = "dark",
        },
        sidebars = { "qf", "help" },
        day_brightness = 0.3,
        hide_inactive_statusline = true,
        dim_inactive = true,
        lualine_bold = true,
      })
    end,
  },
  {
    "catppuccin/nvim",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        background = {
          dark = "mocha",
        },
        transparent_background = ui.transparency,
        show_end_of_buffer = false,
        term_colors = true,
        dim_inactive = {
          enabled = false,
          shade = "light",
          percentage = 0.10,
        },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = { "reverse" },
          functions = { "italic" },
          keywords = {},
          strings = {},
          variables = { "italic" },
          numbers = {},
          booleans = { "italic" },
          properties = {},
          types = {},
          operators = {},
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = true,
          neogit = true,
          treesitter_context = true,
          ts_rainbow2 = true,
          ts_rainbow = true,
          telescope = {
            enabled = true,
            style = "nvchad",
          },
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
        },
      })
    end,
  },
}

