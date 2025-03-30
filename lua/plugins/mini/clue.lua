-- mini.clue configuration
local M = {}

function M.setup()
  -- Migrated from your existing config
  require('mini.clue').setup({
    triggers = {
      -- Leader triggers
      { mode = 'n', keys = '<Leader>' },
      { mode = 'x', keys = '<Leader>' },

      -- Window commands
      { mode = 'n', keys = '<C-w>' },

      -- Common key triggers
      { mode = 'n', keys = 'g' },
      { mode = 'n', keys = 'z' },
      { mode = 'n', keys = "'" },
      { mode = 'n', keys = '`' },
      { mode = 'n', keys = '"' },
    },
    window = {
      delay = 300,
      config = { border = 'rounded' },
    },
    -- Enhanced clue setup with more descriptive clues for common operations
    clues = {
      -- Enhance built-in mini.clue descriptions
      require('mini.clue').gen_clues.builtin_completion(),
      require('mini.clue').gen_clues.g(),
      require('mini.clue').gen_clues.marks(),
      require('mini.clue').gen_clues.registers(),
      require('mini.clue').gen_clues.windows(),
      require('mini.clue').gen_clues.z(),
      
      -- Custom clues for leader mappings
      { mode = 'n', keys = '<Leader>f', desc = 'Format buffer' },
      { mode = 'n', keys = '<Leader>w', desc = 'Save file' },
      { mode = 'n', keys = '<Leader>sf', desc = 'Search files' },
      { mode = 'n', keys = '<Leader>sg', desc = 'Search by grep' },
      { mode = 'n', keys = '<Leader>?', desc = 'Recent files' },
    },
  })
end

return M
