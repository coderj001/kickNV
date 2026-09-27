return {
  {
    'aserowy/tmux.nvim',
    event = 'VeryLazy',
    config = function()
      return require('tmux').setup {
        resize = {
          enable_default_keybindings = true,
        },
      }
    end,
  },
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
      'TmuxNavigatorProcessList',
    },
    keys = {
      { '<c-h>',  '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>',  '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>',  '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>',  '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
  {
    'SavingFrame/pi-send.nvim',
    keys = {
      {
        '<leader>ap',
        function()
          require('pi_send').send { msg = '{position}' }
        end,
        mode = { 'n', 'x' },
        desc = 'Send position to pi',
      },
      {
        '<leader>as',
        function()
          require('pi_send').send { msg = '{selection}' }
        end,
        mode = 'x',
        desc = 'Send selection to pi',
      },
    },
  },
}
