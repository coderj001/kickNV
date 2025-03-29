if vim.g.vscode then
  require("code.code")
else
  require("core").setup()
end
