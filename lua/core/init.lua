local opt = vim.opt
local g = vim.g
local o = vim.o

------------ options ----------

if vim.fn.has("nvim-0.9.0") == 1 then
  opt.splitkeep = 'screen'
end

-- Set highlight on search
o.hlsearch = true
-- Enable mouse mode
o.mouse = 'a'
-- Enable break indent
o.breakindent = true
-- Save undo history
o.undofile = true
-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true
-- Decrease update time
o.updatetime = 250
-- Set colorscheme
o.termguicolors = true

o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldmethod = "expr"

o.foldcolumn = '0' -- '0' is not bad
o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = -1
o.foldenable = true
o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

opt.laststatus = 3 -- global statusline
opt.showmode = false

-- opt.clipboard = "unnamedplus"
opt.cursorline = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

-- opt.fillchars = { eob = " " }
opt.fillchars = {
	fold = " ",
	foldopen = "",
	foldclose = "",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
opt.listchars = {
	tab = ">>>",
	trail = "·",
	precedes = "←",
	extends = "→",
	eol = "↲",
	nbsp = "␣",
}
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 1
opt.ruler = false

g.mapleader = " "
g.maplocalleader = " "


------------ autocommand ----------

require('core.default_config').load_extra_options()
