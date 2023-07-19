local M = {}

function M.setup()
  local alpha                   = require('alpha')
  local dashboard               = require('alpha.themes.dashboard')

  dashboard.section.header.val  = require('core.default_config').options.figlet_name
  dashboard.section.header.opts = {
    position = "center",
    hl = "Type",
    wrap = "overflow"
  }
  dashboard.section.buttons.val = {
    dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
    dashboard.button("LDR  ?", "  Recently Opened Files", ":Telescope oldfiles<CR>"),
    dashboard.button("LDR sf", "🔍 Search Files", ":Telescope find_files<CR>"),
    dashboard.button("LDR sg", "  Find Word", ":Telescope live_grep<CR>"),
    dashboard.button("LDR gb", "  Git Branches", ":Telescope git_commits<CR>"),
    dashboard.button("LDR ne", "📝 Neovim Edit", ":lua require('plugin.config.telescope').edit_neovim()<CR>"),
    dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
  }

  dashboard.section.footer.val  = "kickNV by coderj001"


  local handle = io.popen('fortune')
  local fortune = handle:read("*a")
  handle:close()
  dashboard.section.footer.val = fortune

  alpha.setup(dashboard.opts)
end

return M
