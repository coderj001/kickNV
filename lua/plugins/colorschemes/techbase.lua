if true then
  return {
    "mcauley-penney/techbase.nvim",
    opts = {
      italic_comments = true,
      transparent = true,

      plugin_support = {
        aerial = true,
        blink = true,
        edgy = false,
        gitsigns = true,
        hl_match_area = true,
        lazy = true,
        lualine = true,
        mason = true,
        mini_cursorword = true,
        nvim_cmp = true,
        vim_illuminate = true,
        visual_whitespace = true,
      },

      hl_overrides = {},
    },
    init = function() vim.cmd.colorscheme("techbase") end,
    priority = 1000
  }
end
