return {
  "hrsh7th/nvim-cmp",
  name = "cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lua",
    "ray-x/cmp-treesitter",
    "lukas-reineke/cmp-rg",
    "quangnguyen30192/cmp-nvim-tags",
    "andersevenrud/cmp-tmux",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
    "lukas-reineke/cmp-under-comparator",
    {
      "honza/vim-snippets",
      dependencies = {
        "friendly-snippets",
        "vim-snippets",
      }
    }
  },
  config = function()
    require("utils.cmp").setup()
  end
}
