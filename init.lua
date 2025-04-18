if vim.g.vscode then
  require("code.vscode")
else
  require("core").setup()
end
