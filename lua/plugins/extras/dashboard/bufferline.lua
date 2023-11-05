return {
  {
    "akinsho/bufferline.nvim",
    version = "v3.*",
    opts = {
      options = {
        offsets = {
          {
            filetype = "NvimTree",
            text = " Explorer",
            highlight = "Directory",
            text_align = "left",
            padding = 1
          },
        },
        left_trunc_marker = "",
        right_trunc_marker = "",
        number_style = "",
        numbers = function(opts)
          return string.format("%s", opts.ordinal)
        end,
        separator_style = { "|", "|" },
        insert_at_end = false,
        insert_at_start = true,
        close_icon = "",
        modified_icon = "",
        icon_pinned = "車",
        semantic_letters = true,
        show_buffer_close_icons = false,
        show_tab_indicators = false,
        always_show_bufferline = true,
        max_name_length = 30,
        max_prefix_length = 15,
        tab_size = 20,
        sort_by = "extension",
        custom_filter = function(buf_number)
          local name = vim.fn.bufname(buf_number)
          if name ~= "" and not name:match("^term://") then
            return true
          end
        end,
        highlight = (require("config.defaults").config.colorscheme == "catppuccin") and
        require("catppuccin.groups.integrations.bufferline").get() or nil,
      },
    },
  },
}
