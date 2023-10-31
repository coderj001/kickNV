local Util = require("util")
local M = {}

local set = vim.keymap.set
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

M.version = "0.0.1"


M.defaults = {
	kicknv_branch = "kickNV",
	name = "kickNV",
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

M.opts = opts
M.keymap = keymap
M.set = set


M.json = {
	version = 2,
	data = {
		version = nil, ---@type string?
		colorscheme = nil, ---@type string?
		extras = {}, ---@type table<string, string>
	},
}

function M.json.load()
	local path = vim.fn.stdpath("config") .. "/kicknv.json"
	local f = io.open(path, "r")
	if f then
		local data = f:read("*a")
		f:close()
		local ok, json = pcall(vim.json.decode, data, {
			luanil = {
				object = true,
				array = true,
			},
		})
		if ok then
			M.json.data = vim.tbl_deep_extend("force", M.json.data, json or {})
			if M.json.data.version ~= M.json.version then
				Util.json.migrate()
			end
		end
	end
end

return M
