return {
  { "jiangmiao/auto-pairs", event = "BufEnter" },
  { "tpope/vim-surround",   event = "BufEnter" },
  { "tpope/vim-repeat",     event = "BufEnter" },
  {
    "folke/neoconf.nvim",
    cmd = "Neoconf",
    config = function()
      require("neoconf").setup()
    end
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    config = function()
      require("plugins.extras.ufo").setup()
    end
  },
  { -- tmux nav for nvim
    "alexghergh/nvim-tmux-navigation",
    event = "VeryLazy",
    config = function()
      require "nvim-tmux-navigation".setup {
        disable_when_zoomed = true,
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
        }
      }
    end
  },
}
