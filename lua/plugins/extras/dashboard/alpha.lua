return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha                       = require("alpha")
    local dashboard                   = require("alpha.themes.dashboard")
    -- dashboard.section.header.val      = require("config.default").options.figlet_name

    dashboard.section.buttons.val     = {
      dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
      dashboard.button("LDR  ?", "  Recently Opened Files", ":Telescope oldfiles<CR>"),
      dashboard.button("LDR  n", "  File Explorer", ":NvimTreeOpen<CR>"),
      dashboard.button("LDR sf", "🔍 Search Files", ":Telescope find_files<CR>"),
      dashboard.button("LDR sg", "  Search Grep", ":Telescope live_grep<CR>"),
      dashboard.button("q", "󰅙  Quit NVIM", ":qa<CR>"),
    }

    dashboard.section.footer.val      = "Total plugins: " .. require("lazy").stats().count
    dashboard.section.header.opts.hl  = "Include"
    dashboard.section.buttons.opts.hl = "Keyword"
    dashboard.opts.opts.noautocmd     = true


    alpha.setup(dashboard.opts)
  end
}
