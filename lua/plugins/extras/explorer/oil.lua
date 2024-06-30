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
        return name == ".." or name == ".git" or name == ".DS_Store" or name:match("^%.")
      end
    },
    keymaps = {
      ["<C-c>"] = false,
      ["q"] = "actions.close",
      [">"] = "actions.toggle_hidden",
      ["<C-y>"] = "actions.copy_entry_path",
      ["gd"] = {
        desc = "Toggle detail view",
        callback = function()
          local oil = require("oil")
          local config = require("oil.config")
          if #config.columns == 1 then
            oil.set_columns({ "icon", "permissions", "size", "mtime" })
          else
            oil.set_columns({ "icon" })
          end
        end,
      },
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
