# Customization Guide

This guide explains how to customize KickNV to fit your needs.

## Quick Start

Most customization happens in `lua/core/init.lua` by modifying the `plugin_groups` table.

## Common Customizations

### Change Colorscheme

Edit `lua/core/init.lua`:

```lua
ui = {
  install = 'tokyonight',        -- Plugin to install
  colorscheme = 'tokyonight',    -- Colorscheme name
  fallback_colorscheme = 'darkblue',
  transparent_background = true,
}
```

**Available colorschemes**:
- `github` (default)
- `tokyonight`
- `kanagawa`
- `catppuccin`

To add a new colorscheme:
1. Create `lua/plugins/colorschemes/{name}.lua`
2. Export a plugin spec
3. Update `ui.install` to use the new name

### Enable/Disable Plugins

Simply toggle boolean values in `plugin_groups`:

```lua
-- Disable telescope
telescope = false,

-- Enable AI plugins
ai = true,

-- Disable flash, use mini.jump instead
flash = false,
```

### Switch Completion Engine

Only enable ONE completion system:

```lua
-- Use nvim-cmp
cmp = true,
blink = false,

-- OR use blink.cmp (lighter)
cmp = false,
blink = true,
```

### Configure Mini.nvim Modules

Fine-tune mini.nvim modules:

```lua
mini = {
  core = true,        -- Essential modules
  animation = false,  -- Disable animations
  pick = true,        -- Enable pick UI
  files = false,      -- Don't use mini.files
}
```

## Advanced Customization

### Add a New Plugin

1. **Create plugin config file**:
   ```lua
   -- lua/plugins/myplugin/init.lua
   return {
     'author/myplugin',
     config = function()
       require('myplugin').setup({
         -- configuration
       })
     end,
   }
   ```

2. **Add to lazy.lua** (if needed):
   ```lua
   { key = 'myplugin', import = 'plugins.myplugin', desc = 'My plugin' },
   ```

3. **Add toggle to plugin_groups**:
   ```lua
   myplugin = true,
   ```

### Modify Keybindings

Edit `lua/core/keymaps.lua`:

```lua
-- Add a new keybinding
vim.keymap.set('n', '<leader>xx', '<cmd>MyCommand<cr>', {
  desc = 'My custom command',
})
```

### Change Neovim Options

Edit `lua/core/options.lua`:

```lua
-- Example: Change tab width
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
```

### Customize Plugin Configuration

Each plugin has its own config file in `lua/plugins/{category}/`. For example:

- `lua/plugins/telescope/init.lua` - Telescope configuration
- `lua/plugins/lsp/lspconfig.lua` - LSP configuration
- `lua/plugins/mini/comment.lua` - Comment configuration

Edit these files to customize plugin behavior.

## Plugin-Specific Guides

### Telescope

Customize pickers in `lua/plugins/telescope/init.lua`:

```lua
require('telescope').setup({
  defaults = {
    -- Your customizations
  },
  pickers = {
    find_files = {
      -- Custom find_files picker
    },
  },
})
```

### LSP

Configure language servers in `lua/plugins/lsp/lspconfig.lua`:

```lua
require('lspconfig').{language}.setup({
  -- Language server configuration
})
```

### Statusline

Switch statusline providers:

```lua
statusline = 'galaxyline',  -- Instead of 'lualine'
```

Or customize in:
- `lua/plugins/statusline/lualine.lua`
- `lua/utils/lualine.lua`

## Tips & Best Practices

### Performance

1. **Disable unused plugins**: Set unused plugins to `false`
2. **Use lazy loading**: Most plugins load lazily by default
3. **Minimize colorschemes**: Only install the one you use
4. **Profile startup**: Use `nvim --startuptime startup.log`

### Organization

1. **Group related plugins**: Keep plugin configs in appropriate folders
2. **Use descriptive names**: Name plugin configs clearly
3. **Document customizations**: Add comments for non-obvious configs
4. **Version control**: Commit your customizations

### Troubleshooting

1. **Check plugin groups**: Ensure plugin is enabled
2. **Verify import path**: Check `lazy.lua` for correct import
3. **Check dependencies**: Some plugins require others
4. **Review logs**: Check `:messages` for errors

## Example: Minimal Configuration

For a minimal setup:

```lua
M.plugin_groups = {
  basic = true,
  lsp = true,
  treesitter = true,
  blink = true,
  telescope = true,
  oil = true,
  git = true,
  statusline = 'lualine',
  ui = {
    install = 'github',
    colorscheme = 'github_dark',
    transparent_background = false,
  },
  -- Disable everything else
  flash = false,
  trouble = false,
  bqf = false,
  scissors = false,
  mini = {
    core = true,
    animation = false,
    indentscope = true,
    notify = true,
    pick = false,
    files = false,
    extra = false,
    ui = true,
    move = false,
    ai_move = false,
  },
}
```

## Getting Help

- Check plugin documentation
- Review `docs/PLUGIN_GROUPS.md` for plugin details
- See `docs/ARCHITECTURE.md` for structure overview
- Check Neovim logs: `:messages`
