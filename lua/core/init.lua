local M = {}

-- Define plugin groups that can be enabled/disabled
M.plugin_groups = {
  core = true,           -- Essential plugins that should always be loaded
  ui = true,             -- UI enhancements
  lsp = true,            -- Language servers and diagnostics
  completion = true,     -- Completion plugins
  treesitter = true,     -- Treesitter and related plugins
  editor = true,         -- Editor enhancements
  git = true,            -- Git integrations
  tools = true,          -- Additional tools
  debug = false,         -- Debugging plugins (load on demand)
  mini = false,          -- mini plugins
}

function M.setup()
  require("core.options")
  -- require("core.keymaps")
  -- require("core.autocmds")
  
  -- Initialize plugin manager
  require("core.lazy").setup()
  
  -- Setup colorscheme
  -- require("core.colors").setup()
end

return M
