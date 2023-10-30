-- Telescope
return {
  {
    "nvim-telescope/telescope.nvim",
    event = { "VimEnter" },
    cmd = { "Telescope" },
    version = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
        cond = vim.fn.executable "make" == 1,
      },
      -- "debugloop/telescope-undo.nvim"
      "nvim-telescope/telescope-symbols.nvim",
      "desdic/agrolens.nvim",
    },
    config = function()
      require("plugins.extras.telescope").setup()
    end
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash" },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        "Treesitter Search"
      },
      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc =
        "Toggle Flash Search"
      },
    },
  },
  {
    -- keymaps, commands, and autocommands
    "mrjones2014/legendary.nvim",
    priority = 10000,
    lazy = false,
    dependencies = {
      "kkharji/sqlite.lua",
      {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        config = function()
          require("dressing").setup()
        end
      }
    },
    config = function()
      require("plugins.extras.legendary").setup()
    end
  },
}
