local Util = require("util")
local M = {}

local set = vim.keymap.set
local keymap = vim.api.nvim_set_keymap
local default = require("config.default").default
local opts = { noremap = true, silent = true }

M.opts = opts
M.keymap = keymap
M.set = set
M.default = default


M.json = {
	version = 2,
	data = {
		version = nil, ---@type string?
		colorscheme = nil, ---@type string?
		news = {}, ---@type table<string, string>
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

---@param name "autocmds" | "options" | "keymaps"
function M.load(name)
	if M.defaults[name] or name == "options" then
		require("config." .. name)
	end
end

function M.setup(opts)
end

return M
