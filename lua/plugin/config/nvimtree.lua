local M = {}
local opts = require("core.default_config").opts
local keymap = require("core.default_config").keymap

function M.setup()
  -- Load nvim-tree plugin
  require('nvim-tree').setup {
    -- Set options for nvim-tree
    disable_netrw       = false, -- Disable netrw
    hijack_netrw        = false, -- Hijack netrw window on startup
    update_focused_file = {
      enable     = true,         -- Update the focused file in the tree when you change files
      update_cwd = true,         -- Update the current working directory of the tree
    },
    view                = {
      cursorline = true,
      width = 30,     -- Set the width of the tree view
      side = 'right', -- Put the tree view on the left side of the editor
      mappings = {
        custom_only = false,
        list = {
          { key = { "<CR>", "o", "<2-LeftMouse>" }, cb = require 'nvim-tree.config'.nvim_tree_callback("edit") },
          { key = { "<2-RightMouse>", "<C-]>" },    cb = require 'nvim-tree.config'.nvim_tree_callback("cd") },
          { key = "<C-v>",                          cb = require 'nvim-tree.config'.nvim_tree_callback("vsplit") },
          { key = "<C-x>",                          cb = require 'nvim-tree.config'.nvim_tree_callback("split") },
          { key = "<C-t>",                          cb = require 'nvim-tree.config'.nvim_tree_callback("tabnew") },
          { key = "<",                              cb = require 'nvim-tree.config'.nvim_tree_callback("prev_sibling") },
          { key = ">",                              cb = require 'nvim-tree.config'.nvim_tree_callback("next_sibling") },
          { key = "P",                              cb = require 'nvim-tree.config'.nvim_tree_callback("parent_node") },
          { key = "<BS>",                           cb = require 'nvim-tree.config'.nvim_tree_callback("close_node") },
          { key = "<S-CR>",                         cb = require 'nvim-tree.config'.nvim_tree_callback("close_node") },
          { key = "<Tab>",                          cb = require 'nvim-tree.config'.nvim_tree_callback("preview") },
          { key = "K",                              cb = require 'nvim-tree.config'.nvim_tree_callback("first_sibling") },
          { key = "J",                              cb = require 'nvim-tree.config'.nvim_tree_callback("last_sibling") },
          { key = "I",                              cb = require 'nvim-tree.config'.nvim_tree_callback("toggle_ignored") },
          { key = "H",                              cb = require 'nvim-tree.config'.nvim_tree_callback("toggle_dotfiles") },
          { key = "R",                              cb = require 'nvim-tree.config'.nvim_tree_callback("refresh") },
          { key = "a",                              cb = require 'nvim-tree.config'.nvim_tree_callback("create") },
          { key = "d",                              cb = require 'nvim-tree.config'.nvim_tree_callback("remove") },
          { key = "r",                              cb = require 'nvim-tree.config'.nvim_tree_callback("rename") },
          { key = "<C-r>",                          cb = require 'nvim-tree.config'.nvim_tree_callback("full_rename") },
          { key = "x",                              cb = require 'nvim-tree.config'.nvim_tree_callback("cut") },
          { key = "c",                              cb = require 'nvim-tree.config'.nvim_tree_callback("copy") },
          { key = "p",                              cb = require 'nvim-tree.config'.nvim_tree_callback("paste") },
        },
      },
    },
    actions             = {
      open_file = {
        resize_window = true,
      }
    },
    filters             = {
      dotfiles = true,
      exclude = { 'node_modules', '.venv', 'env', '.env' },
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
        glyphs = { default = " ", },
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

  -- Keybindings for nvim-tree
  keymap('n', '<leader>n', ':NvimTreeToggle<CR>', opts)
end

return M
