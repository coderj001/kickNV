# Neovim Plugin Structure Plan

## Overview

This Neovim configuration uses a **modular, group-based plugin architecture** powered by `lazy.nvim`. Plugins are organized by functionality into groups, which can be enabled/disabled via a central configuration.

## Architecture

### High-Level Flow
```
┌─────────────────────────────────────────────────────────────┐
│                        init.lua                              │
│  Entry point → loads core.setup()                            │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                    core/init.lua                             │
│  • Defines plugin_groups configuration                       │
│  • Sets up options, keymaps                                  │
│  • Initializes lazy.nvim                                     │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                    core/lazy.lua                             │
│  • Maps plugin groups → import paths                         │
│  • Builds plugin specs from groups                           │
│  • Configures lazy.nvim                                      │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│              plugins/{group}/init.lua                        │
│  • Imports individual plugin configs                         │
│  • Returns plugin specs for lazy.nvim                        │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│            plugins/{group}/{plugin}.lua                      │
│  • Individual plugin configuration                           │
│  • Conditional loading based on plugin_groups                │
└─────────────────────────────────────────────────────────────┘
```

### Detailed Loading Sequence

```
1. Neovim starts
   └─> init.lua executes
       └─> require('core').setup()

2. core/init.lua
   ├─> Defines M.plugin_groups = { ... }
   ├─> require('core.options')
   ├─> require('core.keymaps')
   ├─> require('core.lazy').setup()  ← Plugin manager init
   └─> require('core.colors').setup()

3. core/lazy.lua setup()
   ├─> Bootstrap lazy.nvim (if not installed)
   ├─> Read plugin_groups from core
   ├─> Build plugin_specs array:
   │   ├─> Iterate PLUGIN_MAPPINGS
   │   ├─> Check if group is enabled
   │   ├─> Resolve import path (string or function)
   │   └─> Add { import = 'path' } to specs
   ├─> Add mini.nvim (special handling)
   └─> require('lazy').setup(specs, config)

4. lazy.nvim processes specs
   ├─> For each { import = 'path' }:
   │   └─> require('path')  ← Loads plugin group init
   │
   └─> plugins/{group}/init.lua executes
       └─> Returns array of plugin specs
           └─> Each spec: { import = 'plugins.group.plugin' }

5. lazy.nvim loads individual plugins
   └─> For each plugin spec:
       ├─> Check lazy loading conditions (event, cmd, keys, ft)
       ├─> Load dependencies first
       ├─> Execute init() if present
       ├─> Load plugin
       └─> Execute config() when conditions met

6. Plugin Configuration
   └─> plugins/{group}/{plugin}.lua config() executes
       └─> Plugin.setup({ ... })
```

### Load Order Priority

```
Priority 1000+ (Early Load)
├─> Colorschemes (priority = 1000)
└─> Essential UI plugins

Priority 100-999 (Normal Load)
├─> Core plugins (basic group)
├─> LSP setup
├─> Treesitter
└─> Most other plugins

Priority < 100 (Late Load)
└─> Optional/experimental plugins

Event-Based Loading (After UI Ready)
├─> VeryLazy event
├─> BufRead event
├─> InsertEnter event
└─> Command/Key-based loading
```

## Directory Structure

```
lua/
├── core/                    # Core configuration
│   ├── init.lua            # Main setup, plugin_groups config
│   ├── lazy.lua            # Plugin manager setup & loading logic
│   ├── options.lua         # Neovim options
│   ├── keymaps.lua         # Key mappings
│   └── colors.lua          # Colorscheme setup
│
└── plugins/                 # Plugin configurations
    ├── basic/              # Essential plugins (always loaded)
    │   ├── init.lua        # Aggregates basic plugins
    │   ├── noice.lua       # UI notifications
    │   ├── escape.lua      # Escape key handling
    │   ├── gx.lua          # URL opening
    │   └── ...
    │
    ├── lsp/                # Language Server Protocol
    │   ├── init.lua        # Aggregates LSP plugins
    │   ├── mason.lua       # LSP installer
    │   ├── lspconfig.lua   # LSP client
    │   ├── conform.lua     # Code formatter
    │   └── codeaction.lua  # Code actions
    │
    ├── treesitter/         # Syntax highlighting
    │   └── init.lua
    │
    ├── cmp/                # nvim-cmp completion
    │   ├── init.lua
    │   └── cmp.lua
    │
    ├── blink/              # blink.cmp completion (alternative)
    │   ├── init.lua
    │   └── blink.lua
    │
    ├── telescope/          # Fuzzy finder
    │   ├── init.lua
    │   └── harpoon.lua     # Harpoon integration
    │
    ├── oil/                # File explorer
    │   └── init.lua
    │
    ├── git/                # Git integration
    │   ├── init.lua
    │   ├── gitsigns.lua
    │   └── neogit.lua
    │
    ├── statusline/         # Statusline plugins
    │   ├── init.lua
    │   ├── lualine.lua
    │   └── galaxyline.lua
    │
    ├── colorschemes/       # Colorscheme configs
    │   ├── github.lua
    │   ├── tokyonight.lua
    │   ├── kanagawa.lua
    │   └── catppuccin.lua
    │
    ├── mini/               # Mini.nvim modules
    │   ├── align.lua
    │   ├── comment.lua
    │   ├── pairs.lua
    │   └── ... (22 modules)
    │
    ├── trouble/            # Diagnostics viewer
    │   └── init.lua
    │
    ├── bqf/                # Better quickfix
    │   └── init.lua
    │
    ├── flash/              # Jump navigation
    │   └── init.lua
    │
    ├── scissors/           # Snippet engine
    │   └── init.lua
    │
    ├── cursor/             # Cursor enhancements
    │   └── init.lua
    │
    ├── rest/               # REST client
    │   └── init.lua
    │
    └── ai/                 # AI assistants
        └── copilot.lua
```

## Plugin Group System

### Configuration Location
Plugin groups are defined in `lua/core/init.lua`:

```lua
M.plugin_groups = {
  basic = true,           -- Essential plugins
  lsp = true,             -- Language servers
  treesitter = true,      -- Syntax highlighting
  cmp = false,            -- nvim-cmp (mutually exclusive with blink)
  blink = true,           -- blink.cmp (mutually exclusive with cmp)
  telescope = true,       -- Fuzzy finder
  oil = true,             -- File explorer
  flash = true,           -- Jump navigation
  statusline = 'lualine', -- Statusline provider
  ui = { ... },           -- Colorscheme config
  git = true,             -- Git integration
  trouble = true,         -- Diagnostics
  bqf = true,             -- Quickfix
  scissors = true,        -- Snippets
  mini = { ... },         -- Mini.nvim modules
  -- ... more groups
}
```

### Group Mapping
Groups are mapped to import paths in `lua/core/lazy.lua`:

```lua
local PLUGIN_MAPPINGS = {
  { key = 'basic', import = 'plugins.basic', desc = 'Essential plugins' },
  { key = 'lsp', import = 'plugins.lsp', desc = 'LSP configuration' },
  -- ... more mappings
}
```

### Loading Flow

1. **Core Init** (`core/init.lua`)
   - Defines `plugin_groups` table
   - Calls `core.lazy.setup()`

2. **Lazy Setup** (`core/lazy.lua`)
   - Reads `plugin_groups` from core
   - Maps enabled groups to import paths
   - Builds plugin specs array
   - Configures lazy.nvim

3. **Plugin Init** (`plugins/{group}/init.lua`)
   - Returns array of plugin specs
   - Each spec uses `{ import = 'plugins.group.plugin' }`

4. **Plugin Config** (`plugins/{group}/{plugin}.lua`)
   - Returns individual plugin spec
   - Can conditionally check `plugin_groups`
   - Contains plugin configuration

## Plugin Organization Patterns

### Pattern 1: Simple Group (Single Plugin)
```
plugins/flash/
  └── init.lua  # Directly returns plugin spec
```

### Pattern 2: Multi-Plugin Group
```
plugins/basic/
  ├── init.lua      # Aggregates all basic plugins
  ├── noice.lua     # Individual plugin configs
  ├── escape.lua
  └── ...
```

### Pattern 3: Conditional Loading
```lua
-- plugins/basic/noice.lua
if require('core').plugin_groups.noice then
  return {
    'folke/noice.nvim',
    config = function() ... end,
  }
else
  return {}
end
```

### Pattern 4: Special Handling (Mini.nvim)
Mini.nvim is handled specially in `core/lazy.lua` because:
- It's always loaded but modules are conditional
- Modules are loaded programmatically
- Has complex dependency logic (e.g., flash vs mini.jump)

## Adding New Plugins

### Step 1: Choose Plugin Group
- **Existing group**: Add to appropriate `plugins/{group}/` directory
- **New group**: Create new directory and add mapping

### Step 2: Create Plugin File
```lua
-- plugins/{group}/{plugin}.lua
return {
  'author/plugin-name',
  event = 'VeryLazy',  -- or other lazy loading event
  dependencies = { ... },
  config = function()
    require('plugin-name').setup {
      -- configuration
    }
  end,
}
```

### Step 3: Add to Group Init (if multi-plugin group)
```lua
-- plugins/{group}/init.lua
return {
  { import = 'plugins.{group}.{plugin}' },
  -- ... other plugins
}
```

### Step 4: Add Group Mapping (if new group)
```lua
-- core/lazy.lua
local PLUGIN_MAPPINGS = {
  -- ... existing mappings
  { key = 'newgroup', import = 'plugins.newgroup', desc = 'Description' },
}
```

### Step 5: Enable in Config
```lua
-- core/init.lua
M.plugin_groups = {
  -- ... existing groups
  newgroup = true,
}
```

## Real-World Examples

### Example 1: Simple Plugin (Single File Group)
```lua
-- plugins/flash/init.lua
return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  keys = {
    { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end },
  },
  config = function()
    require('flash').setup {
      modes = {
        char = { enabled = false },
      },
    }
  end,
}
```

### Example 2: Multi-Plugin Group with Aggregation
```lua
-- plugins/git/init.lua
return {
  { import = 'plugins.git.gitsigns' },
  { import = 'plugins.git.neogit' },
}

-- plugins/git/gitsigns.lua
return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('gitsigns').setup {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
      },
    }
  end,
}
```

### Example 3: Complex Plugin with Keys and Utils
```lua
-- plugins/telescope/init.lua
return {
  {
    'nvim-telescope/telescope.nvim',
    event = { 'VimEnter' },
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        cond = vim.fn.executable 'make' == 1,
      },
    },
    keys = {
      { '<leader>sf', function() require('telescope.builtin').find_files() end },
      { '<leader>sw', function() require('utils.telescope').grep_current_word() end },
    },
    config = function()
      require('utils.telescope').setup()
    end,
  },
}
```

### Example 4: Conditional Plugin Loading
```lua
-- plugins/basic/noice.lua
if require('core').plugin_groups.noice then
  return {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = function()
      require('noice').setup {
        lsp = { override = {} },
        presets = { bottom_search = true },
      }
    end,
  }
else
  return {}
end
```

### Example 5: Mini.nvim Module Pattern
```lua
-- plugins/mini/comment.lua
local M = {}

function M.setup()
  require('mini.comment').setup {
    mappings = {
      comment = 'gc',
      comment_line = 'gcc',
      comment_visual = 'gc',
    },
    hooks = {
      pre = function() end,
      post = function() end,
    },
  }
end

return M

-- Then loaded in core/lazy.lua:
if mini.core then
  require('plugins.mini.comment').setup()
end
```

### Example 6: Colorscheme with Conditional Import
```lua
-- plugins/colorschemes/github.lua
return {
  'projekt0n/github-nvim-theme',
  priority = 1000,  -- Load early
  config = function()
    require('github-theme').setup {
      transparent = require('core').plugin_groups.ui.transparent_background,
    }
    vim.cmd.colorscheme('github_dark')
  end,
}

-- Loaded conditionally in core/lazy.lua:
{
  key = 'ui',
  import = function(groups)
    if groups.ui and groups.ui.colorscheme then
      return 'plugins.colorschemes.' .. groups.ui.install
    end
    return nil
  end,
}
```

## Best Practices

### 1. Lazy Loading
- Use appropriate lazy loading events:
  - `'VeryLazy'`: Load after UI is ready (default for most plugins)
  - `'BufRead'`: Load when file is opened (file-specific plugins)
  - `'BufNewFile'`: Load when new file created (templates)
  - `'InsertEnter'`: Load on insert mode (completion, snippets)
  - `'CmdlineEnter'`: Load on command line (command helpers)
  - `event = nil`: Load immediately (only for essential plugins)
  - `keys = {...}`: Load on keypress (key-driven plugins)
  - `cmd = 'Command'`: Load on command (command-driven plugins)
  - `ft = 'lua'`: Load on filetype (language-specific plugins)

**Example:**
```lua
-- Good: Lazy load on file open
return {
  'plugin/name',
  event = 'BufRead',
  config = function() ... end,
}

-- Bad: Loads immediately
return {
  'plugin/name',
  config = function() ... end,
}
```

### 2. Conditional Loading
- Check `plugin_groups` in plugin files for optional plugins
- Return empty table `{}` if disabled
- Use early return pattern for clarity

**Example:**
```lua
-- Good: Clear conditional
local core = require('core')
if not core.plugin_groups.optional then
  return {}
end

return {
  'author/plugin',
  config = function() ... end,
}
```

### 3. Dependencies
- Declare all dependencies in plugin spec
- Use lazy.nvim's dependency system
- Pin versions for stability when needed
- Use `cond` for conditional dependencies

**Example:**
```lua
return {
  'main/plugin',
  dependencies = {
    'required/dep1',
    { 'optional/dep2', cond = vim.fn.has('win32') == 1 },
    { 'versioned/dep3', version = '^2.0' },
  },
}
```

### 4. Configuration
- Keep plugin configs in their respective files
- Use `config = function()` for setup
- Extract complex configs to `utils/` if shared
- Use helper functions for reusable patterns

**Example:**
```lua
-- plugins/telescope/init.lua
return {
  'nvim-telescope/telescope.nvim',
  config = function()
    -- Complex setup extracted to utils
    require('utils.telescope').setup()
  end,
}

-- utils/telescope.lua
local M = {}
function M.setup()
  require('telescope').setup { ... }
  -- Additional configuration
end
return M
```

### 5. Mutually Exclusive Plugins
- Document mutual exclusivity (e.g., `cmp` vs `blink`)
- Add logic in `core/lazy.lua` if needed
- Use conditional checks in plugin files

**Example:**
```lua
-- core/lazy.lua
-- Flash and mini.jump are mutually exclusive
if not groups.flash and mini.move then
  require('plugins.mini.jump').setup()
end
```

### 6. Group Organization
- Group by functionality, not by plugin name
- Keep related plugins together
- Use descriptive group names
- Keep groups focused (avoid "misc" groups)

**Good Grouping:**
- `git/` - All git-related plugins
- `lsp/` - All LSP-related plugins
- `basic/` - Essential utilities

**Bad Grouping:**
- `misc/` - Too vague
- `plugin1/`, `plugin2/` - Not functional

### 7. Key Mappings
- Define keys in plugin spec when plugin-specific
- Use `desc` for better help text
- Group related keys together
- Consider mode-specific mappings

**Example:**
```lua
return {
  'author/plugin',
  keys = {
    { '<leader>p', function() ... end, desc = 'Plugin action' },
    { '<leader>P', function() ... end, desc = 'Plugin other', mode = 'v' },
  },
}
```

### 8. Version Pinning
- Pin versions for critical plugins
- Use semantic versioning (`^1.0.0`, `~1.0.0`)
- Use `version = '*'` for latest (default)

**Example:**
```lua
return {
  'author/plugin',
  version = '^1.0.0',  -- Compatible with 1.x
  -- or
  version = '~1.0.0',  -- Compatible with 1.0.x
}
```

### 9. Priority
- Use `priority` for load order control
- Higher numbers load earlier
- Default is 1000 for colorschemes
- Use sparingly (lazy.nvim handles most cases)

**Example:**
```lua
return {
  'author/colorscheme',
  priority = 1000,  -- Load early
  config = function() ... end,
}
```

### 10. Error Handling
- Use `cond` for conditional loading based on system
- Check for required executables
- Handle missing dependencies gracefully

**Example:**
```lua
return {
  'author/plugin',
  cond = vim.fn.executable('required-tool') == 1,
  dependencies = {
    { 'dep/plugin', cond = vim.fn.has('nvim-0.9') == 1 },
  },
}
```

## Special Cases

### Colorschemes
- Handled via `ui` group with conditional import
- Import path determined dynamically: `plugins.colorschemes.{name}`
- Priority set to 1000 for early loading

### Statusline
- Conditional import based on `statusline` value
- Multiple providers supported (lualine, galaxyline)

### Mini.nvim
- Always loaded but modules are conditional
- Special setup function in `core/lazy.lua`
- Modules loaded programmatically based on `mini.*` flags

## Performance Considerations

1. **Lazy Loading**: Most plugins load lazily via `import`
2. **Disabled Plugins**: Unused groups don't load at all
3. **Built-in Disables**: Unused Neovim plugins disabled in lazy config
4. **Startup Time**: Profile with `nvim --startuptime startup.log`

## Plugin Dependencies Graph

```
basic (always loaded)
  └── noice → nui.nvim

lsp
  ├── mason → lspconfig
  ├── lspconfig → conform (optional)
  └── codeaction → lspconfig

treesitter
  └── (required by many syntax plugins)

cmp/blink (mutually exclusive)
  └── (completion sources)

telescope
  └── harpoon (extension)

mini.nvim
  ├── core modules (interdependent)
  └── icons → (mocks nvim-web-devicons)

flash vs mini.jump (mutually exclusive)
```

## Migration Guide

### Adding a Plugin to Existing Group
1. Create `plugins/{group}/{plugin}.lua`
2. Add `{ import = 'plugins.{group}.{plugin}' }` to `plugins/{group}/init.lua`

### Creating New Plugin Group
1. Create `plugins/{newgroup}/` directory
2. Create `plugins/{newgroup}/init.lua`
3. Add mapping to `core/lazy.lua` PLUGIN_MAPPINGS
4. Add `{newgroup} = true` to `core/init.lua` plugin_groups

### Disabling a Plugin
1. Set group to `false` in `plugin_groups`
2. Or conditionally return `{}` in plugin file

## File Naming Conventions

- **Group directories**: lowercase, descriptive (e.g., `git`, `lsp`)
- **Plugin files**: lowercase, plugin name (e.g., `noice.lua`, `gitsigns.lua`)
- **Init files**: Always `init.lua` in group directories
- **Utils**: Place in `lua/utils/` if shared across plugins

## Advanced Patterns

### Pattern: Plugin with Custom Setup Function
```lua
-- plugins/group/plugin.lua
local M = {}

function M.setup()
  local plugin = require('plugin-name')
  plugin.setup {
    -- base config
  }
  
  -- Additional setup
  vim.api.nvim_create_autocmd('BufEnter', {
    callback = function()
      -- Custom behavior
    end,
  })
end

return {
  'author/plugin-name',
  config = M.setup,
}
```

### Pattern: Plugin with Multiple Configurations
```lua
return {
  'author/plugin',
  config = function()
    local plugin = require('plugin')
    
    -- Base configuration
    plugin.setup {
      option1 = true,
    }
    
    -- Extend configuration
    plugin.set_option('option2', 'value')
    
    -- Custom keymaps
    vim.keymap.set('n', '<leader>p', function()
      plugin.action()
    end)
  end,
}
```

### Pattern: Plugin Extension
```lua
-- plugins/telescope/harpoon.lua
return {
  'ThePrimeagen/harpoon',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  keys = {
    { '<leader>a', function() require('harpoon.mark').add_file() end },
    { '<leader>h', function() require('telescope').extensions.harpoon.marks() end },
  },
  config = function()
    require('telescope').load_extension('harpoon')
  end,
}
```

### Pattern: System-Specific Configuration
```lua
return {
  'author/plugin',
  cond = function()
    -- Only load on Linux
    return vim.fn.has('unix') == 1 and vim.fn.has('macunix') == 0
  end,
  config = function()
    require('plugin').setup {
      -- Linux-specific config
    }
  end,
}
```

### Pattern: Feature Flags
```lua
-- core/init.lua
M.plugin_groups = {
  experimental = {
    new_feature = true,
  },
}

-- plugins/group/plugin.lua
local core = require('core')
return {
  'author/plugin',
  config = function()
    local config = {
      -- base config
    }
    
    if core.plugin_groups.experimental.new_feature then
      config.experimental_feature = true
    end
    
    require('plugin').setup(config)
  end,
}
```

## Testing Plugin Configuration

### Check Plugin Status
```vim
:Lazy           " Open lazy.nvim UI
:Lazy health     " Check plugin health
:Lazy update     " Update plugins
:Lazy clean      " Remove unused plugins
```

### Profile Startup Time
```bash
nvim --startuptime startup.log
# Then open startup.log to see load times
```

### Debug Plugin Loading
```lua
-- Add to plugin config for debugging
config = function()
  print('Loading plugin-name')
  require('plugin-name').setup {}
end,
```

## Common Pitfalls

### ❌ Pitfall 1: Loading Too Early
```lua
-- Bad: Loads immediately
return {
  'author/plugin',
  config = function() ... end,
}

-- Good: Lazy load
return {
  'author/plugin',
  event = 'VeryLazy',
  config = function() ... end,
}
```

### ❌ Pitfall 2: Missing Dependencies
```lua
-- Bad: Missing dependency
return {
  'main/plugin',
  config = function() ... end,
}

-- Good: Declare dependencies
return {
  'main/plugin',
  dependencies = { 'required/dep' },
  config = function() ... end,
}
```

### ❌ Pitfall 3: Wrong Import Path
```lua
-- Bad: Wrong path
{ import = 'plugins.group.plugin' }  -- File doesn't exist

-- Good: Correct path matching file structure
{ import = 'plugins.basic.noice' }  -- Matches plugins/basic/noice.lua
```

### ❌ Pitfall 4: Forgetting Group Mapping
```lua
-- Bad: Created new group but forgot mapping
-- plugins/newgroup/init.lua exists but not in PLUGIN_MAPPINGS

-- Good: Add to core/lazy.lua
{ key = 'newgroup', import = 'plugins.newgroup', desc = 'New group' },
```

### ❌ Pitfall 5: Circular Dependencies
```lua
-- Bad: Plugin A depends on B, B depends on A
-- Avoid this by restructuring or using optional dependencies
```

## Migration Examples

### Migrating from packer.nvim
```lua
-- Old (packer.nvim)
use {
  'author/plugin',
  config = function() ... end,
}

-- New (lazy.nvim)
return {
  'author/plugin',
  config = function() ... end,
}
```

### Migrating from vim-plug
```vim
" Old (vim-plug)
Plug 'author/plugin'

" New (lazy.nvim)
-- plugins/group/plugin.lua
return {
  'author/plugin',
  config = function() ... end,
}
```

## Summary

This architecture provides:
- ✅ **Modularity**: Plugins organized by function
- ✅ **Flexibility**: Easy to enable/disable groups
- ✅ **Maintainability**: Clear structure and separation
- ✅ **Performance**: Lazy loading and conditional loading
- ✅ **Scalability**: Easy to add new plugins/groups
- ✅ **Type Safety**: Annotations and clear patterns
- ✅ **Documentation**: Self-documenting structure

The system balances simplicity with power, allowing fine-grained control over which plugins load while maintaining a clean, organized structure.

## Related Documentation

- `PLUGIN_QUICK_REFERENCE.md` - Quick reference for common tasks
- `PLUGIN_GROUPS.md` - Detailed plugin group descriptions
- `ARCHITECTURE.md` - Overall system architecture
- `CUSTOMIZATION.md` - Customization guide
- `TROUBLESHOOTING.md` - Common issues and solutions
