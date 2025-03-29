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
      -- "nvim-telescope/telescope-symbols.nvim",
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
        "<leader>sn",
        function() require("utils.telescope").find_neovim_config() end,
        desc = "[S]earch [N]eovim config"
      },
      -- {
      --   "<leader>sd",
      --   mode = { "n" },
      --   function() require("telescope.builtin").lsp_document_symbols() end,
      --   desc = "[S]earch LSP [D]fination",
      -- },
      {
        "<leader>sf",
        mode = { "n" },
        function() require("telescope.builtin").find_files() end,
        desc = "[S]earch [F]iles",
      },
      {
        "<leader>sw",
        mode = { "n" },
        function()
          require("utils.telescope").grep_current_word()
        end,
        desc = "[S]earch current  [W]ord",
      },
      {
        "<leader>sg",
        mode = { "n" },
        function()
          require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        desc = "[S]earch by [G]rep",
      },
      {
        "<leader>sg",
        function()
          require("telescope-live-grep-args.shortcuts").grep_visual_selection({ postfix = false })
        end,
        desc = "[S]earch selected by [G]rep ",
        mode = { "v" },
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
        "<leader>sq",
        mode = { "n" },
        function() require("telescope.builtin").quickfix() end,
        desc = "[S]earch [Q]uickfix",
      },
      {
        "<leader>sr",
        mode = { "n" },
        function() require("telescope.builtin").registers() end,
        desc = "[S]earch [R]egister",
      },
      {
        "<leader><Space>",
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
        "<leader>/",
        mode = { "n" },
        function() require("utils.telescope").current_buffer_fuzzy_find() end,
        desc = "[/] Fuzzily search in current buffer",
      },
      {
        "<leader>so",
        function() require("utils.telescope").live_grep_open_files() end,
        desc = "[S]earch in [O]pen files"
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
      {
        "s",
        mode = { "n", "x", "o" },
        function() require("flash").jump() end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function() require("flash").treesitter() end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function() require("flash").remote() end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc = "Toggle Flash Search",
      },
    },
  },
}
