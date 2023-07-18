local M = {}
local telescope_builtin = require('telescope.builtin')

function M.setup()
  require('legendary').setup({
    keymaps = {
      -- Telescope
      {
        '<leader>?',
        telescope_builtin.oldfiles,
        description =
        '[?] Find recently opened files'
      },
      { '<leader>sf', telescope_builtin.find_files,  description = '[S]earch [F]iles' },
      { '<leader>sw', telescope_builtin.grep_string, description = '[S]earch current  [W]ord' },
      { '<leader>sg', telescope_builtin.live_grep,   description = '[S]earch by [G]rep' },
      { '<leader>sb', telescope_builtin.buffers,     description = '[S]earch [B]uffers' },
      { '<leader>sc', telescope_builtin.colorscheme, description = '[S]earch [C]olorscheme' },
      {
        '<leader>/',
        require('plugin.config.telescope').search_current_buffer,
        description =
        '[/] Fuzzily search in current buffer'
      },
      { '<leader>en', require('plugin.config.telescope').edit_neovim, description = '[E]dit [N]eovim' },
      { '<leader>cp', require('legendary').find, description = '[C]ommand [P]allet' },
      -- LSP
      { 'K',          vim.lsp.buf.hover,                              description = 'Hover Documentation',  mode = { 'n' } },
      { 'gD',         vim.lsp.buf.declaration,                        description = '[G]oto [D]eclaration', mode = { 'n' } },
      { 'gI',         vim.lsp.buf.implementation,                        description = '[G]oto [I]mplementation', mode = { 'n' } },
      { 'gd',         vim.lsp.buf.definition,                        description = '[G]oto [D]efinition', mode = { 'n' } },
      { 'gr',         telescope_builtin.lsp_references,                        description = '[G]oto [R]eferences', mode = { 'n' } },
      { '<leader>rn',  vim.lsp.buf.rename,                        description = '[R]e[n]ame', mode = { 'n' } },
      { '<leader>ca',  vim.lsp.buf.code_action,                        description = '[C]ode [A]ction', mode = { 'n' } },
    },
    commands = {
      {
        ':Format',
        function()
          vim.lsp.buf.format()
        end
        ,
        description = 'Format current buffer with LSP',
        mode = {'n'}
      },
      {
        ':ToggleLspLine',
        function ()
          require('lsp_lines').toggle()
        end,
        description = 'Toggle lsp_lines',
        mode = {'n'}
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
