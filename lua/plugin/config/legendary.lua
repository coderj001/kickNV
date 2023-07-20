local M = {}
local telescope_builtin = require('telescope.builtin')
local gs = require('gitsigns')

function M.setup()
  require('legendary').setup({
    keymaps = {
      -- Telescope
      { '<leader>n', ':NvimTreeToggle<CR>', description = '[N]vimTree Toggle' },
      { '<leader>?', telescope_builtin.oldfiles, description = '[?] Find recently opened files' },
      { '<leader>sf', telescope_builtin.find_files, description = '[S]earch [F]iles' },
      { '<leader>sw', telescope_builtin.grep_string, description = '[S]earch current  [W]ord' },
      { '<leader>sg', telescope_builtin.live_grep,   description = '[S]earch by [G]rep' },
      { '<leader><leader>', telescope_builtin.buffers,     description = '[S]earch [B]uffers' },
      { '<leader>sc', telescope_builtin.colorscheme, description = '[S]earch [C]olorscheme' },
      { '<leader>/', require('plugin.config.telescope').current_buffer_fuzzy_find, description = '[/] Fuzzily search in current buffer' },
      { '<leader>en', require('plugin.config.telescope').edit_neovim, description = '[E]dit [N]eovim' },
      { '<leader>gb', telescope_builtin.git_branches, description = '[G]it [B]ranches' },
      { '<leader>gc', telescope_builtin.git_commits, description = '[G]it [B]ranches' },
      { '<leader>cp', require('legendary').find, description = '[C]ommand [P]allet', mode = {'n', 'v'} },
      -- LSP
      { 'K', vim.lsp.buf.hover, description = 'Hover Documentation', mode = { 'n' } },
      { 'gD', vim.lsp.buf.declaration, description = '[G]oto [D]eclaration', mode = { 'n' } },
      { 'gI', vim.lsp.buf.implementation, description = '[G]oto [I]mplementation', mode = { 'n' } },
      { 'gd', vim.lsp.buf.definition, description = '[G]oto [D]efinition', mode = { 'n' } },
      { 'gr', telescope_builtin.lsp_references, description = '[G]oto [R]eferences', mode = { 'n' } },
      { 'gs', vim.lsp.buf.signature_help, description = '[G]oto [S]ignature', mode = { 'n' } },
      { '<leader>rn', vim.lsp.buf.rename, description = '[R]e[n]ame', mode = { 'n' } },
      { '<leader>ca', vim.lsp.buf.code_action, description = '[C]ode [A]ction', mode = { 'n' } },

      { '<leader>l',        ':Neogit<cr>',                                                description = 'NeoGit', mode = { 'n' } },

      -- Split
      { '<leader>j',  require('treesj.').toggle,                        description = 'Toggle Split or Join', mode = { 'n' } },
      { '<leader>k',  ':ISwap<CR>',                        description = 'Swap', mode = { 'n', 'v' } },
    },
    commands = {
      { ':Format', function() vim.lsp.buf.format({async = true}) end, description = 'Format current buffer with LSP', mode = { 'n' } },
      { ':ToggleLspLine', function() require('lsp_lines').toggle() end, description = 'Toggle lsp_lines', mode = { 'n' } },
      {
        ':ToggleBlameLine',
        function()
          gs.toggle_current_line_blame()
        end,
        description = 'Toggle Current Line Blame',
        mode = { 'n' }
      },
      { ':DiffThis', function() gs.diffthis() end,             description = 'Diff this',   mode = { 'n' } },
      { ':DiffView', function() gs.diffthis('~') end,          description = 'Diff View',   mode = { 'n' } },
      { ':TSJSplit', function() require('treesj').split() end, description = 'Split Lines', mode = { 'n' } },
      { ':TSJJoin',  function() require('treesj').join() end,  description = 'Join Lines',  mode = { 'n' } },
      {
        ':LuaSnipEdit',
        function()
          require('luasnip.loaders.from_lua').edit_snippet_files()
        end,
        description = 'Edit Snippets Files',
        mode = { 'n' },
      },
      {
        ':Notifi',
        ':Telescope notify<cr>',
        description = 'Notify',
        mode = { 'n' }
      },
      {
        ':Colorscheme',
        ':Telescope colorscheme<CR>'
        ,
        description = '[S]earch [C]olorscheme',
        mode = { 'n' }
      }
    },
    lazy_nvim = {
      auto_register = true
    },
    extensions = {
      nvim_tree = false,
      smart_splits = {
        directions = { 'h', 'j', 'k', 'l' },
        mods = {
          move = '<C>',
          resize = '<A>',
          swap = {
            mod = '<leader>',
            prefix = '<leader>',
          },
        },
      },
    },
  })
end

return M
