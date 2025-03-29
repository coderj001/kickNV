local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand


-- augroup('MyCustomNeogitEvents', { clear = true })
-- autocmd('User', {
--   pattern = 'NeogitPushComplete',
--   group = 'MyCustomNeogitEvents',
--   callback = require('neogit').close,
-- })
--

-- Remove whitespace on save
autocmd('BufWritePre', {
  pattern = '',
  command = ":%s/\\s\\+$//e"
})

-- Set indentation to 2 spaces
augroup('setIndent', { clear = true })
autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript',
    'yaml', 'lua'
  },
  command = 'setlocal shiftwidth=2 tabstop=2'
})


vim.cmd([[command! Format :lua FormatWithLSP()]])

-- Define a function to trigger LSP formatting
function FormatWithLSP()
  vim.lsp.buf.format({ async = true })
end

vim.cmd([[command! LuaEditSnipFunc :lua LuaEditSnipFunc()]])

function LuaEditSnipFunc()
  require('luasnip.loaders.from_lua').edit_snippet_files()
end

-- Add this to your autocmds file
local cmp_augroup = vim.api.nvim_create_augroup("custom_cmp", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = cmp_augroup,
  callback = function()
    -- Set better colors for completion
    vim.api.nvim_set_hl(0, "CmpNormal", { link = "NormalFloat" })
    vim.api.nvim_set_hl(0, "CmpBorder", { link = "FloatBorder" })
    vim.api.nvim_set_hl(0, "CmpSel", { link = "PmenuSel" })
    vim.api.nvim_set_hl(0, "CmpDocNormal", { link = "NormalFloat" })
    vim.api.nvim_set_hl(0, "CmpDocBorder", { link = "FloatBorder" })
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", italic = true })
  end,
})
vim.cmd("doautocmd ColorScheme")
