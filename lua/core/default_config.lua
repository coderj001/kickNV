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

M.servers = {
	clangd = {},
	gopls = {},
	pyright = {
		settings = {
			python = {
				analysis = {
					typeCheckingMode = "off",
				},
			},
		},
	},
	rust_analyzer = {},
	jsonls = {
		settings = {
			json = {
				schemas = {},
			},
		},
		setup = {
			commands = {
				Format = {
					function()
						vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
					end,
				},
			},
		},
	},
	tsserver = {},
	lua_ls = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			library = {
				[vim.fn.expand("$VIMRUNTIME/lua")] = true,
				[vim.fn.stdpath("config") .. "/lua"] = true,
			},
		},
	},
}

M.on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end

	nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
	-- nmap('<leader>D', vim.lsp.buf.type_definition, '[T]ype [D]efinition')
	-- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
	-- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

	-- See `:help K` for why this keymap
	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	-- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Lesser used LSP functionality
	nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	-- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
	-- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
	-- nmap('<leader>wl', function()
	--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, '[W]orkspace [L]ist Folders')

	-- Create a command `:Format` local to the LSP buffer
	-- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
	-- 	vim.lsp.buf.format()
	-- end, { desc = 'Format current buffer with LSP' })
end

M.keymap = keymap
M.set = set

M.keymaps = {
	default = function()
		set({ 'n', 'v' }, '<Space>', '<Nop>', opts_s)
		set('n', 'k', "v:count == 0 ? 'gk' : 'k'", opts_e_s)
		set('n', 'j', "v:count == 0 ? 'gj' : 'j'", opts_e_s)
		set("v", "<", "<gv")
		set("v", ">", ">gv")
		-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
		set('n', '<A-h>', require('smart-splits').resize_left)
		set('n', '<A-j>', require('smart-splits').resize_down)
		set('n', '<A-k>', require('smart-splits').resize_up)
		set('n', '<A-l>', require('smart-splits').resize_right)
		-- moving between splits
		set('n', '<C-h>', require('smart-splits').move_cursor_left)
		set('n', '<C-j>', require('smart-splits').move_cursor_down)
		set('n', '<C-k>', require('smart-splits').move_cursor_up)
		set('n', '<C-l>', require('smart-splits').move_cursor_right)
		-- swapping buffers between windows
		set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
		set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
		set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
		set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)
		print("Hi, Here")
	end
}

return M
