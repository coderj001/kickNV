# Plugin Dependencies & Relationships

## Dependency Graph

```
┌─────────────────────────────────────────────────────────────┐
│                    Core Dependencies                         │
└─────────────────────────────────────────────────────────────┘

lazy.nvim (Plugin Manager)
  └─> All plugins managed by lazy.nvim

nvim-web-devicons (Optional)
  └─> Used by: mini.icons (mocked if not available)
  └─> Used by: nvimtree, telescope (optional)

plenary.nvim
  └─> Used by: telescope, oil, trouble, many others

┌─────────────────────────────────────────────────────────────┐
│                    Plugin Groups                             │
└─────────────────────────────────────────────────────────────┘

basic (Essential Plugins)
  ├─> noice.nvim
  │   └─> nui.nvim (dependency)
  ├─> escape.nvim
  ├─> gx.nvim
  ├─> lastplace.nvim
  ├─> relativeline.nvim
  ├─> surround.nvim
  └─> tmux.nvim

lsp (Language Server Protocol)
  ├─> mason.nvim
  │   └─> mason-lspconfig.nvim
  │   └─> mason-tool-installer.nvim
  ├─> nvim-lspconfig
  │   └─> Depends on: mason.nvim (for server installation)
  ├─> conform.nvim
  │   └─> Depends on: nvim-lspconfig (optional)
  └─> codeaction.nvim
      └─> Depends on: nvim-lspconfig

treesitter
  └─> nvim-treesitter
      └─> Used by: Many plugins for syntax awareness
          ├─> trouble.nvim
          ├─> noice.nvim (optional)
          └─> mini.hipatterns

Completion Systems (Mutually Exclusive)
  ├─> cmp (nvim-cmp)
  │   ├─> nvim-cmp
  │   ├─> cmp-buffer
  │   ├─> cmp-path
  │   ├─> cmp-lsp
  │   └─> cmp-nvim-lua
  │
  └─> blink (blink.cmp)
      └─> blink.cmp

Navigation & File Management
  ├─> telescope
  │   ├─> telescope.nvim
  │   │   └─> plenary.nvim
  │   ├─> telescope-fzf-native.nvim (optional, requires make)
  │   ├─> telescope-live-grep-args.nvim
  │   └─> harpoon (extension)
  │       └─> Depends on: telescope.nvim
  │
  ├─> oil
  │   └─> oil.nvim
  │       └─> plenary.nvim
  │
  ├─> nvimtree (Alternative to oil)
  │   └─> nvim-tree.lua
  │       └─> nvim-web-devicons (optional)
  │
  └─> flash
      └─> flash.nvim

Git Integration
  ├─> git (gitsigns)
  │   └─> gitsigns.nvim
  │       └─> plenary.nvim
  │
  └─> neogit (optional)
      └─> neogit
          └─> Depends on: gitsigns.nvim (optional)

Statusline
  ├─> lualine
  │   └─> lualine.nvim
  │       └─> nvim-web-devicons (optional)
  │
  └─> galaxyline
      └─> galaxyline.nvim

Diagnostics & Code Quality
  ├─> trouble
  │   └─> trouble.nvim
  │       └─> plenary.nvim
  │
  └─> bqf
      └─> better-queue.nvim

Utilities
  ├─> scissors
  │   └─> scissors.nvim
  │
  ├─> cursor
  │   └─> cursor.nvim
  │
  ├─> rest
  │   └─> rest.nvim
  │
  └─> ai
      └─> copilot.nvim (or other AI plugins)

Mini.nvim Suite
  └─> mini.nvim (single plugin, multiple modules)
      ├─> Core modules (interdependent)
      │   ├─> mini.align
      │   ├─> mini.bracketed
      │   ├─> mini.clue
      │   ├─> mini.comment
      │   ├─> mini.hipatterns
      │   ├─> mini.move
      │   ├─> mini.operators
      │   ├─> mini.pairs
      │   ├─> mini.splitjoin
      │   └─> mini.bufremove
      │
      ├─> UI modules
      │   ├─> mini.icons
      │   │   └─> Mocks nvim-web-devicons if not available
      │   └─> mini.indentscope
      │
      ├─> Animation
      │   └─> mini.animate
      │
      ├─> Jump modules (conditional)
      │   ├─> mini.jump (if flash disabled)
      │   └─> mini.jump2d (if flash disabled)
      │
      ├─> Optional modules
      │   ├─> mini.pick (alternative to telescope)
      │   ├─> mini.notify (alternative to nvim-notify)
      │   ├─> mini.files (alternative to oil/nvimtree)
      │   ├─> mini.ai (AI text movement)
      │   ├─> mini.surround (if ai_move enabled)
      │   └─> mini.extra
```

## Mutual Exclusivity Rules

### 1. Completion Systems
- **cmp** and **blink** are mutually exclusive
- Only enable ONE at a time
- Default: `blink = true`, `cmp = false`

### 2. Jump Navigation
- **flash** and **mini.jump** are mutually exclusive
- If `flash = true`, mini.jump modules are disabled
- If `flash = false`, mini.jump modules are enabled (if `mini.move = true`)

### 3. File Explorers
- **oil** and **nvimtree** can coexist but serve same purpose
- Recommendation: Use `oil` (modern), disable `nvimtree`
- **mini.files** is another alternative (if enabled)

### 4. Statusline Providers
- Multiple providers available but only one active
- Controlled by `statusline = 'lualine'` or `'galaxyline'`
- Only the selected one loads

### 5. Notification Systems
- **noice.nvim** (basic group) and **mini.notify** can coexist
- **mini.notify** is lighter alternative
- Both can be enabled simultaneously

## Dependency Chains

### LSP Chain
```
mason.nvim
  └─> Installs LSP servers
      └─> nvim-lspconfig
          └─> Configures LSP clients
              └─> conform.nvim (uses LSP for formatting)
              └─> codeaction.nvim (uses LSP for actions)
```

### Telescope Chain
```
telescope.nvim
  ├─> plenary.nvim (required)
  ├─> telescope-fzf-native.nvim (optional, faster)
  ├─> telescope-live-grep-args.nvim (enhanced grep)
  └─> harpoon (extension)
      └─> Uses telescope UI
```

### Treesitter Chain
```
nvim-treesitter
  └─> Provides syntax trees
      ├─> Used by trouble.nvim (diagnostics)
      ├─> Used by mini.hipatterns (highlighting)
      ├─> Used by noice.nvim (optional, can cause errors)
      └─> Powers many text objects and features
```

## Optional Dependencies

### System Requirements
- **telescope-fzf-native**: Requires `make` executable
  - Condition: `cond = vim.fn.executable('make') == 1`
  - Falls back gracefully if not available

### Feature Flags
- **nvim-web-devicons**: Optional for many plugins
  - mini.icons mocks it if not available
  - Other plugins work without it (reduced icons)

### Version Requirements
- Some plugins require Neovim 0.9+
- Checked via `cond = vim.fn.has('nvim-0.9') == 1`

## Load Order Dependencies

### Early Load (Priority 1000+)
1. Colorschemes (must load early)
2. Essential UI setup

### Normal Load (Priority 100-999)
1. Core options and keymaps
2. Basic plugins
3. LSP setup (mason → lspconfig → conform)
4. Treesitter
5. Completion system
6. Navigation plugins

### Late Load (Priority < 100)
1. Optional utilities
2. Experimental features

### Event-Based Load
- Most plugins load on `VeryLazy` event
- Some load on `BufRead`, `InsertEnter`, etc.
- Dependencies load before dependents

## Circular Dependency Prevention

### Pattern: Lazy Dependency Loading
```lua
-- Plugin A doesn't directly require Plugin B
-- Instead, uses lazy.nvim's dependency system
return {
  'plugin-a',
  dependencies = { 'plugin-b' },  -- lazy.nvim handles order
}
```

### Pattern: Optional Dependencies
```lua
-- Plugin works without dependency, enhanced with it
return {
  'plugin',
  dependencies = {
    { 'optional-dep', optional = true },
  },
  config = function()
    local has_dep = pcall(require, 'optional-dep')
    if has_dep then
      -- Enhanced configuration
    else
      -- Basic configuration
    end
  end,
}
```

## Dependency Resolution

### How lazy.nvim Resolves Dependencies

1. **Automatic Resolution**
   - lazy.nvim automatically loads dependencies first
   - Dependencies load before dependents
   - Circular dependencies are detected and reported

2. **Version Resolution**
   - Uses semantic versioning when specified
   - `version = '^1.0.0'` means compatible with 1.x
   - `version = '*'` means latest (default)

3. **Conditional Dependencies**
   - Use `cond` for system-specific dependencies
   - Use `optional = true` for optional enhancements

4. **Dependency Groups**
   - Dependencies can have their own dependencies
   - lazy.nvim builds a dependency tree
   - Loads in topological order

## Troubleshooting Dependencies

### Issue: Plugin Not Loading
- Check if dependencies are installed
- Run `:Lazy` to see dependency status
- Check for version conflicts

### Issue: Circular Dependency
- Restructure plugins to avoid cycles
- Use optional dependencies
- Use lazy loading to break cycles

### Issue: Missing Optional Dependency
- Plugin should work without it
- Check `cond` conditions
- Verify system requirements

### Issue: Wrong Load Order
- Use `priority` for critical plugins
- Use `dependencies` array for explicit ordering
- Check event-based loading conditions

## Best Practices

1. **Declare All Dependencies**
   - List all required dependencies
   - Include optional ones with `optional = true`

2. **Use Semantic Versioning**
   - Pin versions for stability
   - Use `^` for compatible updates
   - Use `~` for patch-only updates

3. **Handle Missing Dependencies**
   - Use `cond` for system requirements
   - Gracefully degrade if optional deps missing
   - Provide fallback configurations

4. **Avoid Circular Dependencies**
   - Restructure if cycles exist
   - Use lazy loading to break cycles
   - Consider plugin alternatives

5. **Document Dependencies**
   - Comment why dependencies are needed
   - Note optional vs required
   - Document system requirements
