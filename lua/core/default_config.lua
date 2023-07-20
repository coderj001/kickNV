local M = {}
local set = vim.keymap.set
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local opts_s = { silent = true }
local opts_e_s = { expr = true, silent = true }

M.options = {
	kicknv_branch = "master",
	name = "kickNV",
	figlet_name = {
		[[	 __   .__        __    ___________   ____ ]],
		[[	|  | _|__| ____ |  | __\      \   \ /   / ]],
		[[	|  |/ /  |/ ___\|  |/ //   |   \   Y   /  ]],
		[[	|    <|  \  \___|    </    |    \     /   ]],
		[[	|__|_ \__|\___  >__|_ \____|__  /\___/    ]],
		[[	     \/       \/     \/       \/          ]],
	}
}

M.ui = {
	hl_add = {},
	hl_override = {},
	changed_themes = {},
	theme_toggle = { "onedark", "one_light" },
	theme = "onedark", -- default theme
	transparency = true,
}

M.plugins = ""

M.opts = opts


M.keymap = keymap
M.set = set

M.keymaps = {
	default = function()
		set({ 'n', 'v' }, '<Space>', '<Nop>', opts_s)
		set('n', 'k', "v:count == 0 ? 'gk' : 'k'", opts_e_s)
		set('n', 'j', "v:count == 0 ? 'gj' : 'j'", opts_e_s)
		set("v", "<", "<gv")
		set("v", ">", ">gv")
	end
}


function M.load_extra_options()
	local function bind_extra_cmd(options)
		for optionCount = 1, #options do vim.cmd(options[optionCount]) end
	end
	local options = {
		"filetype plugin on", "filetype indent on", "cabbr Q q", "cabbr Q! q!",
		"cabbr W! w!", "cabbr W w", "cabbr WA wa", "cabbr Wa wa", "cabbr Wq wq",
		"cabbr WQ wq", "cabbr Qa qa", "cabbr QA qa"
	}
	bind_extra_cmd(options)
end

return M
