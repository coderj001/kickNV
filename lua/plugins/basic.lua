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
    config = function()
      require('mini.pairs').setup()
      require('mini.surround').setup()
      require('mini.comment').setup()
      require('mini.indentscope').setup({
        symbol = '│',
        options = { try_as_border = true },
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
