---@module 'core'
---@description Core Neovim configuration module
---@author KickNV
---@license MIT

local M = {}

--- Plugin groups configuration
--- Controls which plugins and features are enabled/disabled
---@class PluginGroups
M.plugin_groups = {
  -- Core essential plugins (always loaded)
  basic = true, --- Essential plugins: escape, gx, lastplace, noice, etc.

  -- UI and appearance
  ui = {
    install = 'github', --- Colorscheme to install: 'github', 'tokyonight', 'kanagawa', 'catppuccin'
    colorscheme = 'github_dark', --- Active colorscheme name
    fallback_colorscheme = 'darkblue', --- Fallback if primary colorscheme fails
    transparent_background = true, --- Enable transparent background
  },

  -- Language features
  lsp = true, --- Language Server Protocol: mason, lspconfig, conform
  treesitter = true, --- Treesitter syntax highlighting and parsing

  -- Completion systems (mutually exclusive - only enable one)
  cmp = false, --- nvim-cmp completion engine
  blink = true, --- blink.cmp completion engine (lightweight alternative)

  -- Navigation and file management
  telescope = true, --- Telescope fuzzy finder and picker
  oil = false, --- Oil.nvim file explorer
  nvimtree = true, --- NvimTree file explorer
  flash = true, --- Flash.nvim jump navigation (alternative to mini.jump)

  -- Statusline
  statusline = 'lualine', --- Statusline provider: 'lualine', 'galaxyline', etc.

  -- Git integration
  git = true, --- Git integrations: gitsigns
  neogit = false, --- Neogit UI (can be enabled separately)

  -- Code quality and diagnostics
  trouble = true, --- Trouble diagnostics viewer
  bqf = true, --- Better quickfix list

  -- Debugging
  dap = true, --- Debug Adapter Protocol for TypeScript/JavaScript/Node

  -- Utilities
  scissors = true, --- Scissors snippet engine
  cursor = false, --- Cursor enhancements
  rest = false, --- REST client for Neovim
  ai = false, --- AI coding assistants (Copilot, Codeium, Ollama)

  -- Mini.nvim modules (modular plugin suite)
  mini = {
    core = true, --- Core modules: align, bracketed, clue, comment, etc.
    animation = true, --- Animate transitions
    indentscope = true, --- Indent scope indicators
    notify = true, --- Notification system
    pick = false, --- Pick UI (alternative to telescope)
    files = false, --- Mini.Files file explorer (disabled in favor of NvimTree)
    extra = true, --- Extra utilities
    ui = true, --- UI components (icons)
    move = true, --- Text movement enhancements
    ai_move = true, --- AI-powered text movement and surround
  },

  -- Legacy/deprecated (kept for compatibility)
  completion = true, --- Legacy completion flag (not used)
  editor = true, --- Legacy editor flag (not used)
  noice = true, --- Noice UI (part of basic plugins)
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
