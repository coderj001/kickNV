local ls = require("luasnip") --{{{
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("Lua Snippets", { clear = true })
local file_pattern = "*.lua"

local function cs(trigger, nodes, opts) --{{{
	local snippet = s(trigger, nodes)
	local target_table = snippets

	local pattern = file_pattern
	local keymaps = {}

	if opts ~= nil then
		-- check for custom pattern
		if opts.pattern then
			pattern = opts.pattern
		end

		-- if opts is a string
		if type(opts) == "string" then
			if opts == "auto" then
				target_table = autosnippets
			else
				table.insert(keymaps, { "i", opts })
			end
		end

		-- if opts is a table
		if opts ~= nil and type(opts) == "table" then
			for _, keymap in ipairs(opts) do
				if type(keymap) == "string" then
					table.insert(keymaps, { "i", keymap })
				else
					table.insert(keymaps, keymap)
				end
			end
		end

		-- set autocmd for each keymap
		if opts ~= "auto" then
			for _, keymap in ipairs(keymaps) do
				vim.api.nvim_create_autocmd("BufEnter", {
					pattern = pattern,
					group = group,
					callback = function()
						vim.keymap.set(keymap[1], keymap[2], function()
							ls.snip_expand(snippet)
						end, { noremap = true, silent = true, buffer = true })
					end,
				})
			end
		end
	end

	table.insert(target_table, snippet) -- insert snippet into appropriate table
end                                  --}}}

-- Start Refactoring --

local myFirstSnippet = s("myFirstSnippet",
	{
		t(
			"Lorem ipsum dolor sit amet, qui minim labore adipisicing minim sint cillum sint consectetur cupidatat. "),
		i(1, " placeholder_1"),
		t({ "", "this a another text" }),
	})
table.insert(snippets, myFirstSnippet)

local mySecondSnippet = s("mySecondSnippet", fmt([[
local {} = function({})
	{} {{ i'm in curly braces }}
end
]], {
	i(1, "M"),
	i(2, "args"),
	i(3, "-- TODO: Write the function"),
}))
table.insert(snippets, mySecondSnippet)

local myThirdSnippet = s("myThirdSnippet", fmt([[
local {} = function({})
	{} {{ i'm in curly braces }}
end
]], {
	i(1, "M"),
	c(2, { t(""), t("myArgs") }),
	i(3, "-- TODO: Write the function"),
}))
table.insert(snippets, myThirdSnippet)

local myFirstAutoSnippets = s({ trig = "digit(%d%d)", regTrig = true, hidden = false }, {
	i(1, "my variable"),
	f(function(arg, snip)
		return arg[1][1]:upper()
	end, 1),
})
table.insert(snippets, myFirstAutoSnippets)

local vcmd = s("cmd", {
	t("vim.cmd[[command! "),
	i(1, "write nvim command"),
	t(" ]]")
})
table.insert(snippets, vcmd)

-- End Refactoring --


return snippets, autosnippets
