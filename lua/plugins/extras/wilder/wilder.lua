return {
  'gelguy/wilder.nvim',
  config = function()
    local wilder = require("wilder")
    wilder.setup({
      modes = { ":" },
      next_key = "<C-j>",
      previous_key = "<C-k>",
    })
    wilder.set_option('renderer', wilder.popupmenu_renderer(
      wilder.popupmenu_palette_theme({
        border = 'rounded',
        max_height = '60%',
        min_height = 0,
        prompt_position = 'top',
        reverse = 0,
        highlighter = wilder.basic_highlighter(),
        left = { ' ', wilder.popupmenu_devicons() },
        right = { ' ', wilder.popupmenu_scrollbar() },
      })
    ))
  end,
  build = ':UpdateRemotePlugins'
}
