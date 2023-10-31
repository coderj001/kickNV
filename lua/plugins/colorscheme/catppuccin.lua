if true then
  return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        background = {
          dark = "mocha",
        },
        -- TODO: Need to make it universal for transparent
        transparent_background = false,
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
          flash = true,
          alpha = true,
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = true,
          neogit = true,
          treesitter_context = true,
          ts_rainbow2 = true,
          ts_rainbow = true,
          indent_blankline = { enabled = true },
          mason = true,
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
  }
end
