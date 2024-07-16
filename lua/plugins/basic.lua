return {
  "jiangmiao/auto-pairs",
  { "tpope/vim-surround", event = "BufEnter" },
  { "tpope/vim-repeat",   event = "BufEnter" },
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
    "echasnovski/mini.bufremove",
    event = "BufEnter",
    keys = {
      {
        "<leader>bd",
        function()
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>bD",
        function()
          require("mini.bufremove").delete(0, true)
        end,
        desc = "Delete Buffer (Force)",
      },
    },
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
}
