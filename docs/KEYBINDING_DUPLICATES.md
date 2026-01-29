# Keybinding Duplicates Analysis

## 🔍 Duplicates Found

### Telescope Duplicates (Same Functionality)

1. **Find Files**:
   - `<leader>sf` (line 42) - `[s]earch [f]iles`
   - `<leader>ff` (line 143) - `[f]ind [f]iles` ✨ NEW (duplicate)
   - **Action**: Remove `<leader>sf`, keep `<leader>ff` (shorter, more intuitive)

2. **Live Grep**:
   - `<leader>/` (line 58) - `[s]earch by [/]Grep`
   - `<leader>fg` (line 151) - `[f]ind by [g]rep` ✨ NEW (duplicate)
   - **Action**: Keep both (different use cases: `/` is quick, `fg` is explicit)

3. **Buffers**:
   - `<leader><Space>` (line 98) - `Switch Buffers`
   - `<leader>fb` (line 159) - `[f]ind [b]uffers` ✨ NEW (duplicate)
   - **Action**: Remove `<leader><Space>`, keep `<leader>fb` (more consistent)

### Conflicts (Different Functionality, Same Key)

1. **Format vs Find Files**:
   - `<leader>ff` in telescope (line 143) - Find files
   - `<leader>ff` in conform.lua (line 7) - Format buffer ⚠️ CONFLICT
   - **Action**: Change conform to `<leader>cf` (conform format)

2. **Quit vs Quickfix**:
   - `<leader>q` in keymaps.lua (line 54) - Quit
   - `<leader>q` in quicker.lua (line 8) - Toggle quickfix
   - **Status**: Quicker is disabled (`if false`), so no conflict currently

### Mini.pick Duplicates (If Enabled)

1. **Find Files**:
   - `<leader>sf` in telescope - Find files
   - `<leader>sf` in mini.pick.lua (line 68) - Find files
   - **Status**: Only conflicts if mini.pick is enabled

2. **Live Grep**:
   - `<leader>/` in telescope - Live grep
   - `<leader>/` in mini.pick.lua (line 82) - Live grep
   - **Status**: Only conflicts if mini.pick is enabled

3. **Oldfiles**:
   - `<leader>?` in telescope - Oldfiles
   - `<leader>?` in mini.pick.lua (line 80) - Oldfiles
   - **Status**: Only conflicts if mini.pick is enabled

### Internal Duplicates

1. **Mini.pick**:
   - `<leader>sgc` appears twice (lines 71 and 74) - Same binding!
   - **Action**: Remove duplicate

## 📋 Recommended Fixes

### High Priority (Active Conflicts)

1. ✅ Remove `<leader>sf` from telescope (keep `<leader>ff`)
2. ✅ Remove `<leader><Space>` from telescope (keep `<leader>fb`)
3. ✅ Change conform `<leader>ff` to `<leader>cf`
4. ✅ Remove duplicate `<leader>sgc` in mini.pick.lua

### Medium Priority (If mini.pick enabled)

5. ⚠️ Resolve mini.pick vs telescope conflicts (if mini.pick is used)

### Low Priority (Keep Both)

6. ✅ Keep `<leader>/` and `<leader>fg` (both useful)

## 🎯 Final Keybinding Strategy

### Telescope (Keep These)
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Buffers
- `<leader>fh` - Help tags
- `<leader>/` - Live grep (quick)
- `<leader>?` - Oldfiles
- `<leader>sw` - Search current word
- `<leader>st` - Search tags
- `<leader>sq` - Quickfix
- `<leader>sr` - Registers
- `<leader>sn` - Neovim config
- `<leader>//` - Grep open files
- `<leader>sgc/sgb/sgs` - Git operations
- `<leader>fx/fs` - LSP operations

### Remove These
- `<leader>sf` - Duplicate of `<leader>ff`
- `<leader><Space>` - Duplicate of `<leader>fb`

### Change These
- Conform: `<leader>ff` → `<leader>cf`
