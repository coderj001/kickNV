if true then
  return {
    "ThePrimeagen/harpoon",
    config = function()
      require("harpoon").setup({
        global_settings = {
          save_on_toggle = false,
          save_on_change = true,
          enter_on_sendcmd = false,
          tmux_autoclose_windows = false,
          excluded_filetypes = { "harpoon" },
          mark_branch = true,
          tabline = false,
          tabline_prefix = "    ",
          tabline_suffix = "    "
        }
      })
      require("telescope").load_extension('harpoon')
    end,
    keys = {
      {
        "<leader>hx",
        mode = { "n" },
        function() require("harpoon.mark").add_file() end,
        desc = "[h]arpoon [x]mark",
      },
      {
        "<leader>hn",
        mode = { "n" },
        function() require("harpoon.ui").nav_next() end,
        desc = "[h]arpoon [n]ext",
      },
      {
        "<leader>hp",
        mode = { "n" },
        function() require("harpoon.ui").nav_prev() end,
        desc = "[h]arpoon [p]rev",
      },
      {
        "<leader>hm",
        mode = { "n" },
        ":Telescope harpoon marks<CR>",
        desc = "[h]arpoon [m]telescope",
      },
    }
  }
end
