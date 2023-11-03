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
      "nvim-telescope/telescope-live-grep-args.nvim",
      "nvim-telescope/telescope-symbols.nvim",
    },
    keys = {
      {
        "<leader>?",
        mode = { "n" },
        function() require("telescope.builtin").oldfiles() end,
        desc =
        "[?] Find recently opened files"
      },
      {
        "<leader>sf",
        mode = { "n" },
        function() require("telescope.builtin").find_files() end,
        desc = "[S]earch [F]iles",
      },
      {
        "<leader>sw",
        mode = { "n" },
        function() require("telescope.builtin").grep_string() end,
        desc = "[S]earch current  [W]ord",
      },
      {
        "<leader>sg",
        mode = { "n" },
        function() require("telescope.builtin").live_grep() end,
        desc = "[S]earch by [G]rep",
      },
      {
        "<leader>st",
        mode = { "n" },
        function() require("telescope.builtin").tags() end,
        desc = "[S]earch by [T]ags",
      },
      {
        "<leader>ss",
        mode = { "n" },
        function() require("telescope.builtin").symbols() end,
        desc = "[S]earch [S]ymbols",
      },
      {
        "<leader><leader>",
        mode = { "n" },
        function()
          require("telescope.builtin").buffers({
            ignore_current_buffer = true,
            sort_mru = true,
            sort_lastused = true
          })
        end,
        desc = "Switch Buffers",
      },
      {
        "<leader>sk",
        function()
          require("telescope-live-grep-args.shortcuts").grep_word_under_cursor({ postfix = false })
        end,
        desc = "Grep keyword under cursor (root dir)",
        mode = { "n" },
      },
      {
        "<leader>/",
        mode = { "n" },
        function() require("utils.telescope").current_buffer_fuzzy_find() end,
        desc = "[/] Fuzzily search in current buffer",
      },
      {
        "<leader>/",
        function()
          require("telescope-live-grep-args.shortcuts").grep_visual_selection({ postfix = false })
        end,
        desc = "Grep (root dir)",
        mode = { "v" },
      },
    },
    config = function()
      require("utils.telescope").setup()
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
}
