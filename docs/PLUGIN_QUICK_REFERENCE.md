# Plugin Quick Reference Card

## 🚀 Common Tasks

### Add Plugin to Existing Group
```lua
-- 1. Create plugin file
-- plugins/basic/newplugin.lua
return {
  'author/plugin-name',
  event = 'VeryLazy',
  config = function()
    require('plugin-name').setup {}
  end,
}

-- 2. Add to group init
-- plugins/basic/init.lua
return {
  { import = 'plugins.basic.noice' },
  { import = 'plugins.basic.newplugin' },  -- Add this
}
```

### Create New Plugin Group
```lua
-- 1. Create directory: plugins/newgroup/
-- 2. Create plugins/newgroup/init.lua
return {
  { import = 'plugins.newgroup.plugin1' },
}

-- 3. Add mapping in core/lazy.lua
local PLUGIN_MAPPINGS = {
  -- ... existing
  { key = 'newgroup', import = 'plugins.newgroup', desc = 'New group' },
}

-- 4. Enable in core/init.lua
M.plugin_groups = {
  newgroup = true,  -- Add this
}
```

### Disable a Plugin
```lua
-- Option 1: Disable entire group
M.plugin_groups = {
  trouble = false,  -- Disables all trouble plugins
}

-- Option 2: Conditional in plugin file
-- plugins/basic/noice.lua
if require('core').plugin_groups.noice then
  return { 'folke/noice.nvim', ... }
else
  return {}  -- Plugin won't load
end
```

### Change Colorscheme
```lua
-- core/init.lua
M.plugin_groups = {
  ui = {
    install = 'tokyonight',        -- Plugin to install
    colorscheme = 'tokyonight',    -- Active colorscheme
    fallback_colorscheme = 'darkblue',
    transparent_background = true,
  },
}
```

## 📋 Plugin Spec Template

```lua
return {
  'author/plugin-name',
  
  -- Lazy loading (choose one)
  event = 'VeryLazy',        -- After UI ready
  event = 'BufRead',         -- On file open
  event = 'InsertEnter',     -- On insert mode
  cmd = 'PluginCommand',     -- On command
  keys = { '<leader>p' },    -- On keypress
  ft = 'lua',                -- On filetype
  
  -- Dependencies
  dependencies = {
    'dep1/plugin1',
    'dep2/plugin2',
  },
  
  -- Version pinning
  version = '^1.0.0',  -- or '*'
  
  -- Configuration
  config = function()
    require('plugin-name').setup {
      option1 = true,
      option2 = 'value',
    }
  end,
  
  -- Optional: init (runs before plugin loads)
  init = function()
    -- Pre-load setup
  end,
  
  -- Optional: priority (higher = loads earlier)
  priority = 1000,
}
```

## 🎯 Lazy Loading Events

| Event | When It Loads | Use Case |
|-------|---------------|----------|
| `'VeryLazy'` | After UI is ready | Most plugins |
| `'BufRead'` | When file is opened | File-specific plugins |
| `'BufNewFile'` | When new file created | Templates, snippets |
| `'InsertEnter'` | On insert mode | Completion, snippets |
| `'CmdlineEnter'` | On command line | Command helpers |
| `nil` | Immediately | Essential plugins only |

## 🔧 Plugin Groups Reference

| Group | Type | Default | Description |
|-------|------|---------|-------------|
| `basic` | boolean | `true` | Essential plugins |
| `lsp` | boolean | `true` | Language servers |
| `treesitter` | boolean | `true` | Syntax highlighting |
| `cmp` | boolean | `false` | nvim-cmp (mutually exclusive) |
| `blink` | boolean | `true` | blink.cmp (mutually exclusive) |
| `telescope` | boolean | `true` | Fuzzy finder |
| `oil` | boolean | `true` | File explorer |
| `nvimtree` | boolean | `false` | Legacy file explorer |
| `flash` | boolean | `true` | Jump navigation |
| `statusline` | string | `'lualine'` | Statusline provider |
| `ui` | table | `{...}` | Colorscheme config |
| `git` | boolean | `true` | Git integration |
| `trouble` | boolean | `true` | Diagnostics viewer |
| `bqf` | boolean | `true` | Better quickfix |
| `scissors` | boolean | `true` | Snippet engine |
| `cursor` | boolean | `false` | Cursor enhancements |
| `rest` | boolean | `false` | REST client |
| `ai` | boolean | `false` | AI assistants |
| `mini.*` | boolean | varies | Mini.nvim modules |

## 📁 File Locations

| Task | File Path |
|------|-----------|
| Enable/disable plugins | `lua/core/init.lua` |
| Add new plugin group | `lua/core/lazy.lua` (PLUGIN_MAPPINGS) |
| Plugin config | `lua/plugins/{group}/{plugin}.lua` |
| Group aggregator | `lua/plugins/{group}/init.lua` |
| Key mappings | `lua/core/keymaps.lua` |
| Options | `lua/core/options.lua` |
| Colorscheme | `lua/core/colors.lua` |
| Utils | `lua/utils/{name}.lua` |

## 🔄 Common Patterns

### Pattern: Conditional Plugin
```lua
-- plugins/basic/optional.lua
local core = require('core')
if core.plugin_groups.optional then
  return {
    'author/plugin',
    config = function() ... end,
  }
else
  return {}
end
```

### Pattern: Plugin with Dependencies
```lua
return {
  'main/plugin',
  dependencies = {
    'dep1/plugin1',
    { 'dep2/plugin2', version = '^2.0' },
  },
  config = function()
    require('plugin').setup {}
  end,
}
```

### Pattern: Multiple Configurations
```lua
return {
  'author/plugin',
  config = function()
    local plugin = require('plugin')
    plugin.setup {
      -- base config
    }
    -- additional setup
    vim.api.nvim_create_autocmd('BufEnter', {
      callback = function() ... end,
    })
  end,
}
```

### Pattern: Key-based Loading
```lua
return {
  'author/plugin',
  keys = {
    { '<leader>p', '<cmd>PluginCommand<cr>', desc = 'Plugin' },
  },
  config = function() ... end,
}
```

## ⚡ Performance Tips

1. **Use lazy loading**: Always specify `event`, `cmd`, `keys`, or `ft`
2. **Disable unused groups**: Set to `false` in `plugin_groups`
3. **Profile startup**: `nvim --startuptime startup.log`
4. **Check lazy stats**: `:Lazy` to see load times
5. **Use VeryLazy**: Default for most plugins

## 🐛 Troubleshooting

### Plugin Not Loading
- ✅ Check group is enabled in `core/init.lua`
- ✅ Check mapping exists in `core/lazy.lua`
- ✅ Check import path in group's `init.lua`
- ✅ Run `:Lazy` to see plugin status

### Plugin Loading Too Early
- ✅ Add `event = 'VeryLazy'` to plugin spec
- ✅ Use more specific event (`BufRead`, `InsertEnter`)

### Plugin Loading Too Late
- ✅ Remove `event` or use earlier event
- ✅ Set `priority = 1000` for critical plugins

### Dependency Issues
- ✅ List all dependencies in `dependencies` table
- ✅ Check dependency versions match

## 📝 Mini.nvim Module Pattern

```lua
-- plugins/mini/newmodule.lua
return function()
  local mini = require('mini.newmodule')
  mini.setup {
    -- config
  }
end

-- Then in core/lazy.lua setup_mini_plugin():
if mini.newmodule then
  require('plugins.mini.newmodule').setup()
end
```

## 🎨 Colorscheme Pattern

```lua
-- plugins/colorschemes/newtheme.lua
return {
  'author/newtheme',
  priority = 1000,  -- Load early
  config = function()
    vim.cmd.colorscheme('newtheme')
  end,
}
```

## 🔗 Related Documentation

- `PLUGIN_STRUCTURE.md` - Full architecture guide
- `PLUGIN_GROUPS.md` - Detailed group descriptions
- `ARCHITECTURE.md` - Overall system architecture
- `CUSTOMIZATION.md` - Customization guide
