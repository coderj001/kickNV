---@module 'core.lazy'
---@description Lazy.nvim plugin manager setup and plugin loading logic
---@author KickNV
---@license MIT

local M = {}

--- Plugin import mappings: maps plugin group keys to their import paths
--- Each entry can be a string (simple import) or a function (conditional/complex import)
local PLUGIN_MAPPINGS = {
  -- Core essential plugins
  { key = 'basic', import = 'plugins.basic', desc = 'Essential plugins (always loaded)' },
  { key = 'lsp', import = 'plugins.lsp', desc = 'LSP configuration and language servers' },
  { key = 'treesitter', import = 'plugins.treesitter', desc = 'Treesitter syntax highlighting' },

  -- UI and appearance
  {
    key = 'statusline',
    import = function(groups)
      return 'plugins.statusline'
    end,
    desc = 'Statusline plugin',
  },
  {
    key = 'ui',
    import = function(groups)
      if groups.ui and groups.ui.colorscheme then
        return 'plugins.colorschemes.' .. groups.ui.install
      end
      return nil
    end,
    desc = 'Colorscheme configuration',
  },

  -- Completion systems (mutually exclusive)
  { key = 'cmp', import = 'plugins.cmp', desc = 'nvim-cmp completion engine' },
  { key = 'blink', import = 'plugins.blink', desc = 'blink.cmp completion engine' },

  -- Navigation and file management
  { key = 'telescope', import = 'plugins.telescope', desc = 'Telescope fuzzy finder' },
  { key = 'oil', import = 'plugins.oil', desc = 'Oil.nvim file explorer' },
  { key = 'nvimtree', import = 'plugins.nvimtree', desc = 'NvimTree file explorer (alternative)' },
  { key = 'flash', import = 'plugins.flash', desc = 'Flash.nvim jump navigation' },

  -- Git integration
  { key = 'git', import = 'plugins.git', desc = 'Git integrations (gitsigns, neogit)' },

  -- Code quality and diagnostics
  { key = 'trouble', import = 'plugins.trouble', desc = 'Trouble diagnostics viewer' },
  { key = 'bqf', import = 'plugins.bqf', desc = 'Better quickfix list' },

  -- Utilities
  { key = 'scissors', import = 'plugins.scissors', desc = 'Scissors snippet engine' },
  { key = 'cursor', import = 'plugins.cursor', desc = 'Cursor enhancements' },
  { key = 'rest', import = 'plugins.rest', desc = 'REST client for Neovim' },
  { key = 'ai', import = 'plugins.ai', desc = 'AI coding assistants' },
}

--- Build plugin specs from plugin groups configuration
---@param groups table Plugin groups configuration from core.init
---@return table Plugin specs for lazy.nvim
local function build_plugin_specs(groups)
  local specs = {}

  -- Process simple plugin mappings
  for _, mapping in ipairs(PLUGIN_MAPPINGS) do
    local group_value = groups[mapping.key]
    if group_value then
      local import_path = mapping.import
      if type(import_path) == 'function' then
        import_path = import_path(groups)
      end

      if import_path then
        table.insert(specs, { import = import_path })
      end
    end
  end

  -- Handle telescope harpoon extension
  if groups.telescope then
    table.insert(specs, { import = 'plugins.telescope.harpoon' })
  end

  return specs
end

--- Setup mini.nvim plugin with conditional module loading
---@param groups table Plugin groups configuration
---@return table Mini.nvim plugin spec
local function setup_mini_plugin(groups)
  return {
    'echasnovski/mini.nvim',
    name = 'mini',
    version = '*',
    event = 'VeryLazy',
    init = function()
      -- Mock nvim-web-devicons if not available
      package.preload['nvim-web-devicons'] = function()
        package.loaded['nvim-web-devicons'] = {}
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
    config = function()
      local mini = groups.mini or {}

      -- Core mini modules
      if mini.core then
        require('plugins.mini.align').setup()
        require('plugins.mini.bracketed').setup()
        require('plugins.mini.clue').setup()
        require('plugins.mini.comment').setup()
        require('plugins.mini.hipatterns').setup()
        require('plugins.mini.move').setup()
        require('plugins.mini.operators').setup()
        require('plugins.mini.pairs').setup()
        require('plugins.mini.splitjoin').setup()
        require('plugins.mini.bufremove').setup()
      end

      -- UI modules
      if mini.ui then
        require('plugins.mini.icons').setup()
      end

      -- Indentscope
      if mini.indentscope then
        require('plugins.mini.indentscope').setup()
      end

      -- Animation
      if mini.animation then
        require('plugins.mini.animate').setup()
      end

      -- Jump modules (only if flash is not enabled)
      if not groups.flash and mini.move then
        require('plugins.mini.jump').setup()
        require('plugins.mini.jump2d').setup()
      end

      -- Optional modules
      if mini.pick then
        require('plugins.mini.pick').setup()
      end

      if mini.notify then
        require('plugins.mini.notify').setup()
      end

      if mini.files then
        require('plugins.mini.files').setup()
      end

      if mini.ai_move then
        require('plugins.mini.ai').setup()
        require('plugins.mini.surround').setup()
      end

      if mini.extra then
        require('plugins.mini.extra').setup()
      end
    end,
  }
end

function M.setup()
  -- Bootstrap lazy.nvim if not installed
  local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable',
      lazypath,
    }
  end

  vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

  -- Build plugin specs
  local core = require 'core'
  local plugin_specs = build_plugin_specs(core.plugin_groups)

  -- Add mini.nvim (always loaded, but modules are conditional)
  table.insert(plugin_specs, setup_mini_plugin(core.plugin_groups))

  -- Configure lazy.nvim with performance optimizations
  require('lazy').setup(plugin_specs, {
    -- Install settings
    install = { colorscheme = {} },

    -- Plugin checker (runs in background)
    checker = { enabled = true, notify = false },

    -- Change detection (notify on plugin updates)
    change_detection = { notify = true },

    -- Performance optimizations
    performance = {
      rtp = {
        -- Disable built-in Neovim plugins that aren't needed
        disabled_plugins = {
          'gzip',
          'tarPlugin',
          'tohtml',
          'tutor',
          'zipPlugin',
        },
      },
    },
  })
end

--- Performance tips:
--- 1. Profile startup: nvim --startuptime startup.log
--- 2. Most plugins load lazily via 'import' (lazy.nvim handles this)
--- 3. Colorschemes load early (priority = 1000)
--- 4. Mini.nvim loads on VeryLazy event
--- 5. Disable unused plugin groups for faster startup

return M
