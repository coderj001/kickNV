---@mod lspconfig LSP Configuration
---@brief [[
--- Configures Language Server Protocol (LSP) integration using lsp-zero.
--- Sets up Mason for LSP server management and configures keymaps.
---@brief ]]

---@class KeymapOptions
---@field buffer number Buffer number

---Setup LSP keymaps for the current buffer
---@param event table Event data containing buffer number
local function setup_keymaps(event)
  local opts = { buffer = event.buf }
  local keymap = {
    ['K'] = vim.lsp.buf.hover,
    ['gd'] = vim.lsp.buf.definition,
    ['gD'] = vim.lsp.buf.declaration,
    ['<leader>gi'] = vim.lsp.buf.implementation,
    ['<leader>go'] = vim.lsp.buf.type_definition,
    ['<leader>gr'] = vim.lsp.buf.references,
    ['<leader>gg'] = vim.lsp.buf.rename,
    ['<leader>ca'] = vim.lsp.buf.code_action,
    -- Workspace management
    ['<leader>wa'] = vim.lsp.buf.add_workspace_folder,
    ['<leader>wr'] = vim.lsp.buf.remove_workspace_folder,
    ['<leader>wl'] = function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end,
  }

  for key, func in pairs(keymap) do
    vim.keymap.set('n', key, func, opts)
  end
end

---Get LSP capabilities
---@return table capabilities LSP capabilities
local function get_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  if require('core').plugin_groups.blink then
    capabilities = vim.tbl_deep_extend('force', capabilities,
      require('blink.cmp').get_lsp_capabilities({
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
          }
        }
      })
    )
  end

  return capabilities
end

return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      local lsp_zero = require('lsp-zero')

      -- Setup LSP keymaps
      lsp_zero.on_attach(function(client, bufnr)
        setup_keymaps({ buf = bufnr })
      end)

      -- Initialize Mason and LSP servers
      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = {
          "clangd",
          "cssls",
          "docker_compose_language_service",
          "dockerls",
          "html",
          "jsonls",
          "lua_ls",
          "pyright",
          "ts_ls",
          "yamlls",
        },
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            require("lspconfig").lua_ls.setup({
              capabilities = get_capabilities(),
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                  workspace = {
                    checkThirdParty = false,
                  },
                  telemetry = {
                    enable = false,
                  },
                },
              },
            })
          end,
        },
      })
    end,
  },
}
