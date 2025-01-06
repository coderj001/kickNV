local M = {}
local status, nvimtree = pcall(require, 'nvim-tree')

function M.setup()
  -- Load nvim-tree plugin
  if (not status) then return end
  nvimtree.setup {
    -- Set options for nvim-tree
    disable_netrw       = false, -- Disable netrw
    hijack_netrw        = false, -- Hijack netrw window on startup
    update_focused_file = {
      enable     = true,         -- Update the focused file in the tree when you change files
      update_cwd = true,         -- Update the current working directory of the tree
    },
    view                = {
      cursorline = true,
      width = 24,     -- Set the width of the tree view
      side = 'right', -- Put the tree view on the left side of the editor
    },
    actions             = {
      open_file = {
        resize_window = true,
      }
    },
    filters             = {
      dotfiles = true,
      exclude = {
        'node_modules',
        '.venv',
        'env',
        '.env',
      },
    },
    renderer            = {
      add_trailing   = true,
      group_empty    = true,
      highlight_git  = true,
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
    log                 = {
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
