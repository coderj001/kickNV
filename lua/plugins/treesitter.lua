return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "VeryLazy", "BufReadPost", "BufNewFile" },
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    cmd = {
      "TSUpdateSync",
      "TSUpdate",
      "TSInstall",
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "p00f/nvim-ts-rainbow",
      "HiPhish/nvim-ts-rainbow2",
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
      {
        "mizlan/iswap.nvim",
        event = "BufWinEnter",
        cmd = {
          'ISwap',
          'ISwapWith',
          'ISwapNode',
          'ISwapNodeWith',
        },
        keys = {
          {
            "<leader>k",
            mode = { "n" },
            ":ISwap<CR>",
            desc = "Swap variables",
          },
        },
      },
      {
        "Wansmer/treesj",
        event = "BufWinEnter",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        keys = {
          {
            "<leader>j",
            mode = { "n" },
            function() require("treesj").toggle() end,
            desc = "Toggle Split or Join",
          },
        },
        config = function()
          require('treesj').setup({
            notify = true,
            dot_repeat = false,
            max_join_length = 500,
            use_default_keymaps = false,
          })
        end,
      },
      {
        "m-demare/hlargs.nvim",
        config = function()
          require("hlargs").setup()
        end
      },
      {
        "ZhiyuanLck/smart-pairs",
        event = "InsertEnter",
        config = function()
          require("pairs"):setup()
        end
      },
    },
    build = function()
      pcall(require("nvim-treesitter.install").update { with_sync = false })
    end,
    config = function()
      local status, treesitter = pcall(require, "nvim-treesitter.configs")
      if (not status) then return end
      treesitter.setup {
        ensure_installed = {
          "cpp",
          "python",
          "html",
          "javascript",
          "typescript",
          "json",
          "json5",
          "jsonc",
          "go",
          "gomod",
          "gosum",
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
          "http",
          "dockerfile",
          "requirements",
          "make",
          "csv",
          "tsv",
          "ssh_config",
          "git_config",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore",
        },
        sync_install = false,
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
          query = 'rainbow-parens',
          strategy = require('ts-rainbow').strategy.global,
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
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufWinEnter",

    main = "ibl",
    config = function()
      require("utils.indent_blankline").setup()
    end
  },
  {
    "numToStr/Comment.nvim",
    event = { "ModeChanged" },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      })
    end,
    dependencies = {
      "nvim-ts-context-commentstring",
      "JoosepAlviste/nvim-ts-context-commentstring"
    }
  },
  {
    "yaocccc/nvim-hlchunk"
  }
}
