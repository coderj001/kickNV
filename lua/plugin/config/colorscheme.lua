local M = {}
local ui = require("core.default_config").ui


function M.setup()
  require('kanagawa').setup({
    compile = true,
    commentStyle = { italic = true },
    functionStyle = { italic = true },
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = ui.transparency,
    theme = "dragon",
    colors = {
      palette = {},
      theme = {
        wave = {},
        lotus = {},
        dragon = {},
        all = {
          ui = {
            bg_gutter = "none"
          }
        }
      },
    },
    overrides = function(colors)
      local theme = colors.theme
      return {
        TelescopeTitle = { bold = true },
        TelescopePromptNormal = { bg = theme.ui.bg_p1, fg = "none" },
        TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = "none" },
        TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = "none" },
        TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = "none" },
        TelescopePreviewNormal = { bg = theme.ui.bg_dim },
        -- TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
        -- NormalFloat = { bg = "none" },
        LineNr = { bg = "none" },
        CursorLineNr = { bg = "none" },
        GitsignsAdd = { bg = "none" },
        GitSignsChange = { bg = "none" },
        GitsignsDelete = { bg = "none" },
      }
    end,
    background = {
      dark = "dragon",
    },
  })

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
    },
  })

  vim.cmd("colorscheme " .. ui.theme)
end

return M
