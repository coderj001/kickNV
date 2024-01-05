if true then
  return {
    "wincent/scalpel",
    event = "VimEnter",
    config = function()
      vim.g.ScalpelMap = 0
      vim.g.ScalpelCommand = 'S'
      vim.g.ScalpelLoaded = 1
    end
  }
end
