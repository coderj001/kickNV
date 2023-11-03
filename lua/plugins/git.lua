return {
  {
    "lewis6991/gitsigns.nvim",
    event = {
      "CmdlineEnter",
      "InsertEnter",
      "CursorHold",
      "CursorMoved",
    },
    keys = {
      { "<leader>hs", function() require("gitsigns").hunk_stage() end, desc = "Git Hunk Stage", mode = { "n" } },
      { "<leader>hr", function() require("gitsigns").hunk_reset() end, desc = "Git Hunk Reset", mode = { "n" } },
      { '<leader>hs', function() require("gitsigns").stage_hunk { vim.fn.line("."), vim.fn.line("v") } end, desc = 'Stage Hunk (Visual)', mode = { 'v' } },
      { '<leader>hr', function() require("gitsigns").reset_hunk { vim.fn.line("."), vim.fn.line("v") } end, desc = 'Reset Hunk (Visual)', mode = { 'v' } },
      { '<leader>hs', function() require("gitsigns").stage_buffer() end, desc = 'Stage Buffer', mode = { 'n' } },
      { '<leader>hu', function() require("gitsigns").undo_stage_hunk() end, desc = 'Undo Stage Hunk', mode = { 'n' } },
      { '<leader>hr', function() require("gitsigns").reset_buffer() end, desc = 'Reset Buffer', mode = { 'n' } },
      { '<leader>hp', function() require("gitsigns").preview_hunk() end, desc = 'Preview Hunk', mode = { 'n' } },
      { '<leader>hb', function() require("gitsigns").blame_line() end, desc = 'Blame Line', mode = { 'n' } },
      { '<leader>tb', function() require("gitsigns").toggle_current_line_blame() end, desc = 'Toggle Current Line Blame', mode = { 'n' } },
      { '<leader>hd', function() require("gitsigns").diffthis() end, desc = 'Diff This', mode = { 'v', 'n' } },
      { '<leader>hd', function() require("gitsigns").diffthis("~") end, desc = 'Diff This (Visual)', mode = { 'n' } },
      { '<leader>td', function() require("gitsigns").toggle_deleted() end, desc = 'Toggle Deleted', mode = { 'n' } },
    },
    config = function()
      local status, gitsigns = pcall(require, 'gitsigns')
      if (not status) then return end

      gitsigns.setup {
        signs = {
          add = {
            text = "▎",
            hl = "GitSignsAdd",
            numhl = "GitSignsAddNr",
            linehl = "GitSignsAddLn",
          },
          delete = {
            text = "_",
            hl = "GitSignsDelete",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
          },
          change = {
            text = "▎",
            hl = "GitSignsChange",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
          },
          changedelete = {
            text = "▎",
            hl = "GitSignsDelete",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
          },
          topdelete = {
            text = '‾',
            hl = "GitSignsDelete",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
          },
        },
        numhl = false,
        linehl = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
          ignore_whitespace = false
        },
        current_line_blame_formatter_opts = { relative_time = true },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = "shadow",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1
        }
      }
    end
  },
  {
    "NeogitOrg/neogit",
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "sindrets/diffview.nvim",
        lazy = true,
        enabled = true,
        event = "BufRead",
      }
    },
    keys = {
      { "<leader>l", mode = { "n" }, "<CMD>Neogit<CR>",        desc = "NeoGit UI" },
      { "<leader>L", mode = { "n" }, "<CMD>Neogit commit<CR>", desc = "NeoGit UI Commmit" },
    },
    config = function()
      require('neogit').setup {
        kind = "vsplit",
        integrations = {
          telescope = true,
          diffview = true,
        }
      }
    end
  },
}
