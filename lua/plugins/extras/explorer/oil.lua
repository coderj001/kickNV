return {
    "stevearc/oil.nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>n", mode = { "n" }, "<CMD>Oil<CR>",   desc = "Oil Explorer Current" },
      { "<leader>N", mode = { "n" }, "<CMD>Oil .<CR>", desc = "Oil Explorer Root" },
    },
    opts = {
      default_file_explorer = true,
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
      buf_options = {
        buflisted = false,
        bufhidden = "hide",
      },
    },
  }
