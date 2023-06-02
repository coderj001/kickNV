local M = {}

function M.setup()
  require('kanagawa').setup({
    compile = true,
    commentStyle = { italic = true },
    functionStyle = { italic = true },
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = true,
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
      light = "lotus"
    },
  })

  require("tokyonight").setup({
    style = "moon",
    light_style = "night",
    transparent = true,
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
  vim.cmd [[colorscheme tokyonight]]
end

return M
