local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    -- LSP: Langauge Server Protocol
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
        "folke/neodev.nvim",
      }
    },
    config = function()
      require('plugin.config.lsp').setup()
    end
  },
  {
    -- AutoCompletion
    "hrsh7th/nvim-cmp",
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
      "rafamadriz/friendly-snippets",
      {
        "honza/vim-snippets",
        dependencies = {
          "friendly-snippets",
          "vim-snippets",
        }
      }
    }
  },
  {
    -- File Syntax
    "nvim-treesitter/nvim-treesitter",
    build = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    config = function()
      require("plugin.config.treesitter").setup()
    end,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "p00f/nvim-ts-rainbow",
      "windwp/nvim-ts-autotag"
    }
  },
  {
    "mrjones2014/smart-splits.nvim",
    config = function()
      require("plugin.config.smartsplit").setup()
    end,
    dependencies = {
      "kwkarlwang/bufresize.nvim",
      config = function()
        require("plugin.config.bufresize").setup()
      end
    }
  },

  -- Git related plugins
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugin.config.gitsigns").setup()
    end
  },

  "jiangmiao/auto-pairs",
  "tpope/vim-surround",

  -- colorscheme
  "Alexis12119/nightly.nvim",
  "rebelot/kanagawa.nvim",
  "folke/tokyonight.nvim",

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugin.config.statusline").setup()
    end,
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    }
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require('indent_blankline').setup {
        char = '┊',
        show_trailing_blankline_indent = false,
      }
    end
  }, -- Add indentation guides even on blank lines

  {
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup()
    end
  },                       -- "gc" to comment visual regions/lines

  "tpope/vim-sleuth",      -- Detect tabstop and shiftwidth automatically

  "windwp/nvim-autopairs", -- braket and tag
  {
    "max397574/better-escape.nvim",
    config = function()
      require('better_escape').setup {
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
      require('plugin.config.nvimtree').setup()
    end,
    dependencies = {
      {
        'antosha417/nvim-lsp-file-operations',
        config = function()
          require("lsp-file-operations").setup()
        end
      }
    }
  },

  {
    -- Notifocation
    "rcarriga/nvim-notify",
    config = function()
      require("plugin.config.notification").setup()
    end,
    lazy = false
  },

  {
    -- Bufferline
    'akinsho/bufferline.nvim',
    version = "v3.*",
    config = function()
      require("plugin.config.bufferline").setup()
    end
  },

  {
    "nvim-telescope/telescope.nvim",
    event = "Bufenter",
    cmd = { "Telescope" },
    version = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
        cond = vim.fn.executable "make" == 1,
      },
      "debugloop/telescope-undo.nvim"
    },
    config = function()
      require("plugin.config.telescope").setup()
    end
  },

  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require('plugin.config.lastplace').setup()
    end
  },

  {
    "mvllow/modes.nvim",
    config = function()
      require("plugin.config.modes").setup()
    end
  },

  {
    "gen740/SmoothCursor.nvim",
    config = function()
      require("plugin.config.smoothcursor").setup()
    end
  },

  {
    "NTBBloodbath/rest.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("plugin.config.rest")
    end
  },

  {
    "phaazon/hop.nvim",
    version = "v2",
    config = function() require("plugin.config.hop").setup() end
  }
}

local opts = {}

require("lazy").setup(plugins, opts)
require('plugin.config.colorscheme').setup()
