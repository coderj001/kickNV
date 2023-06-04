local M = {}
local bufferline = require "bufferline"
local opts = require("core.default_config").opts
local keymap = require("core.default_config").keymap

function M.setup()
  bufferline.setup {
    options = {
      number_style = "",
      diagnostics = "nvim_lsp",
      offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "left" } },
      show_close_icon = false,
      separator_style = "any",
      insert_at_end = false,
      insert_at_start = true,
      icon_separator_active = "▎",
      icon_separator_inactive = "▎",
      icon_close_tab = "",
      icon_close_tab_modified = "",
      icon_pinned = "車",
      semantic_letters = true,
      hover = {
        enabled = true,
        delay = 100,
        reveal = { "close" }
      },
      indicator = { style = "none" },
      show_buffer_close_icons = false,
      show_tab_indicators = false,
      always_show_bufferline = true,
    }
  }

  keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
  keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)
end

return M
