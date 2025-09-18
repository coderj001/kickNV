local M = {}

-- Define plugin groups that can be enabled/disabled
M.plugin_groups = {
  basic = true, -- Essential plugins that should always be loaded
  ui = {
    install = 'github',
    colorscheme = 'github_dark',
    fallback_colorscheme = 'darkblue',
    transparent_background = true,
  }, -- UI enhancements
  lsp = true, -- Language servers and diagnostics
  completion = true, -- Completion plugins
  treesitter = true, -- Treesitter and related plugins
  editor = true, -- Editor enhancements
  git = true, -- Git integrations
  neogit = false, -- Git UI
  mini = {
    core = true,
    animation = true,
    indentscope = true,
    notify = true,
    pick = false,
    files = false,
    extra = true,
    ui = true,
    move = true,
    ai_move = true,
  },
  oil = true,
  statusline = 'lualine',
  -- autocomplete
  cmp = false,
  blink = true,
  scissors = true,
  -- Explorer
  nvimtree = false,
  telescope = true,
  flash = true,
  bqf = true,
  trouble = true,
  noice = true,
  cursor = false,
  rest = false,
  ai = false,
}

function M.setup()
  require 'core.options'
  require 'core.keymaps'

  -- Initialize plugin manager
  require('core.lazy').setup()

  -- Setup colorscheme
  require('core.colors').setup()
end

return M
