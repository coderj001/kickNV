if true then
  return {
    'glepnir/galaxyline.nvim',
    event = 'UIEnter',
    dependencies = { "kyazdani42/nvim-web-devicons" },
    branch = 'main',
    config = function()
      require('utils.galaxyline')
    end,
  }
end
