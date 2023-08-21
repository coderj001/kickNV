local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local success, maybe_error = pcall(
    vim.fn.system, {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    }
  )
  if not success then
    require('plugin.config.notification').error("ERROR: Fail to install plugin manager lazy.nvim", maybe_error)
    require('plugin.config.notification').info("You can cleanup the " .. lazypath .. " and start again")
    return
  end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        'folke/neodev.nvim',
        config = function()
          require('neodev').setup()
        end
      },
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      {
        'j-hui/fidget.nvim',
        branch = "legacy"
      },
      {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
          require("lsp_lines").setup()
        end,
      },
    },
    config = function()
      require("plugin.config.lsp").setup()
    end,
    cmd = { "Mason" }
  },
  {
    'pmizio/typescript-tools.nvim',
    event = { 'BufReadPost *.ts,*.tsx,*.js,*.jsx', 'BufNewFile *.ts,*.tsx,*.js,*.jsx' },
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-lspconfig' },
    opts = {
      on_attach = require('plugin.config.typescript-tools').on_attach,
      settings = {
        separate_diagnostic_server = true,
        tsserver_file_preferences = {
          includeInlayParameterNameHints = 'literals',
          includeInlayVariableTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeCompletionsForModuleExports = true,
          quotePreference = "auto",
        },
      },
    },
  },
  {
    "folke/neoconf.nvim",
    cmd = "Neoconf",
    config = function()
      require("neoconf").setup()
    end
  },
  {
    -- AutoCompletion
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
      require('plugin.config.cmp').setup()
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
      pcall(require('nvim-treesitter.install').update { with_sync = false })
    end,
    config = function()
      require("plugin.config.treesitter").setup()
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
          require('hlargs').setup()
        end
      },
      {
        "ZhiyuanLck/smart-pairs",
        event = 'InsertEnter',
        config = function()
          require('pairs'):setup()
        end
      }
    }
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    event = "BufReadPost",
    config = function()
      require('plugin.config.ufo').setup()
    end
  },
  {
    "mrjones2014/smart-splits.nvim",
    event = "Bufenter",
    config = function()
      require("plugin.config.smartsplit").setup()
    end,
    lazy = false,
    dependencies = {
      "kwkarlwang/bufresize.nvim",
      config = function()
        require("plugin.config.bufresize").setup()
      end
    }
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugin.config.gitsigns").setup()
    end
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim'
    },
    config = function()
      require("plugin.config.neogit").setup()
    end
  },

  "jiangmiao/auto-pairs",
  { "tpope/vim-surround",       event = "Bufenter" },
  { "tpope/vim-repeat",         event = "Bufenter" },

  -- colorscheme
  { "catppuccin/nvim",          name = "catppuccin", priority = 1000 },
  { "Alexis12119/nightly.nvim", name = "nightly",    priority = 1000 },
  { "rebelot/kanagawa.nvim",    priority = 1000 },
  { "folke/tokyonight.nvim",    priority = 1000 },

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
    event = "VimEnter",
    config = function()
      require('plugin.config.indent_blankline').setup()
    end
  }, -- Add indentation guides even on blank lines

  {
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
      })
    end,
    dependencies = {
      'nvim-ts-context-commentstring',
      'JoosepAlviste/nvim-ts-context-commentstring'
    }
  },                       -- "gc" to comment visual regions/lines

  "tpope/vim-sleuth",      -- Detect tabstop and shiftwidth automatically
  "windwp/nvim-autopairs", -- braket and tag

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
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
      require("plugin.config.telescope").setup()
    end
  },

  {
    -- Lastplace
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require('plugin.config.lastplace').setup()
    end
  },

  {
    -- keymaps, commands, and autocommands
    'mrjones2014/legendary.nvim',
    priority = 10000,
    lazy = false,
    dependencies = {
      'kkharji/sqlite.lua',
      {
        'stevearc/dressing.nvim',
        event = "VeryLazy",
        config = function()
          require('dressing').setup()
        end
      }
    },
    config = function()
      require("plugin.config.legendary").setup()
    end
  },
  {
    "monaqa/dial.nvim",
    event = "VeryLazy",
    keys = { "<C-a>", { "<C-x>", mode = "n" } },
  },
  {
    "mvllow/modes.nvim",
    event = "VeryLazy",
    config = function()
      require("plugin.config.modes").setup()
    end
  },

  {
    "gen740/SmoothCursor.nvim",
    event = "VeryLazy",
    config = function()
      require("plugin.config.smoothcursor").setup()
    end
  },

  {
    "NTBBloodbath/rest.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("plugin.config.rest").setup()
    end
  },
  {
    'folke/flash.nvim',
    event = "VeryLazy",
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash" },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        "Treesitter Search"
      },
      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc =
        "Toggle Flash Search"
      },
    },
  },

  {
    -- Dashboard
    'goolord/alpha-nvim',
    event = "VimEnter",
    config = function()
      require('plugin.config.dashboard').setup()
    end
  },

  {
    -- Split
    'Wansmer/treesj',
    event = "BufWinEnter",
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('plugin.config.treesj').setup()
    end,
  },

  { -- tmux nav for nvim
    'alexghergh/nvim-tmux-navigation',
    event = "VeryLazy",
    config = function()
      require 'nvim-tmux-navigation'.setup {
        disable_when_zoomed = true,
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
        }
      }
    end
  },

  {
    'cpea2506/relative-toggle.nvim',
    config = function()
      require('plugin.config.relativenumber').setup()
    end
  },

  {
    "ray-x/sad.nvim",
    event = "VeryLazy",
    dependencies = { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
    config = function()
      require("sad").setup {}
    end,
  },
}

local opts = {
  spec = {
    { import = "base" },
    { import = "pde" },
  },
  install = {
    missing = true,
    colorscheme = {
      "catppuccin",
      "tokyonight",
    },
  },
  rtp = {
    disabled_plugins = {
      "2html_plugin",
      "tohtml",
      "getscript",
      "getscriptPlugin",
      "gzip",
      "logipat",
      "netrw",
      "netrwPlugin",
      "netrwSettings",
      "netrwFileHandlers",
      "matchit",
      "tar",
      "tarPlugin",
      "rrhelper",
      "spellfile",
      "spellfile_plugin",
      "vimball",
      "vimballPlugin",
      "zip",
      "zipPlugin",
      "tutor",
      "rplugin",
      "syntax",
      "synmenu",
      "optwin",
      "compiler",
      "bugreport",
    }
  }
}

require("lazy").setup(plugins, opts)
require("plugin.config.colorscheme").setup()


-------------------------------
------------ keymaps ----------
-------------------------------
require("core.default_config").keymaps.default()
