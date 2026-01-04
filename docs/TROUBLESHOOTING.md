# Troubleshooting Guide

## Noice.nvim Treesitter Query Error

### Error Message
```
Error noice.nvim /usr/share/nvim/runtime/lua/vim/treesitter/query.lua:373: Query error at 130:4. Invalid node type "substitute"
```

### Cause
Noice.nvim uses treesitter queries for markdown rendering, and one of its query files references a "substitute" node type that doesn't exist in the current treesitter parser version.

### Solutions

#### Solution 1: Update Treesitter Parsers (Recommended)
Run this command in Neovim:
```vim
:TSUpdate
```

This updates all treesitter parsers to their latest versions, which may include the missing node type.

#### Solution 2: Update Noice.nvim
Update noice.nvim to the latest version which may have fixed query files:
```vim
:Lazy update noice.nvim
```

#### Solution 3: Disable Treesitter Integration in Noice
If the above don't work, you can disable treesitter markdown rendering in noice by editing `lua/plugins/basic/noice.lua` and ensuring all treesitter overrides are disabled (already done in current config).

#### Solution 4: Manual Query File Fix
If you need to fix it manually:
1. Find noice.nvim's query files: `~/.local/share/nvim/lazy/noice.nvim/queries/`
2. Look for files referencing "substitute" node type
3. Remove or comment out the problematic query lines

### Current Workaround
The current configuration suppresses the error message, but the underlying issue may still cause problems. It's recommended to update treesitter parsers using `:TSUpdate`.
