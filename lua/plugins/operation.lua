return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("plugin.config.indent_blankline").setup()
    end
  },
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
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    cmd = "BqfAutoToggle",
    event = "QuickFixCmdPost",
  },
  {
    -- Lastplace
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("plugins.extras.lastplace").setup()
    end
  },
  {
    "monaqa/dial.nvim",
    event = "VeryLazy",
    keys = { "<C-a>", { "<C-x>", mode = "n" } },
  },
  {
    "mvllow/modes.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.extras.modes").setup()
    end
  },
  {
    "gen740/SmoothCursor.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.extras.smoothcursor").setup()
    end
  },

  {
    "NTBBloodbath/rest.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("plugin.config.rest").setup()
    end
  },
}
