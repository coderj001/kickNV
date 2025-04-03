local M = {}

function M.setup()
  local core = require("core")

  -- Get colorscheme from config with fallback
  local colorscheme = core.plugin_groups.ui.colorscheme
  local fallback_colorscheme = core.plugin_groups.ui.fallback_colorscheme
  local transparent = core.plugin_groups.ui.transparent_background

  -- Set up highlight groups for transparent background if enabled
  if transparent then
    M.setup_transparent_background()
  end

  -- Try to load the configured colorscheme
  local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
  if not status_ok then
    vim.notify("Colorscheme " .. colorscheme .. " not found, using " .. fallback_colorscheme,
      vim.log.levels.WARN)
    vim.cmd.colorscheme(fallback_colorscheme)
  end

  -- Apply any custom highlight overrides
  M.setup_highlight_overrides()
end

-- Function to set up transparent background
function M.setup_transparent_background()
  local transparent_groups = {
    "Normal", "NormalNC", "Comment", "Constant", "Special", "Identifier",
    "Statement", "PreProc", "Type", "Underlined", "Todo", "String", "Function",
    "Conditional", "Repeat", "Operator", "Structure", "LineNr", "NonText",
    "SignColumn", "CursorLineNr", "EndOfBuffer", "NormalFloat", "FloatBorder",
  }

  -- Create autocmd to set transparent background after colorscheme changes
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      for _, group in ipairs(transparent_groups) do
        vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
      end
    end,
  })
end

-- Function to set up custom highlight overrides
function M.setup_highlight_overrides()
  -- Apply specific colorscheme enhancements and fixes
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      -- General highlight enhancements
      vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })

      -- Telescope enhancements
      vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "Normal" })
      vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder" })

      -- Diagnostic enhancements
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#db4b4b", bg = "#332e3c" })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#e0af68", bg = "#393547" })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#0db9d7", bg = "#253652" })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#1abc9c", bg = "#2a3834" })

      -- Custom highlights for common plugins
      local colorscheme = vim.g.colors_name
      if colorscheme == "nightfox" or colorscheme == "tokyonight" then
        -- Add specific enhancements for these colorschemes
        vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#9d7cd8" })
        vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#ff9e64" })
        vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#3b4261" })
      end
    end,
  })
end

return M
