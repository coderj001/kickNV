local M = {}

M.options = {
	kicknv_branch = "master"
}

M.ui = {
	hl_add = {},
	hl_override = {},
	changed_themes = {},
	theme_toggle = { "onedark", "one_light" },
	theme = "onedark",    -- default theme
	transparency = false,
	lsp_semantic_tokens = false, -- needs nvim v0.9, just adds highlight groups for lsp semantic tokens
}

M.plugins = "" -- path i.e "custom.plugins", so make custom/plugins.lua file

return M
