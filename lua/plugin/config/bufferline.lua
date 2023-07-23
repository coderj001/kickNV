---@diagnostic disable: missing-fields
local M = {}
local bufferline = require "bufferline"
local opts = require("core.default_config").opts
local keymap = require("core.default_config").keymap

function M.setup()
  bufferline.setup {
    options = {
      number_style = "",
      separator_style = "any",
      insert_at_end = false,
      insert_at_start = true,
      close_icon = "",
      modified_icon = "",
      icon_pinned = "車",
      semantic_letters = true,
      show_buffer_close_icons = false,
      show_tab_indicators = false,
      always_show_bufferline = true,
      highlight = require("catppuccin.groups.integrations.bufferline").get()
    }
  }

  keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
  keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)
end

return M
