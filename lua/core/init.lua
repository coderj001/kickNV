local M = {}

-- Define plugin groups that can be enabled/disabled
M.plugin_groups = {
  basic = true, -- Essential plugins that should always be loaded
  ui = {
    install = "cyberdream",
    colorscheme = "cyberdream",
    fallback_colorscheme = "darkblue",
    transparent_background = true,
  },                 -- UI enhancements
  lsp = true,        -- Language servers and diagnostics
  completion = true, -- Completion plugins
  treesitter = true, -- Treesitter and related plugins
  editor = true,     -- Editor enhancements
  git = true,        -- Git integrations
  mini = {
    core = true,
    animation = false,
    indentscope = true,
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
  cmp = false,
  blink = true,
  scissors = true,
  -- Explorer
  nvimtree = true,
  telescope = true,
  flash = true,
  bqf = true,
  trouble = true,
  noice = true
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
