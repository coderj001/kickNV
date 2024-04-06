if true then
  return {
    "embark-theme/vim",
    as = "embark",
    priority = 1000,
    config = function()
      vim.g.embark_terminal_italics=true
    end
  }
end

