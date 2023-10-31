local opt = vim.opt
local g = vim.g
local o = vim.o

------------ options ----------

if vim.fn.has("nvim-0.9.0") == 1 then
	opt.splitkeep = 'screen'
	opt.shortmess:append({ C = true })
end

o.hlsearch       = true -- Set highlight on search
o.mouse          = 'a' -- Enable mouse mode
o.breakindent    = true -- Enable break indent
o.undofile       = true -- Save undo history
o.ignorecase     = true -- Case insensitive searching UNLESS /C or capital in search
o.smartcase      = true -- Decrease update time
o.updatetime     = 250
o.termguicolors  = true -- Set colorscheme

o.foldexpr       = "nvim_treesitter#foldexpr()"
o.foldmethod     = "expr"

o.foldcolumn     = '0' -- '0' is not bad
o.foldlevel      = 99 -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = -1
o.foldenable     = true
o.fillchars      = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

opt.guifont      = 'JetbrainsMono Nerd Font:h13'
opt.laststatus   = 3 -- global statusline
opt.showmode     = false

-- opt.clipboard = "unnamedplus"
opt.cursorline   = true

-- Indenting
opt.expandtab    = true
opt.shiftwidth   = 2
opt.smartindent  = true
opt.tabstop      = 2
opt.softtabstop  = 2

-- opt.fillchars = { eob = " " }
opt.fillchars    = {
	fold = " ",
	foldopen = "",
	foldclose = "",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
opt.listchars    = {
	tab = ">>>",
	trail = "·",
	precedes = "←",
	extends = "→",
	eol = "↲",
	nbsp = "␣",
}
opt.ignorecase   = true
opt.smartcase    = true
opt.mouse        = "a"

opt.spelllang    = { "en" }
opt.scrolloff    = 4 -- Lines of context
opt.timeoutlen   = 300
opt.undofile     = true
opt.undolevels   = 10000
opt.updatetime   = 200             -- Save swap file and trigger CursorHold
opt.wildmode     = "longest:full,full" -- Command-line completion mode
opt.winminwidth  = 5               -- Minimum window width
opt.wrap         = false           -- Disable line wrap
opt.dictionary:append("~/.config/nvim/dictionary.txt")


-- Numbers
opt.number = true
opt.numberwidth = 1
opt.ruler = false

g.mapleader = " "
g.maplocalleader = "\\"
g.markdown_recommended_style = 0

-- Keymaps
require("config.keymaps").load_extra_options()
