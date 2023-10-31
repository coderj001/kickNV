return {
  {
    -- tmux nav for nvim
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
  {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>n", mode = { "n" }, "<CMD>Oil<CR>", desc = "Oil Explorer" },
    },
    opts = {
      default_file_explorer = true,
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
    },
  },
  "jiangmiao/auto-pairs",
  { "tpope/vim-surround", event = "BufEnter" },
  { "tpope/vim-repeat",   event = "BufEnter" },
}
