# Plugin Groups Reference

This document describes all available plugin groups and their purposes.

## Core Plugins

### `basic` (boolean)
**Default**: `true`

Essential plugins that should always be loaded:
- `escape`: Better escape key handling
- `gx`: Enhanced gx command for opening URLs
- `lastplace`: Remember last cursor position
- `noice`: Modern UI for notifications and command line
- `relativeline`: Relative line numbers
- `surround`: Text object for surrounding text
- `tmux`: Tmux integration

### `lsp` (boolean)
**Default**: `true`

Language Server Protocol configuration:
- `mason.nvim`: LSP server installer
- `nvim-lspconfig`: LSP client configuration
- `conform.nvim`: Code formatter
- `codeaction`: Code action enhancements

### `treesitter` (boolean)
**Default**: `true`

Treesitter syntax highlighting and parsing:
- Provides syntax highlighting
- Enables advanced text objects
- Powers many other plugins

## Completion Systems

**Note**: Only enable ONE completion system at a time.

### `cmp` (boolean)
**Default**: `false`

nvim-cmp completion engine:
- Full-featured completion
- Extensive plugin ecosystem
- More configuration options

### `blink` (boolean)
**Default**: `true`

blink.cmp completion engine:
- Lightweight alternative
- Faster startup
- Simpler configuration

## Navigation & File Management

### `telescope` (boolean)
**Default**: `true`

Telescope fuzzy finder:
- File finder
- Grep/search
- Extensible picker system
- Includes harpoon integration

### `oil` (boolean)
**Default**: `true`

Oil.nvim file explorer:
- Modern file explorer
- Inline editing
- Better than nvim-tree for most use cases

### `nvimtree` (boolean)
**Default**: `false`

NvimTree file explorer:
- Legacy file explorer
- Use `oil` instead for new setups

### `flash` (boolean)
**Default**: `true`

Flash.nvim jump navigation:
- Smart jump labels
- Alternative to mini.jump
- If disabled, mini.jump will be used instead

## UI & Appearance

### `statusline` (string)
**Default**: `'lualine'`

Statusline provider:
- `'lualine'`: LuaLine statusline (recommended)
- `'galaxyline'`: GalaxyLine statusline
- Other options available in `plugins/statusline/`

### `ui` (table)
**Default**: See below

UI configuration:
```lua
ui = {
  install = 'github',              -- Colorscheme to install
  colorscheme = 'github_dark',     -- Active colorscheme
  fallback_colorscheme = 'darkblue', -- Fallback
  transparent_background = true,   -- Transparent bg
}
```

**Available colorschemes**:
- `github`: GitHub theme (default)
- `tokyonight`: Tokyo Night
- `kanagawa`: Kanagawa
- `catppuccin`: Catppuccin

## Git Integration

### `git` (boolean)
**Default**: `true`

Git integrations:
- `gitsigns`: Git signs in gutter
- Basic git functionality

### `neogit` (boolean)
**Default**: `false`

Neogit UI:
- Full git UI
- Can be enabled separately from `git`

## Code Quality

### `trouble` (boolean)
**Default**: `true`

Trouble diagnostics viewer:
- Better diagnostics display
- Quickfix integration

### `bqf` (boolean)
**Default**: `true`

Better quickfix list:
- Enhanced quickfix window
- Better navigation

## Utilities

### `scissors` (boolean)
**Default**: `true`

Scissors snippet engine:
- Snippet support
- Language-specific snippets

### `cursor` (boolean)
**Default**: `false`

Cursor enhancements:
- Additional cursor features

### `rest` (boolean)
**Default**: `false`

REST client for Neovim:
- Test REST APIs from Neovim
- Useful for API development

### `ai` (boolean)
**Default**: `false`

AI coding assistants:
- GitHub Copilot
- Codeium
- Ollama integration

## Mini.nvim Modules

Mini.nvim is a modular plugin suite. Configure individual modules:

### `mini.core` (boolean)
**Default**: `true`

Core modules:
- `align`: Text alignment
- `bracketed`: Bracket navigation
- `clue`: Keybinding hints
- `comment`: Comments
- `hipatterns`: Highlight patterns
- `move`: Text movement
- `operators`: Custom operators
- `pairs`: Auto-pairs
- `splitjoin`: Split/join code
- `bufremove`: Buffer removal

### `mini.animation` (boolean)
**Default**: `true`

Animation module for smooth transitions.

### `mini.indentscope` (boolean)
**Default**: `true`

Indent scope indicators.

### `mini.notify` (boolean)
**Default**: `true`

Notification system (alternative to nvim-notify).

### `mini.pick` (boolean)
**Default**: `false`

Pick UI (alternative to telescope).

### `mini.files` (boolean)
**Default**: `false`

File explorer (use `oil` instead).

### `mini.extra` (boolean)
**Default**: `true`

Extra utilities.

### `mini.ui` (boolean)
**Default**: `true`

UI components (icons).

### `mini.move` (boolean)
**Default**: `true`

Text movement enhancements.

### `mini.ai_move` (boolean)
**Default**: `true`

AI-powered text movement and surround operations.

## Plugin Dependencies

Some plugins have dependencies:

- **Treesitter** is required by many syntax-related plugins
- **Flash** and **mini.jump** are mutually exclusive (flash takes priority)
- **Cmp** and **blink** are mutually exclusive (only enable one)
- **Oil** and **nvimtree** can coexist but oil is recommended
- **Mini.icons** mocks nvim-web-devicons if not available

## Example Configuration

```lua
M.plugin_groups = {
  -- Core
  basic = true,
  lsp = true,
  treesitter = true,

  -- Completion (choose one)
  blink = true,
  cmp = false,

  -- Navigation
  telescope = true,
  oil = true,
  flash = true,

  -- UI
  statusline = 'lualine',
  ui = {
    install = 'tokyonight',
    colorscheme = 'tokyonight',
    transparent_background = true,
  },

  -- Git
  git = true,
  neogit = false,

  -- Quality
  trouble = true,
  bqf = true,

  -- Utilities
  scissors = true,
  ai = false,
}
```
