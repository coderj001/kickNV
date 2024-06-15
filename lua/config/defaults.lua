local M = {}

M.config = {
  figlet_name = {
    [[			 __   .__        __    ___________   ____ 			]],
    [[			|  | _|__| ____ |  | __\      \   \ /   / 			]],
    [[			|  |/ /  |/ ___\|  |/ //   |   \   Y   /  			]],
    [[			|    <|  \  \___|    </    |    \     /   			]],
    [[			|__|_ \__|\___  >__|_ \____|__  /\___/    			]],
    [[			     \/       \/     \/       \/          			]],
  },
  themes = {
    "tokyonight",
    "catppuccin",
    "kanagawa",
    "nightfox",
    "night-owl",
    "dracula",
    "embark",
    "witch"
  },
  colorscheme = "nightfox",
  substitute_colorscheme = "carbonfox",
  transparent_background = true
}

function M.setup()
end

return M
