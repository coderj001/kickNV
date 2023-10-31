if true then
  return {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      require('kanagawa').setup({
        compile = true,
        commentStyle = { italic = true },
        functionStyle = { italic = true },
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,
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
    end
  }
end
