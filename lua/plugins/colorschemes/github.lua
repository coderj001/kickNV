if true then
  return {
    "projekt0n/github-nvim-theme",
    name = 'github-theme',
    priority = 1000,
    config = function()
      require('github-theme').setup({
        options = {
          transparent = true,
          styles = {
            comments = 'italic',
            keywords = 'bold',
            types = 'italic,bold',
          },
          darken = {
            floats = false,
            sidebars = {
              enable = true,
              list = {},
            },
          },
        }
      })
    end
  }
end

