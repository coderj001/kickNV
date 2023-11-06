if true then
  return {
    "LeoRiether/wasp.nvim",
    config = function()
      require('wasp').setup {
        template_path = function() return 'lib/template.' .. vim.fn.expand("%:e") end,
        lib = {
          finder = 'telescope', -- or 'fzf'
          path = 'lib/',
        },
        competitive_companion = { file = 'inp' },
      }
    end
  }
end
