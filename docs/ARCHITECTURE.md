# KickNV Architecture

## Overview

KickNV is a modular Neovim configuration written in Lua. It uses `lazy.nvim` as the plugin manager and follows a clean, organized structure that makes it easy to customize and maintain.

## Directory Structure

```
nvim/
├── init.lua                 # Entry point (VS Code compatibility check)
├── lua/
│   ├── core/               # Core configuration
│   │   ├── init.lua        # Main setup and plugin groups
│   │   ├── lazy.lua        # Plugin manager setup
│   │   ├── options.lua     # Neovim options
│   │   ├── keymaps.lua     # Keybindings
│   │   └── colors.lua      # Colorscheme setup
│   ├── plugins/            # Plugin configurations
│   │   ├── basic/          # Essential plugins
│   │   ├── lsp/            # LSP and language servers
│   │   ├── colorschemes/   # Colorscheme configs
│   │   ├── mini/           # Mini.nvim modules
│   │   └── ...             # Other plugin categories
│   └── utils/              # Utility functions
└── docs/                   # Documentation
```

## Core Components

### 1. Entry Point (`init.lua`)

The entry point checks if Neovim is running in VS Code mode and loads the appropriate configuration:

- **VS Code mode**: Loads `lua/code/vscode.lua` for VS Code Neovim extension compatibility
- **Normal mode**: Loads `lua/core/init.lua` for full configuration

### 2. Core Module (`lua/core/init.lua`)

The core module defines:
- **Plugin groups**: Configuration table that controls which plugins are enabled
- **Setup function**: Initializes options, keymaps, plugin manager, and colorscheme

### 3. Plugin Manager (`lua/core/lazy.lua`)

Handles:
- Bootstrap lazy.nvim if not installed
- Build plugin specs from plugin groups
- Configure lazy.nvim settings (performance, disabled plugins)

### 4. Plugin Organization

Plugins are organized by category:
- **basic/**: Essential plugins (escape, gx, lastplace, noice, etc.)
- **lsp/**: Language Server Protocol configuration
- **colorschemes/**: Colorscheme configurations
- **mini/**: Mini.nvim module configurations
- **telescope/**: Telescope fuzzy finder
- **git/**: Git integrations
- And more...

## Plugin Loading Flow

1. `init.lua` → Checks VS Code mode
2. `core.init.setup()` → Loads core configuration
3. `core.lazy.setup()` → Builds plugin specs from `plugin_groups`
4. `lazy.nvim` → Loads and configures plugins

## Configuration Philosophy

### Modularity
Each plugin has its own configuration file, making it easy to:
- Enable/disable plugins
- Modify individual plugin settings
- Add new plugins without touching core files

### Data-Driven
Plugin loading is controlled by the `plugin_groups` table in `core/init.lua`, allowing:
- Easy toggling of features
- Clear overview of enabled plugins
- Type-safe configuration with annotations

### Performance
- Lazy loading by default (`event = 'VeryLazy'` for most plugins)
- Disabled built-in Neovim plugins that aren't needed
- Conditional loading based on plugin groups

## Customization Guide

### Adding a Plugin

1. Create a new file in `lua/plugins/{category}/`
2. Export a plugin spec table
3. Add import to `lua/core/lazy.lua` if needed
4. Add toggle to `plugin_groups` in `lua/core/init.lua`

### Changing Colorscheme

Edit `lua/core/init.lua`:
```lua
ui = {
  install = 'tokyonight',  -- Change this
  colorscheme = 'tokyonight',
  ...
}
```

### Enabling/Disabling Features

Edit `plugin_groups` in `lua/core/init.lua`:
```lua
telescope = false,  -- Disable telescope
ai = true,          -- Enable AI plugins
```

## Key Design Decisions

1. **VS Code Compatibility**: Separate config path for VS Code Neovim extension
2. **Plugin Groups**: Centralized configuration for easy management
3. **Mini.nvim**: Modular plugin suite reduces plugin count
4. **Lazy Loading**: Performance-first approach with lazy loading
5. **Documentation**: Inline comments and separate docs folder

## Future Improvements

- [ ] Migrate to LuaLS for better type checking
- [ ] Add plugin dependency graph visualization
- [ ] Create plugin template generator
- [ ] Add automated testing for configuration
