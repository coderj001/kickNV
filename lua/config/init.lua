require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
local color_scheme = require("config.defaults").config.colorscheme
vim.cmd("colorscheme " .. color_scheme)
