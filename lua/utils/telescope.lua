local M = {}
local telescope = require("telescope")

function M.setup()
  telescope.setup {
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
      prompt_prefix = " ",
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
      results_title = false,
      prompt_title = false,
      preview_title = false,
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
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
      live_grep_args = {
        auto_quoting = false,
      },
    },
    pickers = {
      live_grep = {
        additional_args = function()
          return { "--hidden" }
        end,
      },
      buffers = {
        prompt_title = '✨ Search Buffers ✨',
        mappings = {
          i = {
            ["<c-d>"] = "delete_buffer",
          },
          n = {
            ['q'] = require('telescope.actions').close,
            ['x'] = require('telescope.actions').delete_buffer,
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
      }
    },
  }
  pcall(telescope.load_extension, 'fzf')
  -- pcall(telescope.load_extension, 'undo')
  pcall(telescope.load_extension, 'notify')
  pcall(telescope.load_extension, 'emoji')
  pcall(telescope.load_extension, 'luasnip')
  pcall(telescope.load_extension, 'harpoon')
end

function M.edit_neovim()
  require('telescope.builtin').git_files {
    shorten_path = true,
    cwd = "~/.config/nvim",
    prompt = "~ kickNV ~",
    height = 9,
    layout_strategy = 'horizontal',
    layout_options = {
      preview_width = 0.75
    }
  }
end

function M.current_buffer_fuzzy_find()
  require('telescope.builtin').current_buffer_fuzzy_find(
    require('telescope.themes').get_dropdown {
      winblend = 15,
      previewer = false,
      prompt_title = '✨ Search Current Buffers ✨',
    })
end

function M.treesitter()
  require('telescope.builtin').treesitter {
    require('telescope.themes').get_dropdown {
      winblend = 10,
      prompt_title = 'Treesitter Symbols'
    }
  }
end

-- Find files in your config directory
function M.find_neovim_config()
  require('telescope.builtin').find_files({
    prompt_title = "Neovim Config",
    cwd = vim.fn.stdpath("config"),
  })
end

-- Search string under cursor with Telescope
function M.grep_current_word()
  local word = vim.fn.expand("<cword>")
  require('telescope.builtin').grep_string({
    search = word,
    prompt_title = "Search for '" .. word .. "'",
  })
end

-- Find recent files sorted by frequency and recency
function M.frecency()
  require('telescope').extensions.frecency.frecency()
end

-- Global search with previews
function M.live_grep_open_files()
  require('telescope.builtin').live_grep({
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  })
end

return M
