return {
  "stevearc/oil.nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>e", mode = { "n" }, "<CMD>Oil<CR>",   desc = "Oil Explorer Current" },
    { "<leader>E", mode = { "n" }, "<CMD>Oil .<CR>", desc = "Oil Explorer Root" },
  },
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
      natural_order = true,
      is_always_hidden = function(name, _)
        return  name == ".." or name == ".git" or name == ".DS_Store" or name:match("^%.")
      end
    },
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
