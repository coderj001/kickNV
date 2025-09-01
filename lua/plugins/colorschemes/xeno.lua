if true then
  return {
    'kyza0d/xeno.nvim',
    lazy = false,
    priority = 1000, -- Load colorscheme early
    config = function()
      require('xeno').new_theme('xeno-golden-hour', {
        base = '#1E1E1E',
        accent = '#8CBE8C',
        contrast = 0,
        variation = 0,
        transparent = require('core').plugin_groups.ui.transparent_background,
      })
    end,
  }
end
