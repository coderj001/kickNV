if true then
  return {
    'chrishrb/gx.nvim',
    keys = {
      {
        '<leader>gx',
        '<cmd>Browse<cr>',
        mode = { 'n', 'x' },
      },
      desc = 'Browse Url',
    },
    cmd = { 'Browse' },
    init = function()
      vim.g.netrw_nogx = 1
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = true,
    submodules = false,
  }
else
  return {}
end
