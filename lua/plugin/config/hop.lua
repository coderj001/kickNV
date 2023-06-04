local M = {}
local keymap = require("core.default_config").keymap

function M.setup()
  local hop = require('hop')
  hop.setup {
    term_seq_bias = 0.5,
    keys = 'etovxqpdygfblzhckisuran',
  }
  local directions = require('hop.hint').HintDirection
  -- keymap({ 'n', 'v' }, 'f',
  --   function()
  --     hop.hint_char1({
  --       direction = directions.AFTER_CURSOR,
  --       current_line_only = true,
  --     })
  --   end,
  --   { remap = true })
  -- keymap({ 'n', 'v' }, 'F',
  --   function()
  --     hop.hint_char1(
  --       {
  --         direction = directions.BEFORE_CURSOR,
  --         current_line_only = true,
  --       }
  --     )
  --   end,
  --   { remap = true })
  -- keymap({ 'n', 'v' }, 't',
  --   function()
  --     hop.hint_char1(
  --       {
  --         direction = directions.AFTER_CURSOR,
  --         current_line_only = true,
  --         hint_offset = -1,
  --       }
  --     )
  --   end,
  --   { remap = true })
  -- keymap({ 'n', 'v' }, 'T',
  --   function()
  --     hop.hint_char1({
  --       direction = directions.BEFORE_CURSOR,
  --       current_line_only = true,
  --       hint_offset = 1,
  --     })
  --   end,
  --   { remap = true })
  -- keymap({ 'n', 'v' }, '<leader>w', function() hop.hint_words() end, {})
  -- keymap({ 'n', 'v' }, '<leader>k', function() hop.hint_lines() end, {})
  -- keymap('n', '<leader>c', function() hop.hint_char1() end, {})
  -- keymap('n', '<leader>C', function() hop.hint_char2() end, {})
  -- keymap('n', '<leader>m', function() hop.hint_patterns() end, {})
end

return M
