-- Add to lua/plugins/lsp/lspconfig.lua or as a new plugin file
return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'L3MON4D3/LuaSnip'},
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings to learn the available actions
        lsp_zero.default_keymaps({buffer = bufnr})
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
