-- mini.ai configuration
local M = {}

function M.setup()
  -- Migrated from your existing config with custom treesitter objects
  require('mini.ai').setup({
    n_lines = 500,
    custom_textobjects = {
      o = require('mini.ai').gen_spec.treesitter({
        a = {
          "@block.outer",
          "@conditional.outer",
          "@loop.outer",
        },
        i = {
          "@block.inner",
          "@conditional.inner",
          "@loop.inner",
        },
      }, {}),
      f = require('mini.ai').gen_spec.treesitter(
        {
          a = "@function.outer",
          i = "@function.inner",
        },
        {}
      ),
      c = require('mini.ai').gen_spec.treesitter(
        {
          a = "@class.outer",
          i = "@class.inner",
        },
        {}
      ),
    },
  })
end

return M
