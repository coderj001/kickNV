local statusline = require('core').plugin_groups.statusline
if type(statusline) == "string" then
  return {
    { import = "plugins.statusline." .. statusline },
  }
else
  return {
    { import = "plugins.statusline.lualine" },
  }
end
