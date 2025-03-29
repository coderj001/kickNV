return {
  { "tpope/vim-repeat", event = "BufEnter" },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup {}
    end
  },
  {
    -- Lastplace
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      local status, lastplace = pcall(require, "nvim-lastplace")
      if (not status) then return end
      lastplace.setup({
        lastplace_ignore_buftype = {
          "quickfix",
          "nofile",
          "help",
        },
        lastplace_ignore_filetype = {
          "gitcommit",
          "gitrebase",
          "svn",
          "hgcommit",
        },
        lastplace_open_folds = true,
      })
    end
  },
  {
    "cpea2506/relative-toggle.nvim",
    config = function()
      local status, relativetoggle = pcall(require, "relative-toggle")
      if (not status) then return end
      relativetoggle.setup({
        pattern = "*",
        events = {
          on = {
            "BufEnter",
            "FocusGained",
            "InsertLeave",
            "WinEnter",
            "CmdlineLeave",
          },
          off = {
            "BufLeave",
            "FocusLost",
            "InsertEnter",
            "WinLeave",
            "CmdlineEnter",
          },
        },
      })
    end
  },
  {
    "rcarriga/nvim-notify",
    priority = 1000,
    event = {
      "CursorMoved",
      "CursorHold",
      "InsertEnter",
      "CmdlineEnter",
    },
    config = function()
      local status, notify = pcall(require, "notify")
      if (not status) then return end
      notify.setup({
        background_colour = "#000000",
        top_down = false,
      })
      vim.notify = notify
    end,
    lazy = false
  },
  {
    'echasnovski/mini.nvim',
    version = false,
    event = 'VeryLazy',
    config = function()
      -- Setup mini.pairs (auto brackets)
      require('mini.pairs').setup()

      -- Setup mini.surround (for surrounding text)
      require('mini.surround').setup()

      -- Setup mini.ai with enhanced text objects
      require('mini.ai').setup({
        n_lines = 500,
        custom_textobjects = {
          o = require('mini.ai').gen_spec.treesitter({
            a = {
              "@block.outer",
              "@conditional.outer",
              "@loop.outer",
            },
            i = {
              "@block.inner",
              "@conditional.inner",
              "@loop.inner",
            },
          }, {}),
          f = require('mini.ai').gen_spec.treesitter(
            {
              a = "@function.outer",
              i = "@function.inner",
            },
            {}
          ),
          c = require('mini.ai').gen_spec.treesitter(
            {
              a = "@class.outer",
              i = "@class.inner",
            },
            {}
          ),
        },
      })

      -- Setup mini.indentscope (shows indent scope)
      require('mini.indentscope').setup({
        symbol = '│',
        options = { try_as_border = true },
      })

      -- Setup mini.clue for keybinding hints
      require('mini.clue').setup({
        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- Common key triggers
          { mode = 'n', keys = 'g' },
          { mode = 'n', keys = 'z' },
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'n', keys = '"' },
        },
        window = {
          delay = 300,
          config = { border = 'rounded' },
        },
      })
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
    ft = {
      'lua',
      'css',
      'html',
      'sass',
      'less',
      'typescriptreact',
      'conf',
      'vim',
    },
    config = function()
      require('colorizer').setup()
    end,
  },
  {
    'mattn/emmet-vim',
    keys = {
      { '<leader>y', ':Emmet ', desc = 'Emmet' },
    },
    cmd = 'Emmet',
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
      })
    end
  }
}
