local M = {}

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
