return {
  {
    -- Auto Completion
    "hrsh7th/nvim-cmp",
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
      require("plugins.extras.cmp").setup()
    end
  },
  {
    -- File Syntax
    "nvim-treesitter/nvim-treesitter",
    event = {
      "BufReadPost",
      "BufNewFile",
    },
    build = function()
      pcall(require("nvim-treesitter.install").update { with_sync = false })
    end,
    config = function()
      require("plugins.extras.treesitter").setup()
    end,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "p00f/nvim-ts-rainbow",
      "HiPhish/nvim-ts-rainbow2",
      "windwp/nvim-ts-autotag",
      "mizlan/iswap.nvim",
      {
        "m-demare/hlargs.nvim",
        config = function()
          require("hlargs").setup()
        end
      },
      {
        "ZhiyuanLck/smart-pairs",
        event = "InsertEnter",
        config = function()
          require("pairs"):setup()
        end
      }
    }
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    config = function()
      require("plugins.extras.ufo").setup()
    end
  },
  {
    "mrjones2014/smart-splits.nvim",
    event = "BufEnter",
    config = function()
      require("plugins.extras.smartsplit").setup()
    end,
    lazy = false,
    dependencies = {
      "kwkarlwang/bufresize.nvim",
      config = function()
        require("plugins.extras.bufresize").setup()
      end
    }
  },
  { "jiangmiao/auto-pairs", event = "BufEnter" },
  { "tpope/vim-surround",   event = "BufEnter" },
  { "tpope/vim-repeat",     event = "BufEnter" },
}
