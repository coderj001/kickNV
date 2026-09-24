# KickNV

My Lua Neovim configuration.

## Documentation

- **[Architecture](docs/ARCHITECTURE.md)** — Overview of the codebase structure
- **[Plugin Groups](docs/PLUGIN_GROUPS.md)** — Complete reference of all plugin groups
- **[Customization Guide](docs/CUSTOMIZATION.md)** — How to customize and extend KickNV

## Keybindings

The leader key is `<Space>`. This list covers custom mappings from enabled features. It does not repeat built-in Neovim or plugin-default mappings.

### Core editing and navigation

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `<leader>w` | Save the current file |
| Normal | `<leader>q` | Quit Neovim |
| Normal | `<leader>Q` | Quit without saving |
| Normal | `<leader>x` | Save and quit |
| Normal | `<leader>aa` | Hide the current buffer |
| Normal | `q` | Close the quickfix window |
| Normal | `<leader><Enter>` | Clear search highlighting |
| Normal | `<leader>bn` / `<leader>bp` | Go to the next / previous buffer |
| Normal | `<leader>bd` / `<leader>bD` | Delete the current buffer / force delete it |
| Normal | `<leader>bk` / `<leader>bl` | Wipe out / unshow the current buffer |
| Normal | `<leader>ws` / `<leader>wv` | Split the window horizontally / vertically |
| Normal | `<leader>wc` | Close the current window |
| Normal | `<C-Down>` / `<C-Up>` | Increase / decrease window height |
| Normal | `<C-Right>` / `<C-Left>` | Decrease / increase window width |
| Normal, Visual | `<A-h>` / `<A-l>` | Move the current line / selection left or right |
| Normal, Visual | `<A-j>` / `<A-k>` | Move the current line / selection down or up |
| Normal, Visual | `j` / `<Down>` | Move down by a display line, or a file line with a count |
| Normal, Visual | `k` / `<Up>` | Move up by a display line, or a file line with a count |
| Visual | `<` / `>` | Change indentation and keep the selection |
| Normal | `<leader>f` | Format the current buffer |
| Normal | `[d` / `]d` | Go to the previous / next diagnostic |
| Normal | `<leader>de` | Show the current diagnostic |

### Files and search

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `<leader>e` / `<leader>E` | Toggle NvimTree at the current file / working directory |
| Normal | `<leader>n` | Toggle NvimTree at the current file |
| Normal | `<leader>o` | Toggle the code outline |
| Normal | `<leader>k` | Swap syntax-tree nodes |
| NvimTree | `P` | Preview the selected entry |
| NvimTree | `s` / `S` | Open the selected entry in a vertical / horizontal split |
| Normal | `<leader>ff` | Find files |
| Normal | `<leader>fg` | Search text with live grep |
| Normal | `<leader>fb` | Find open buffers |
| Normal | `<leader>fh` | Search help tags |
| Normal | `<leader>.` | Resume the last Telescope picker |
| Normal | `<leader>?` | Find recently opened files |
| Normal | `<leader>/` | Search with live grep arguments |
| Visual | `<leader>sg` | Search the selected text |
| Normal | `<leader>sn` | Search Neovim configuration files |
| Normal | `<leader>sw` | Search for the word under the cursor |
| Normal | `<leader>st` | Search tags |
| Normal | `<leader>sq` | Search the quickfix list |
| Normal | `<leader>sr` | Search registers |
| Normal | `<leader>//` | Search open files |
| Normal | `<leader>sgc` / `<leader>sgb` / `<leader>sgs` | Search Git commits / branches / status |
| Normal | `<leader>fs` / `<leader>fx` | Find document symbols / LSP references |
| Normal, Visual | `<leader>gx` | Open the URL under the cursor or in the selection |

### LSP and code actions

These mappings work in buffers attached to an LSP server.

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `K` | Show hover information |
| Normal | `gd` / `gD` | Go to definition / declaration |
| Normal | `<leader>gi` | Go to implementation |
| Normal | `<leader>go` | Go to type definition |
| Normal | `<leader>gr` | Find references |
| Normal | `<leader>gg` | Rename the symbol |
| Normal | `<leader>ca` | Show code actions |
| Normal | `<leader>wa` / `<leader>wr` | Add / remove a workspace folder |
| Normal | `<leader>wl` | List workspace folders |

### Git

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `<leader>hs` | Stage the hunk under the cursor |
| Visual | `<leader>hs` | Stage the selected hunks |
| Normal | `<leader>hr` | Reset the hunk under the cursor |
| Visual | `<leader>hr` | Reset the selected hunks |
| Normal | `<leader>hS` / `<leader>hR` | Stage / reset the whole buffer |
| Normal | `<leader>hu` | Undo the last hunk stage |
| Normal | `<leader>hp` | Preview the hunk |
| Normal | `<leader>hb` | Show blame for the current line |
| Normal | `<leader>tb` | Toggle current-line blame |
| Normal, Visual | `<leader>hd` | Show the diff for the current file or selection |
| Normal | `<leader>hD` | Show the diff against the previous version |
| Normal | `<leader>td` | Toggle deleted-line display |

### Diagnostics lists

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `<leader>xx` | Toggle all diagnostics |
| Normal | `<leader>xX` | Toggle diagnostics for the current buffer |
| Normal | `<leader>xl` | Toggle the location list |
| Normal | `<leader>xq` | Toggle the quickfix list |

### Debugging

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `<F5>` / `<leader>dc` | Start or continue debugging |
| Normal | `<F9>` / `<leader>db` | Toggle a breakpoint |
| Normal | `<leader>dB` | Set a conditional breakpoint |
| Normal | `<F10>` | Step over |
| Normal | `<F11>` | Step into |
| Normal | `<F12>` | Step out |
| Normal | `<leader>dr` | Toggle the debug REPL |
| Normal | `<leader>dt` | Terminate debugging |
| Normal | `<leader>dl` | Run the last debug configuration |
| Normal | `<leader>du` | Toggle the debug UI |

In the debug UI, use `<Enter>` or double-click to expand an item. Use `o` to open, `d` to remove, `e` to edit, `r` to open the REPL, and `t` to toggle an item.

### Text objects, comments, and surround

| Mode | Key | Action |
| --- | --- | --- |
| Normal, Visual | `gc` | Toggle comments for a motion or selection |
| Normal | `gcc` | Toggle the comment on the current line |
| Normal, Visual | `sa{motion}{char}` | Add a surround, such as `saiw"` for quotes around a word |
| Normal | `sd{char}` | Delete a surround, such as `sd"` |
| Normal | `sr{old}{new}` | Replace a surround |
| Normal | `sf{char}` / `sF{char}` | Find a surround to the right / left |
| Normal | `sh{char}` | Highlight a surround |
| Normal | `sn` | Update the surround search range |
| Normal, Visual | `af` / `if` | Select around / inside a function |
| Normal, Visual | `ac` / `ic` | Select around / inside a class |
| Normal, Visual | `ao` / `io` | Select around / inside a block, conditional, or loop |

The surround operation also accepts standard text objects. For example, `saiw"` surrounds a word with double quotes.

### Completion and snippets

These mappings apply when the completion menu or a snippet is active.

| Key | Action |
| --- | --- |
| `<Tab>` / `<S-Tab>` | Move to the next / previous snippet field |
| `<C-j>` / `<C-k>` | Select the next / previous completion item |
| `<C-l>` | Accept the completion item |
| `<C-Space>` | Show completions or toggle completion documentation |
| `<C-d>` | Hide the completion menu |
| `<S-j>` / `<S-k>` | Scroll completion documentation down / up |
| `<C-g>` | Show ripgrep completion results |

### Other plugin mappings

| Mode | Key | Action |
| --- | --- | --- |
| Normal, Visual, Operator-pending | `S` | Jump with Flash |
| Normal, Visual, Operator-pending | `ss` | Jump to a Tree-sitter node with Flash |
| Operator-pending | `r` | Use Flash for a remote motion |
| Visual, Operator-pending | `R` | Search with Tree-sitter and Flash |
| Command-line | `<C-s>` | Toggle Flash search |
| Normal | `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Navigate between Neovim windows and tmux panes |
| Normal | `<C-\>` | Navigate to the previous Neovim window or tmux pane |
| Normal | `<leader>hx` | Add the current file to Harpoon |
| Normal | `<leader>hj` / `<leader>hk` | Go to the next / previous Harpoon mark |
| Normal | `<leader>hm` | Search Harpoon marks with Telescope |
| Normal | `<leader>se` | Edit a snippet |
| Normal, Visual | `<leader>sa` | Add a snippet |

For Markdown rendering, open a Markdown file and run `:RenderMarkdown toggle`. This command has no custom keybinding.
