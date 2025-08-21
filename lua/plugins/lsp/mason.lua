return {
  "williamboman/mason.nvim",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_tool_installer = require("mason-tool-installer")

    -- Enhanced Mason setup
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
        border = "rounded", -- Add rounded borders for better UI
        width = 0.8,
        height = 0.9,
      },
      -- Improve installation performance
      max_concurrent_installers = 4,
    })

    -- Additional tools (formatters, linters, debuggers)
    mason_tool_installer.setup({
      ensure_installed = {
        -- Formatters
        "prettier",     -- js, ts, html, css, json, yaml
        "stylua",       -- lua formatter
        "black",        -- python formatter
        "isort",        -- python import sorter
        "clang-format", -- c/cpp formatter

        -- Linters
        "eslint_d",     -- js/ts linter
        "pylint",       -- python linter
        "cpplint",      -- c++ linter
        "yamllint",     -- yaml linter
        "jsonlint",     -- json linter
        "markdownlint", -- markdown linter

        -- Debuggers
        "debugpy",          -- python debugger
        "js-debug-adapter", -- js/ts debugger

        -- Additional tools
        "dockerfile-language-server",
        "taplo", -- toml language server
      },
      -- Auto-update tools
      auto_update = false,
      -- Run on start to ensure tools are installed
      run_on_start = true,
    })

    -- Event handlers for better integration
    vim.api.nvim_create_autocmd("User", {
      pattern = "MasonToolsStartingInstall",
      callback = function()
        vim.schedule(function()
          print("Mason is installing tools...")
        end)
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "MasonToolsUpdateCompleted",
      callback = function(e)
        vim.schedule(function()
          print(string.format("Mason tools update completed. Updated: %s", table.concat(e.data, ", ")))
        end)
      end,
    })
  end,
}
