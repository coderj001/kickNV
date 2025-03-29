return {
    "NeogitOrg/neogit",
    event = {
      "CmdlineEnter",
      "InsertEnter",
      "CursorHold",
      "CursorMoved",
      "VimEnter",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "sindrets/diffview.nvim",
        lazy = true,
        enabled = true,
        event = "BufRead",
      },
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      {
        "<leader>l",
        mode = { "n" },
        "<CMD>Neogit kind=vsplit<CR>",
        desc = "NeoGit UI",
      },
    },
    config = function()
      require('neogit').setup {
        integrations = {
          telescope = true,
          diffview = true,
        }
      }
    end
  }
