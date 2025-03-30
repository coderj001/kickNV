return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.hipatterns').setup({
      highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
      },
    })
    -- mini.trailspace - highlight trailing whitespace
    require('mini.trailspace').setup()
    -- mini.pairs - auto-close pairs like (), {}, []
    require('mini.pairs').setup()

    -- mini.clue - show next key clues
    require('mini.clue').setup({
      -- Clue window options
      window = {
        -- Show delay (in ms)
        delay = 300,
        -- Window config (styled as float)
        config = {
          width = 40,
          border = 'rounded',
        },
      },
      -- Triggers that show the clue window
      triggers = {
        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },

        -- `g` key
        { mode = 'n', keys = 'g' },

        -- Marks
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },

        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },

        -- Window commands
        { mode = 'n', keys = '<C-w>' },

        -- `z` key
        { mode = 'n', keys = 'z' },
      },

      clues = {
        -- Enhance this with your own clues
        -- Mini.clue enhances default experience
        require('mini.clue').gen_clues.builtin_completion(),
        require('mini.clue').gen_clues.g(),
        require('mini.clue').gen_clues.marks(),
        require('mini.clue').gen_clues.registers(),
        require('mini.clue').gen_clues.windows(),
        require('mini.clue').gen_clues.z(),
      },
    })
  end
}
