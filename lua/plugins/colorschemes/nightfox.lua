if true then
  return {
    "EdenEast/nightfox.nvim",
    enabled = true,
    priority = 1000,
    config = function()
      require('nightfox').setup({
        options = {
          compile_path = vim.fn.stdpath("cache") .. "/nightfox",
          compile_file_suffix = "_compiled",
          transparent = require("core").plugin_groups.ui.transparent_background,
          terminal_colors = true,
          dim_inactive = true,
          styles = {
            comments = "italic",
            functions = "italic,bold",
            keywords = "bold",
            numbers = "NONE",
            strings = "NONE",
            types = "italic,bold",
            variables = "altfont",
          },
          inverse = {
            match_paren = true,
            visual = true,
            search = true,
          },
        },
        custom_highlights = function(colors)
          return {
            TelescopeSelection = { bg = "NONE", fg = colors.fg_gutter },
            TelescopePromptCounter = { fg = colors.fg_gutter },
            TelescopePromptPrefix = { fg = colors.red },
            TelescopePromptNormal = { bg = "NONE" },
            TelescopeResultsNormal = { bg = "NONE" },
            TelescopePreviewNormal = { bg = "NONE" },
            TelescopePromptBorder = { bg = "NONE", fg = colors.bg_highlight },
            TelescopeResultsBorder = { bg = "NONE", fg = colors.bg_dark },
            TelescopePreviewBorder = { bg = "NONE", fg = colors.bg_dark },
            TelescopePromptTitle = { fg = colors.bg_highlight, bg = colors.red },
            TelescopeResultsTitle = { fg = colors.bg_dark, bg = "NONE" },
            TelescopePreviewTitle = { fg = colors.bg_dark, bg = "NONE" }
          }
        end,
        palette = {
          carbonfox = {}
        },
        specs = {
          all = {
            inactive = "NONE",
            syntax = {
              keyword = "magenta",

              conditional = "magenta.bright",
              number = "orange.dim",
            },
            git = {
              changed = "#f4a261",
            },
          },
        },
        groups = {
          all = {
            NormalNC   = { fg = "NONE", bg = "inactive" },
            ["@feild"] = { fg = "palette.yellow" },
            Whitespace = { link = "Comment" },
            IncSearch  = { fg = "NONE" },
          },
        },
      })
    end
  }
end
