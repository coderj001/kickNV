local M = {}
local servers = {
  clangd = {},
  gopls = {},
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "off",
        },
      },
    },
  },
  rust_analyzer = {},
  jsonls = {
    settings = {
      json = {
        schemas = {},
      },
    },
  },
  tsserver = {
    filetypes = {
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "javascript",
      "javascriptreact",
    }
  },
  lua_ls = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      library = {
        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        [vim.fn.stdpath("config") .. "/lua"] = true,
      },
    },
  },
}

local on_attach = function(_, bufnr)
  vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError", numhl = "" })
  vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn", numhl = "" })
  vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo", numhl = "" })

  if vim.lsp.setup then
    vim.lsp.setup {
      floating_preview = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } },
      diagnostics = {
        signs = { error = " ", warning = " ", hint = " ", information = " " },
        display = {
          underline = true,
          update_in_insert = false,
          -- virtual_text = { spacing = 4, prefix = "●" },
          virtual_text = false,
          severity_sort = true,
        },
      },
      completion = {
        kind = {
          Class = " ",
          Color = " ",
          Constant = " ",
          Constructor = " ",
          Enum = "了 ",
          EnumMember = " ",
          Field = " ",
          File = " ",
          Folder = " ",
          Function = " ",
          Interface = "ﰮ ",
          Keyword = " ",
          Method = "ƒ ",
          Module = " ",
          Property = " ",
          Snippet = "﬌ ",
          Struct = " ",
          Text = " ",
          Unit = " ",
          Value = " ",
          Variable = " ",
        },
      },
    }
  else
  end

  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  -- nmap('<leader>D', vim.lsp.buf.type_definition, '[T]ype [D]efinition')
  -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  -- nmap('<leader>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, '[W]orkspace [L]ist Folders')
end

function M.setup()
  -- Setup neovim lua configuration
  require('neodev').setup {
    library = {
      enabled = true,
      runtime = true,
      types = true,
      plugins = true,
    },
  }


  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  capabilities.textDocument.completion.completionItem.preselectSupport = true
  capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
  capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
  capabilities.textDocument.completion.completionItem.deprecatedSupport = true
  capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
  capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  }

  -- Setup mason so it can manage external tooling
  require('mason').setup()

  -- Ensure the servers above are installed
  local mason_lspconfig = require 'mason-lspconfig'

  mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
  }

  mason_lspconfig.setup_handlers {
    function(server_name)
      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
      }
    end,
  }

  -- Turn on lsp status information
  require('fidget').setup()
end

return M
