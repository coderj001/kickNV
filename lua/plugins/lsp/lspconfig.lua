return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      if require('core').plugin_groups.blink then
        local capabilities = require('blink.cmp').get_lsp_capabilities(
          {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true
              }
            }
          }
        )
        require("lspconfig").lua_ls.setup { capabilities = capabilities }
      end

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings to learn the available actions
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      require('mason').setup({})
      require('mason-lspconfig').setup({
        handlers = {
          lsp_zero.default_setup,
        }
      })
    end
  }
}
