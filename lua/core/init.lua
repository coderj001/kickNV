local M = {}

-- Define plugin groups that can be enabled/disabled
M.plugin_groups = {
  basic = true, -- Essential plugins that should always be loaded
  ui = {
    install = "catppuccin",
    colorscheme = "catppuccin-mocha",
    fallback_colorscheme = "darkblue",
    transparent_background = true,
  },                 -- UI enhancements
  lsp = true,        -- Language servers and diagnostics
  completion = true, -- Completion plugins
  treesitter = true, -- Treesitter and related plugins
  editor = true,     -- Editor enhancements
  git = true,        -- Git integrations
  tools = true,      -- Additional tools
  debug = false,     -- Debugging plugins (load on demand)
  mini = {
    core = true,
    animation = false,
    notify = true,
    pick = false,
    files = true,
    extra = true,
    ui = true,
    move = true,
    ai_move = true,
  },
  statusline = 'lualine',
  -- autocomplete
  cmp = true,
  blink = false,
  -- Explorer
  nvimtree = true,
  telescope = true,
  flash = true,
  bqf = true,
  trouble = true
}

function M.setup()
  require("core.options")
  require("core.keymaps")

  -- Initialize plugin manager
  require("core.lazy").setup()

  -- Setup colorscheme
  require("core.colors").setup()
end

return M
