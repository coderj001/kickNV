return {
  {
    -- tmux nav for nvim
    "alexghergh/nvim-tmux-navigation",
    event = "VeryLazy",
    config = function()
      require "nvim-tmux-navigation".setup {
        disable_when_zoomed = true,
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
        }
      }
    end
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>n", mode = { "n" }, "<CMD>Oil<CR>",   desc = "Oil Explorer Current" },
      { "<leader>N", mode = { "n" }, "<CMD>Oil .<CR>", desc = "Oil Explorer Root" },
    },
    opts = {
      default_file_explorer = true,
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
    },
  },
  "jiangmiao/auto-pairs",
  { "tpope/vim-surround", event = "BufEnter" },
  { "tpope/vim-repeat",   event = "BufEnter" },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup {
        mapping = { "jk" },
      }
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
    event = "VeryLazy",
    config = function()
      local status, notify = pcall(require, "notify")
      if (not status) then return end
      notify.setup({
        stages = "fade_in_slide_out",
        render = "compact",
        timeout = 1500,
        fps = 20,
        max_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.75)
        end,
        background_colour = "#000000",
        minimum_width = 26,
        icons = {
          ERROR = "",
          WARN = "",
          INFO = "",
          DEBUG = "",
          TRACE = "✎",
        }
      })
      vim.notify = notify
    end,
    lazy = false
  },
  {
    "echasnovski/mini.bufremove",

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
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },
}
