vim.cmd([[command! Format :lua FormatWithLSP()]])

-- Define a function to trigger LSP formatting
function FormatWithLSP()
  vim.lsp.buf.format({ async = true })
end
