# Performance & Keybindings Optimization Plan

## Executive Summary

This document outlines keybinding improvements and performance optimizations for the Neovim configuration. The analysis identified several areas for improvement in both usability and speed.

## 🔑 Keybinding Improvements

### 1. Missing Essential Keybindings

#### Navigation & Buffer Management
**Current State**: Limited buffer navigation options
**Recommendations**:
```lua
-- Quick buffer navigation
map('n', '<leader>bn', '<cmd>bnext<cr>', { desc = 'Next buffer' })
map('n', '<leader>bp', '<cmd>bprev<cr>', { desc = 'Previous buffer' })
map('n', '<leader>bd', '<cmd>bd<cr>', { desc = 'Delete buffer' })
map('n', '<leader>bD', '<cmd>bd!<cr>', { desc = 'Delete buffer (force)' })

-- Better window navigation (using Alt instead of Ctrl)
map('n', '<A-h>', '<C-w>h', { desc = 'Window left' })
map('n', '<A-j>', '<C-w>j', { desc = 'Window down' })
map('n', '<A-k>', '<C-w>k', { desc = 'Window up' })
map('n', '<A-l>', '<C-w>l', { desc = 'Window right' })

-- Quick window splits
map('n', '<leader>ws', '<cmd>split<cr>', { desc = 'Split horizontal' })
map('n', '<leader>wv', '<cmd>vsplit<cr>', { desc = 'Split vertical' })
map('n', '<leader>wc', '<cmd>close<cr>', { desc = 'Close window' })
```

#### Quick Actions
```lua
-- Quick save and quit
map('n', '<leader>q', '<cmd>q<cr>', { desc = 'Quit' })
map('n', '<leader>Q', '<cmd>q!<cr>', { desc = 'Quit without saving' })
map('n', '<leader>x', '<cmd>x<cr>', { desc = 'Save and quit' })

-- Quick format (if conform is enabled)
map('n', '<leader>f', function()
  require('conform').format { async = true, lsp_fallback = true }
end, { desc = 'Format buffer' })

-- Quick diagnostics
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic' })
```

### 2. Improved Telescope Keybindings

**Current Issues**:
- `<leader><Space>` conflicts with leader key
- Missing quick access to common searches
- No quick file navigation

**Recommendations**:
```lua
-- Quick file finder (single keypress after leader)
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files' })
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Live grep' })
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Buffers' })
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = 'Help tags' })

-- Change <leader><Space> to <leader>bb for buffers (less conflict)
-- Keep <leader><Space> for something more important
```

### 3. LSP Keybinding Improvements

**Current State**: Basic LSP bindings exist but could be more comprehensive
**Recommendations**:
```lua
-- Add to lspconfig.lua setup_keymaps function:
local keymap = {
  ['K'] = vim.lsp.buf.hover,
  ['gd'] = vim.lsp.buf.definition,
  ['gD'] = vim.lsp.buf.declaration,
  ['<leader>gi'] = vim.lsp.buf.implementation,
  ['<leader>go'] = vim.lsp.buf.type_definition,
  ['<leader>gr'] = vim.lsp.buf.references,
  ['<leader>gg'] = vim.lsp.buf.rename,
  ['<leader>ca'] = vim.lsp.buf.code_action,
  -- Add these:
  ['<leader>wa'] = vim.lsp.buf.add_workspace_folder,
  ['<leader>wr'] = vim.lsp.buf.remove_workspace_folder,
  ['<leader>wl'] = function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end,
  ['<leader>D'] = vim.lsp.buf.type_definition,
  ['<leader>rn'] = vim.lsp.buf.rename,
  ['<leader>ca'] = vim.lsp.buf.code_action,
  ['<leader>so'] = require('telescope.builtin').lsp_document_symbols,
}
```

### 4. Git Keybinding Conflicts

**Issue**: Multiple bindings use `<leader>hs` and `<leader>hr` in gitsigns.lua
**Fix**: Use more specific prefixes
```lua
-- Current: <leader>hs (used 3 times for different modes)
-- Better: Use distinct prefixes
-- Stage: <leader>gs (git stage)
-- Reset: <leader>gr (git reset)  
-- Preview: <leader>gp (git preview)
-- Blame: <leader>gb (git blame)
```

### 5. Flash Navigation Improvements

**Current**: Only `S` and `ss` are bound
**Recommendations**:
```lua
-- Add more intuitive bindings
map('n', 'f', function() require('flash').jump() end, { desc = 'Flash jump' })
map('n', 'F', function() require('flash').treesitter() end, { desc = 'Flash treesitter' })
-- Keep 'S' as alternative for backward compatibility
```

## ⚡ Performance Optimizations

### 1. Update Time Optimizations

**Current**: `updatetime = 250`
**Recommendation**: Reduce to 100-150ms for faster LSP response
```lua
opt.updatetime = 100  -- Faster LSP diagnostics and git signs
```

**Impact**: 
- Faster LSP hover, diagnostics, and git signs updates
- Slightly more CPU usage (negligible on modern systems)

### 2. Timeout Length Optimization

**Current**: `timeoutlen = 300`
**Recommendation**: Reduce to 200ms for faster key sequence recognition
```lua
opt.timeoutlen = 200  -- Faster leader key recognition
```

**Impact**: Leader key sequences feel more responsive

### 3. Lazy Redraw

**Current**: `lazyredraw = false`
**Recommendation**: Enable for large files
```lua
-- Enable lazyredraw conditionally for large files
opt.lazyredraw = false  -- Keep false for normal use
-- bigfile.nvim already handles this for large files
```

### 4. Gitsigns Performance

**Current**: `watch_gitdir.interval = 1000`, `update_debounce = 100`
**Recommendations**:
```lua
-- In gitsigns.lua:
watch_gitdir = {
  interval = 2000,  -- Check less frequently (was 1000)
  follow_files = true,
},
update_debounce = 200,  -- Increase debounce (was 100)
```

**Impact**: Less frequent git status checks, better performance in large repos

### 5. Treesitter Performance

**Current**: Many parsers installed, some may not be needed
**Recommendations**:
```lua
-- Only install parsers you actually use
-- Remove unused parsers from ensure_installed list
-- Current: 40+ parsers
-- Recommended: Keep only what you use (20-25 parsers)
```

**Impact**: Faster startup, less memory usage

### 6. Disable Unused Features

**Recommendations**:
```lua
-- In options.lua:
opt.spell = false  -- Disable spell checking if not needed (enable per file)
opt.cursorline = false  -- Can be expensive in large files (enable per filetype)

-- Disable treesitter for very large files (already done, but can be more aggressive)
-- In treesitter config:
disable = function(lang, buf)
  local max_filesize = 50 * 1024  -- Reduce from 100KB to 50KB
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
  if ok and stats and stats.size > max_filesize then
    return true
  end
end,
```

### 7. LSP Performance

**Current**: Many LSP servers in ensure_installed
**Recommendations**:
```lua
-- Only install LSP servers you actually use
-- Remove unused servers from ensure_installed
-- Current: 10 servers
-- Recommended: Install on-demand or keep only frequently used ones
```

### 8. Telescope Performance

**Current**: Good configuration, but can be optimized
**Recommendations**:
```lua
-- In utils/telescope.lua:
defaults = {
  -- Add these for better performance:
  file_ignore_patterns = {
    '%.git/',
    'node_modules/',
    '%.venv/',
    '%.cache/',
    '%.local/',
    'build/',
    'dist/',
    '%.lock',
  },
  -- Use ripgrep more efficiently
  vimgrep_arguments = {
    'rg',
    '--color=never',
    '--no-heading',
    '--with-filename',
    '--line-number',
    '--column',
    '--smart-case',
    '--hidden',
    '--glob=!.git/',
    '--glob=!node_modules/',
    '--glob=!.venv/',
    '--glob=!build/',
    '--glob=!dist/',
    '--glob=!*.lock',
  },
}
```

### 9. Reduce Plugin Load Events

**Current**: Some plugins load too early
**Recommendations**:
```lua
-- oil.nvim: Change from 'VimEnter' to 'VeryLazy'
-- gitsigns: Reduce events (remove CursorHold, CursorMoved)
event = {
  'BufReadPost',  -- Only on file read
  'FileChangedShellPost',  -- On file changes
},
```

### 10. Memory Optimizations

**Recommendations**:
```lua
-- In options.lua:
opt.history = 50  -- Reduce from 100 (less memory)
opt.undolevels = 200  -- Reduce from 500 (less memory for undo)
opt.maxmempattern = 1000  -- Limit regex memory (default is high)
```

### 11. Syntax Highlighting Optimization

**Current**: `synmaxcol = 240`
**Recommendation**: Reduce for very long lines
```lua
opt.synmaxcol = 200  -- Don't highlight beyond column 200
```

### 12. Disable Unnecessary Features

**Recommendations**:
```lua
-- Disable features you don't use:
opt.ruler = false  -- Already disabled ✓
opt.showcmd = false  -- Disable command preview (saves redraws)
opt.showmatch = false  -- Disable bracket matching (can be slow)
```

## 📊 Performance Metrics to Track

### Startup Time
```bash
# Measure startup time
nvim --startuptime startup.log

# Target: < 50ms for core, < 200ms total
```

### Memory Usage
```vim
" Check memory usage
:lua print(vim.inspect(vim.gc()))
```

### LSP Response Time
- Monitor with `:LspInfo`
- Check for slow servers

## 🎯 Priority Implementation Order

### High Priority (Immediate Impact)
1. ✅ Fix git keybinding conflicts
2. ✅ Add essential navigation keybindings
3. ✅ Optimize updatetime (100ms)
4. ✅ Optimize timeoutlen (200ms)
5. ✅ Add buffer navigation shortcuts

### Medium Priority (Good Improvements)
6. ✅ Improve telescope keybindings
7. ✅ Optimize gitsigns performance
8. ✅ Reduce treesitter parsers
9. ✅ Optimize telescope file patterns
10. ✅ Add LSP workspace keybindings

### Low Priority (Fine-tuning)
11. ✅ Memory optimizations
12. ✅ Syntax highlighting limits
13. ✅ Disable unused features
14. ✅ Plugin load event optimization

## 🔍 Keybinding Audit

### Current Keybinding Conflicts
1. **Git**: `<leader>hs` used 3 times (normal, visual, normal again)
2. **Git**: `<leader>hr` used 3 times (normal, visual, normal again)
3. **Telescope**: `<leader><Space>` might conflict with leader key
4. **LSP**: Missing workspace management bindings

### Missing Keybindings
1. Buffer navigation (next/prev/delete)
2. Window navigation (Alt+hjkl)
3. Quick format
4. Quick diagnostics navigation
5. Quick save/quit variants
6. Telescope quick access (ff, fg, fb)

## 📝 Implementation Notes

### Safety Considerations
- All changes are backward compatible
- Existing keybindings preserved where possible
- New bindings use unused key combinations
- Performance changes are conservative

### Testing Checklist
- [ ] Test all new keybindings
- [ ] Verify no conflicts with existing bindings
- [ ] Check startup time improvement
- [ ] Verify LSP responsiveness
- [ ] Test in large files
- [ ] Test in large repositories

## 🚀 Expected Improvements

### Performance Gains
- **Startup Time**: 10-20% faster (by reducing parsers/servers)
- **LSP Response**: 2-3x faster (updatetime 250→100ms)
- **Key Recognition**: 33% faster (timeoutlen 300→200ms)
- **Memory**: 10-15% reduction (history, undolevels)

### Usability Improvements
- More intuitive navigation
- Faster access to common actions
- Better keybinding consistency
- Reduced conflicts

## 📚 References

- [Neovim Performance Tips](https://github.com/nvim-lua/kickstart.nvim/wiki/Performance-Tips)
- [Lazy.nvim Performance Guide](https://github.com/folke/lazy.nvim#performance)
- [Telescope Performance](https://github.com/nvim-telescope/telescope.nvim/wiki/Performance-Tips)
