local M = {}
local keymap = require("core.default_config").keymap
local opts = require("core.default_config").opts


function M.setup()
  require('telescope').setup {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
        "--glob=!node_modules/",
        "--glob=!.venv/",
      },
      prompt_prefix = "🔍 ",
      selection_caret = " ",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          preview_width = 0.55,
          results_width = 0.8,
        },
        height = 0.9,
        width = 0.87,
        preview_cutoff = 120,
      },
      entry_prefix = "  ",
      initial_mode = "insert",
      path_display = { "truncate" },
      winblend = 20,
      -- borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      borderchars = { '━', '┃', '━', '┃', '┏', '┓', '┛', '┗' },
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
          ["<C-n>"] = require('telescope.actions').cycle_history_next,
          ["<C-p>"] = require('telescope.actions').cycle_history_prev,
          ["<C-j>"] = require('telescope.actions').move_selection_next,
          ["<C-k>"] = require('telescope.actions').move_selection_previous,
        },
      },
    },
    extension = {
      undo = {
        side_by_side = true,
        layout_strategy = "vertical",
        layout_config = {
          preview_height = 0.8,
        },
      },
      fzf = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = 'smart_case',       -- or "ignore_case" or "respect_case"
      },
    },
    pickers = {
      buffers = {
        prompt_title = '✨ Search Buffers ✨',
        mappings = {
          n = {
            ['d'] = require('telescope.actions').delete_buffer,
            ['<tab>'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_next,
            ['<s-tab>'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_previous,
            ['v'] = require('telescope.actions').file_vsplit,
            ['s'] = require('telescope.actions').file_split,
            ['<cr>'] = require('telescope.actions').file_edit,
          },
        },
        sort_mru = true,
        preview_title = false,
        initial_mode = "normal"
      },
    }
  }
  -- Enable telescope fzf native, if installed
  pcall(require('telescope').load_extension, 'fzf')
  pcall(require('telescope').load_extension, 'undo')
end

function M.edit_neovim()
  require('telescope.builtin').git_files {
    shorten_path = true,
    cwd = "~/.config/nvim",
    prompt = "~ dotfiles ~",
    height = 13,
    layout_strategy = 'horizontal',
    layout_options = {
      preview_width = 0.75
    }
  }
end

function M.search_current_buffer()
  require('telescope.builtin').current_buffer_fuzzy_find {
    require('telescope.themes').get_dropdown {
      winblend = 15,
      previewer = false,
      prompt_title = '✨ Search Current Buffers ✨',
    }
  }
end

return M
