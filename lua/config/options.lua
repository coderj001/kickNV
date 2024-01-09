-----------------------------------------------------------
-- General Neovim options setting
-----------------------------------------------------------

local g = vim.g
local opt = vim.opt


if vim.fn.has("nvim-0.9.0") == 1 then
  opt.splitkeep = 'screen'
  opt.shortmess:append({ C = true })
end

-----------------------------------------------------------
-- General
-----------------------------------------------------------

opt.mouse       = 'a'                         -- Enable mouse mode
-- opt.clipboard   = "unnamedplus"               -- Copy/paste to system clipboard
opt.swapfile    = false                       -- Don't use swapfile
opt.completeopt = 'menuone,noinsert,noselect' -- Autocomplete options



opt.hlsearch       = true -- Set highlight on search
opt.breakindent    = true -- Enable break indent
opt.undofile       = true -- Save undo history
opt.ignorecase     = true -- Case insensitive searching UNLESS /C or capital in search
opt.smartcase      = true -- Decrease update time
opt.termguicolors  = true -- Set colorscheme

opt.foldexpr       = "nvim_treesitter#foldexpr()"
opt.foldmethod     = "expr"

opt.foldcolumn     = '0' -- '0' is not bad
opt.foldlevel      = 99  -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = -1
opt.foldenable     = true
opt.fillchars      = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

opt.guifont        = 'JetbrainsMono Nerd Font:h13'
opt.laststatus     = 3 -- global statusline
opt.showmode       = false

opt.cursorline     = true

-- Indenting
opt.expandtab      = true
opt.shiftwidth     = 2
opt.smartindent    = true
opt.tabstop        = 2
opt.softtabstop    = 2

-- opt.fillchars = { eob = " " }
opt.fillchars      = {
  fold = " ",
  foldopen = "",
  foldclose = "",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.list           = false
opt.listchars      = {
  tab = ">>>",
  trail = "·",
  precedes = "←",
  extends = "→",
  eol = "↲",
  nbsp = "␣",
  -- leadmultispace = "│ "
  leadmultispace = " "
}
opt.ignorecase     = true
opt.smartcase      = true

opt.spelllang      = { "en" }
opt.scrolloff      = 4 -- Lines of context
opt.timeoutlen     = 300
opt.undofile       = true
opt.undolevels     = 500
opt.wildmode       = "longest:full,full" -- Command-line completion mode
opt.winminwidth    = 5                   -- Minimum window width
opt.wrap           = true                -- Disable line wrap

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden         = true -- Enable background buffers
opt.history        = 100  -- Remember N lines in history
opt.lazyredraw     = true -- Faster scrolling
opt.synmaxcol      = 240  -- Max column for syntax highlight
opt.updatetime     = 250  -- ms to wait for trigger an event

-- Disable nvim intro
opt.shortmess:append "sI"



-- Numbers
opt.number = true
opt.numberwidth = 1
opt.ruler = false

g.mapleader = " "
g.maplocalleader = "\\"
g.markdown_recommended_style = 0
g.skip_ts_context_commentstring_module = true
