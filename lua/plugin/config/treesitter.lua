local M = {}
local status, ts = pcall(require, "nvim-treesitter.configs")
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

function M.setup()
  if (not status) then return end
  ts.setup {
    ensure_installed = {
      "cpp",
      "python",
      "html",
      "javascript",
      "typescript",
      "json",
      "json5",
      "go",
      "gomod",
      "bash",
      "lua",
      "luadoc",
      "luap",
      "comment",
      "markdown",
      "markdown_inline",
      "glimmer",
      "regex",
      "vim",
      "vimdoc",
      "yaml",
      "toml",
      "tsx",
      "css",
      "scss",
      "dockerfile",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      disable = { "cpp", "latex" },
    },
    indent = {
      enable = { "javascriptreact" },
      disable = { 'python' },
    },
    autotag = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<c-backspace>',
      },
    },
    rainbow = {
      enable = true,
      extendend_mode = true,
      max_file_lines = 1000,
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
  parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
end

return M
