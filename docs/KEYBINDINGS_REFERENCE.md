# Keybindings Quick Reference

## Current Keybindings

### Leader Key
- `<leader>` = `<Space>`

### Navigation
- `j/k` - Smart up/down (respects wrapped lines)
- `<C-Down/Up>` - Resize window height
- `<C-Left/Right>` - Resize window width
- `<leader><CR>` - Clear search highlight
- `q` - Close quickfix window

### File Operations
- `<leader>w` - Save file
- `<leader>aa` - Hide buffer

### Telescope (Search)
- `<leader>.` - Resume last search
- `<leader>?` - Recent files
- `<leader>sf` - Find files
- `<leader>sw` - Search current word
- `<leader>/` - Live grep
- `<leader>sg` - Grep visual selection
- `<leader>st` - Search tags
- `<leader>sq` - Quickfix
- `<leader>sr` - Registers
- `<leader><Space>` - Switch buffers
- `<leader>//` - Grep open files
- `<leader>sn` - Neovim config
- `<leader>sgc` - Git commits
- `<leader>sgb` - Git branches
- `<leader>sgs` - Git status
- `<leader>fx` - LSP references
- `<leader>fs` - LSP symbols

### LSP
- `K` - Hover
- `gd` - Go to definition
- `gD` - Go to declaration
- `<leader>gi` - Implementation
- `<leader>go` - Type definition
- `<leader>gr` - References
- `<leader>gg` - Rename
- `<leader>ca` - Code action

### Git (Gitsigns)
- `<leader>hs` - Stage hunk (normal/visual/buffer - **CONFLICT**)
- `<leader>hr` - Reset hunk (normal/visual/buffer - **CONFLICT**)
- `<leader>hu` - Undo stage hunk
- `<leader>hp` - Preview hunk
- `<leader>hb` - Blame line
- `<leader>tb` - Toggle blame
- `<leader>hd` - Diff this
- `<leader>td` - Toggle deleted

### Flash Navigation
- `S` - Flash jump
- `ss` - Flash treesitter
- `r` - Remote flash (operator)
- `R` - Treesitter search (operator)
- `<C-s>` - Toggle flash (command mode)

### Oil (File Explorer)
- `<leader>e` - Open oil (current dir)
- `<leader>E` - Open oil (root)

### Trouble (Diagnostics)
- `<leader>xx` - Toggle diagnostics
- `<leader>xX` - Buffer diagnostics
- `<leader>xl` - Location list
- `<leader>xq` - Quickfix list

### Harpoon
- `<leader>hx` - Mark file
- `<leader>hj` - Next mark
- `<leader>hk` - Previous mark
- `<leader>hm` - Telescope marks

### ISwap (Treesitter)
- `<leader>k` - Swap variables

### Code Actions
- `<leader>ca` - Code action (via tiny-code-action)

## Recommended New Keybindings

### Buffer Management
- `<leader>bn` - Next buffer
- `<leader>bp` - Previous buffer
- `<leader>bd` - Delete buffer
- `<leader>bD` - Force delete buffer

### Window Navigation
- `<A-h/j/k/l>` - Navigate windows (Alt + hjkl)
- `<leader>ws` - Split horizontal
- `<leader>wv` - Split vertical
- `<leader>wc` - Close window

### Quick Actions
- `<leader>q` - Quit
- `<leader>Q` - Quit without saving
- `<leader>x` - Save and quit
- `<leader>f` - Format buffer

### Telescope Quick Access
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Buffers
- `<leader>fh` - Help tags

### Diagnostics
- `[d` - Previous diagnostic
- `]d` - Next diagnostic
- `<leader>e` - Show diagnostic (currently used by Oil)

### LSP Workspace
- `<leader>wa` - Add workspace folder
- `<leader>wr` - Remove workspace folder
- `<leader>wl` - List workspace folders

## Keybinding Conflicts to Fix

1. **Git**: `<leader>hs` - Used 3 times (normal, visual, normal)
2. **Git**: `<leader>hr` - Used 3 times (normal, visual, normal)
3. **Oil vs Diagnostics**: `<leader>e` - Used by both Oil and recommended for diagnostics

## Suggested Conflict Resolution

### Git Keybindings (Recommended)
- Stage: `<leader>gs` (git stage)
- Reset: `<leader>gr` (git reset) - **CONFLICTS with LSP references**
- Alternative: Use `<leader>gS` for stage, `<leader>gR` for reset
- Or: Use `<leader>hs` for stage, `<leader>hr` for reset (keep current, but fix duplicates)

### Oil vs Diagnostics
- Keep Oil: `<leader>e` (current dir), `<leader>E` (root)
- Diagnostics: Use `<leader>de` (diagnostic error) or `<leader>d` (diagnostic)

## Keybinding Patterns

### Search/Navigation: `<leader>s*`
- Files, grep, buffers, etc.

### Git: `<leader>h*` or `<leader>g*`
- Hunk operations, git status

### LSP: `<leader>g*` or `<leader>l*`
- Go to, references, etc.

### Window: `<leader>w*`
- Window operations

### Buffer: `<leader>b*`
- Buffer operations

### Diagnostics: `<leader>x*` or `<leader>d*`
- Trouble, diagnostics
