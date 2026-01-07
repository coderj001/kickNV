if true then
  return {
    'LunarVim/bigfile.nvim',
    event = 'BufRead',
    opts = {
      features = {
        'illuminate',
        'treesitter',
        'syntax',
        'matchparen',
        'vimopts',
      },
    },
  }
end
