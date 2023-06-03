local M = {}
local bufferline = require "bufferline"

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
end

vim.api.nvim_set_keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
return M
