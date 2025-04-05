local M = {}
local status, nvimtree = pcall(require, 'nvim-tree')

function M.setup()
  -- Load nvim-tree plugin
  if (not status) then return end
  nvimtree.setup {
    view     = {
      cursorline = true,
      width = 24,
      side = 'right',
    },
    actions  = {
      open_file = {
        resize_window = true,
      }
    },
    filters  = {
      dotfiles = true,
      exclude = {
        'node_modules',
        '.venv',
        'env',
        '.env',
      },
    },
    renderer = {
      add_trailing   = true,
      group_empty    = true,
      indent_width   = 1,
      indent_markers = {
        enable = true,
      },
      icons          = {
        git_placement = "after",
        show = {
          file = true,
        },
        glyphs = {
          default = " ",
        },
      },
    },
    log      = {
      enable = true,
      truncate = true,
      types = {
        all = true,
        config = true,
        copy_paste = true,
        dev = true,
        diagnostics = true,
        git = true,
        profile = true,
        watcher = true,
      },
    },
  }
end

return M
