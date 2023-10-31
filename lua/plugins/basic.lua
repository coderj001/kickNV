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
    "stevearc/oil.nvim",
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

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup {
        mapping = { "jk" }, -- a table with mappings to use
      }
    end
  },
  {
    -- Lastplace
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      local status, lastplace = pcall(require, "nvim-lastplace")
      if (not status) then return end
      lastplace.setup({
        lastplace_ignore_buftype = {
          "quickfix",
          "nofile",
          "help",
        },
        lastplace_ignore_filetype = {
          "gitcommit",
          "gitrebase",
          "svn",
          "hgcommit",
        },
        lastplace_open_folds = true,
      })
    end
  },
  {
    "monaqa/dial.nvim",
    event = "VeryLazy",
    keys = { "<C-a>", { "<C-x>", mode = "n" } },
  },
}
