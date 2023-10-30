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
  -- Git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.extras.gitsigns").setup()
    end
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "sindrets/diffview.nvim",
        lazy = true,
        enabled = true,
        event = "BufRead",
      }
    },
    config = function()
      require("plugins.extras.neogit").setup()
    end
  },
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.extras.lualine").setup()
    end,
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    }
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("plugins.extras.indent_blankline").setup()
    end
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      })
    end,
    dependencies = {
      "nvim-ts-context-commentstring",
      "JoosepAlviste/nvim-ts-context-commentstring"
    }
  }, -- "gc" to comment visual regions/lines

  {  -- braket and tag
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.extras.autopairs").setup()
    end
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup {
        mapping = { "jk" }, -- a table with mappings to use
      }
    end
  },
  {
    -- File manager
    "nvim-tree/nvim-tree.lua",
    version = "nightly",
    event = "VimEnter",
    config = function()
      require("plugins.extras.nvimtree").setup()
    end,
    dependencies = {
      {
        "antosha417/nvim-lsp-file-operations",
        config = function()
          require("lsp-file-operations").setup()
        end
      }
    }
  },
  {
    -- Notifocation
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      require("plugins.extras.notification").setup()
    end,
    lazy = false
  },
  {
    -- Bufferline
    "akinsho/bufferline.nvim",
    version = "v3.*",
    config = function()
      require("plugins.extras.bufferline").setup()
    end
  },

  {
    -- Telescope
    "nvim-telescope/telescope.nvim",
    event = { "VimEnter" },
    cmd = { "Telescope" },
    version = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
        cond = vim.fn.executable "make" == 1,
      },
      -- "debugloop/telescope-undo.nvim"
      "nvim-telescope/telescope-symbols.nvim",
      "desdic/agrolens.nvim",
    },
    config = function()
      require("plugins.extras.telescope").setup()
    end
  },

  {
    -- Split
    "Wansmer/treesj",
    event = "BufWinEnter",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("plugins.extras.treesj").setup()
    end,
  },



  { "jiangmiao/auto-pairs", event = "BufEnter" },
  { "tpope/vim-surround",   event = "BufEnter" },
  { "tpope/vim-repeat",     event = "BufEnter" },
  { "tpope/vim-sleuth",     event = "BufEnter" },

  {
    -- keymaps, commands, and autocommands
    "mrjones2014/legendary.nvim",
    priority = 10000,
    lazy = false,
    dependencies = {
      "kkharji/sqlite.lua",
      {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        config = function()
          require("dressing").setup()
        end
      }
    },
    config = function()
      require("plugins.extras.legendary").setup()
    end
  },
}
