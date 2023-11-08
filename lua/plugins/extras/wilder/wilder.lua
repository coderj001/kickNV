return {
  'gelguy/wilder.nvim',
  event = "VimEnter",
  config = function()
    local wilder = require("wilder")
    wilder.setup({
      modes = { ":" },
      next_key = "<C-j>",
      previous_key = "<C-k>",
    })
    wilder.set_option('renderer', wilder.renderer_mux({
        [':'] = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
          highlighter = wilder.basic_highlighter(),
          reverse = 0,
          border = 'rounded',
          left = { ' ', wilder.popupmenu_devicons() },
          right = { ' ', wilder.popupmenu_scrollbar() },
        })),
        ['/'] = wilder.wildmenu_renderer({
          highlighter = {
            wilder.lua_pcre2_highlighter(),
            wilder.lua_fzy_highlighter(),
          },
          pumblend = 20,
          separator = ' · ',
          left = { ' ', wilder.wildmenu_spinner(), ' ' },
          right = { ' ', wilder.wildmenu_index() },
          highlights = {
            accent = wilder.make_hl('WilderAccent', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#f4468f' } }),
          },
        }),
        ['?'] = wilder.wildmenu_renderer({
          highlighter = {
            wilder.lua_pcre2_highlighter(),
            wilder.lua_fzy_highlighter(),
          },
          pumblend = 20,
          separator = ' · ',
          left = { ' ', wilder.wildmenu_spinner(), ' ' },
          right = { ' ', wilder.wildmenu_index() },
          highlights = {
            accent = wilder.make_hl('WilderAccent', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#f4468f' } }),
          },
        }),
      }),
      'pipeline', {
        wilder.branch(
          wilder.python_file_finder_pipeline({
            file_command = { 'rg', '--files' },
            dir_command = { 'fd', '-td' },
            filters = { 'fuzzy_filter', 'difflib_sorter' },
          }),
          wilder.cmdline_pipeline(),
          wilder.python_search_pipeline()
        ),
      }
    )
  end,
  build = ':UpdateRemotePlugins'
}
