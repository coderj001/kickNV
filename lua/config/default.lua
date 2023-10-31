local M = {}

M.default = {
	defaults = {
		autocmds = false, -- config.autocmds
		keymaps = false, -- config.keymaps
		options = true, -- config.options
	},
	kicknv_branch = "kickNV",
	name = "kickNV",
	version = "0.0.1",
	figlet_name = {
		[[			 __   .__        __    ___________   ____ 			]],
		[[			|  | _|__| ____ |  | __\      \   \ /   / 			]],
		[[			|  |/ /  |/ ___\|  |/ //   |   \   Y   /  			]],
		[[			|    <|  \  \___|    </    |    \     /   			]],
		[[			|__|_ \__|\___  >__|_ \____|__  /\___/    			]],
		[[			     \/       \/     \/       \/          			]],
	},
	colorscheme = function()
		require("tokoynight").load()
	end,
	themes = {
		"tokyonight",
		"catppuccin",
	},
	transparent = true,
	icons = {
		git = {
			added    = " ",
			modified = " ",
			removed  = " ",
		},
		diagnostics = {
			Error = " ",
			Warn  = " ",
			Hint  = " ",
			Info  = " ",
		},
		kind = {
			Text = "",
			Method = "m",
			Function = "",
			Constructor = "",
			Field = "",
			Variable = "",
			Class = "",
			Interface = "",
			Module = "",
			Property = "",
			Unit = "",
			Value = "",
			Enum = "",
			Keyword = "",
			Snippet = "",
			Color = "",
			File = "",
			Reference = "",
			Folder = "",
			EnumMember = "",
			Constant = "",
			Struct = "",
			Event = "",
			Operator = "",
			TypeParameter = "",
		},
		cmp = {
			lsp = "",
			luasnip = "",
			treesitter = "",
			buffer = "",
			tags = "",
			rg = "",
			path = "",
			tmux = "",
		}
	}
}

return M
