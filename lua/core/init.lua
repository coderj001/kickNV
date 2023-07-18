local opt = vim.opt
local g = vim.g
local o = vim.o

------------ options ----------

-- Set highlight on search
o.hlsearch = false
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

opt.laststatus = 3 -- global statusline
opt.showmode = false

opt.clipboard = "unnamedplus"
opt.cursorline = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false


g.mapleader = " "
g.maplocalleader = " "


------------ autocommand ----------

