---@diagnostic disable: different-requires
return {
  {
    "nvim-telescope/telescope.nvim",
    event = { "VimEnter" },
    cmd = "Telescope",
    version = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
        cond = vim.fn.executable "make" == 1,
      },
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    keys = {
      {
        "<leader>.",
        mode = { "n" },
        function() require("telescope.builtin").resume() end,
        desc =
        "[.] Resume"
      },
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
        desc = "[s]earch [n]eovim config"
      },
      {
        "<leader>sf",
        mode = { "n" },
        function() require("telescope.builtin").find_files() end,
        desc = "[s]earch [f]iles",
      },
      {
        "<leader>sw",
        mode = { "n" },
        function()
          require("utils.telescope").grep_current_word()
        end,
        desc = "[s]earch current [w]ord",
      },
      {
        "<leader>/",
        mode = { "n" },
        function()
          require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        desc = "[s]earch by [/]Grep",
      },
      {
        "<leader>sg",
        function()
          require("telescope-live-grep-args.shortcuts").grep_visual_selection({ postfix = false })
        end,
        desc = "[s]earch selected by [/]grep ",
        mode = { "v" },
      },
      {
        "<leader>st",
        mode = { "n" },
        function() require("telescope.builtin").tags() end,
        desc = "[s]earch by [t]ags",
      },
      {
        "<leader>sq",
        mode = { "n" },
        function() require("telescope.builtin").quickfix() end,
        desc = "[s]earch [q]uickfix",
      },
      {
        "<leader>sr",
        mode = { "n" },
        function() require("telescope.builtin").registers() end,
        desc = "[s]earch [r]egister",
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
        "<leader>sg",
        function() require("utils.telescope").live_grep_open_files() end,
        desc = "[s]earch in [g]open files"
      },
      {
        "<leader>sgc",
        ":Telescope git_commits<cr>",
        desc = "[s]earch [g]it [c]ommits"
      },
      {
        "<leader>sgb",
        ":Telescope git_branches<cr>",
        desc = "[s]earch [g]it [b]ranches"
      },
      {
        "<leader>sgs",
        ":Telescope git_status<cr>",
        desc = "[s]earch [g]it [s]atus"
      },
      {
        "<leader>fx",
        ":Telescope lsp_references<cr>",
        desc = "[f]ind [x]references"
      },
      {
        "<leader>fs",
        ":Telescope lsp_document_symbols<cr>",
        desc = "[f]ind [s]ymbols"
      },
    },
    config = function()
      require("utils.telescope").setup()
    end
  }
}
