return {
  "scottmckendry/cyberdream.nvim",
  name = "cyberdream",
  lazy = false,
  priority = 1000,
  config = function ()
    require("cyberdream").setup({
      ariant = "default",
      transparent = require("core").plugin_groups.ui.transparent_background,
      saturation = 1,
      italic_comments = true,
      hide_fillchars = true,
      borderless_pickers = false,
      cache = true,
      overrides = function(colors) -- NOTE: This function nullifies the `highlights` option
        return {
          Comment = { fg = "#7b8496", bg = "NONE", italic = true },
          ["@property"] = { fg = colors.magenta, bold = true, italic = true },
          ["@string"] = { fg = colors.green },
        }
      end,
      extensions = {
        telescope = true,
        notify = true,
        mini = true,
      },
    })
  end
}
