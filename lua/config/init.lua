require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
local color_scheme = require("config.defaults").config.colorscheme
local substitute_color_scheme = require("config.defaults").config.substitute_colorscheme
if substitute_color_scheme then
  vim.cmd("colorscheme " .. substitute_color_scheme)
else
  vim.cmd("colorscheme " .. color_scheme)
end
