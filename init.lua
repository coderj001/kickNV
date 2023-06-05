-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  }

  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'ray-x/cmp-treesitter',
      'lukas-reineke/cmp-rg',
      'quangnguyen30192/cmp-nvim-tags',
      'andersevenrud/cmp-tmux',
      'saadparwaiz1/cmp_luasnip',
      {
        "L3MON4D3/LuaSnip",
        wants = {
          "friendly-snippets",
          "vim-snippets",
        },
      },
      "rafamadriz/friendly-snippets",
      "honza/vim-snippets",
    },
  }

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    config = function()
      -- [[ Configure Treesitter ]]
      -- See `:help nvim-treesitter`
      require('nvim-treesitter.configs').setup {
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = "all",
        sync_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          disable = { "cpp", "latex" },
        },
        indent = {
          enable = { "javascriptreact" },
          disable = { 'python' },
        },
        autotag = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<c-backspace>',
          },
        },
        rainbow = {
          enable = true,
          extendend_mode = true,
          max_file_lines = nil,
        },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
        },
      }
    end
  }

  use({
    'nvim-treesitter/nvim-treesitter-textobjects', -- Additional text objects via treesitter
    after = 'nvim-treesitter',
  })

  use({
    "p00f/nvim-ts-rainbow", -- Additional Color to Brackets
    after = 'nvim-treesitter',
  })
  use({
    "windwp/nvim-ts-autotag", -- Additional Auto open tags
    after = 'nvim-treesitter'
  })

  use({
    "JoosepAlviste/nvim-ts-context-commentstring",
    after = 'nvim-treesitter'
  })

  use({
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
      })
    end,
    after = "nvim-ts-context-commentstring",
    require = { { 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' } }
  })

  -- Window Split Manager
  use {
    "mrjones2014/smart-splits.nvim",
  }
  use {
    "kwkarlwang/bufresize.nvim",
    config = function()
      local opts = { noremap = true, silent = true }
      require("bufresize").setup({
        register = {
          keys = {
            { "n", "<leader>=", "<C-w>=", opts },
            { "n", "<leader>|", "<C-w>|", opts },
          },
          trigger_events = { "BufWinEnter", "WinEnter" },
        },
        resize = {
          keys = {},
          trigger_events = { "VimResized" },
          increment = false,
        },
      })
    end,
  }

  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-surround'
  use 'jiangmiao/auto-pairs'
  use 'lewis6991/gitsigns.nvim'

  -- colorscheme
  use "Alexis12119/nightly.nvim"
  use "rebelot/kanagawa.nvim"
  use 'folke/tokyonight.nvim'


  use { 'kyazdani42/nvim-web-devicons' }
  -- StatusLine For Neovim
  use {
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-web-devicons" },
    config = function()
      local function get_words()
        if vim.bo.filetype == "md" or vim.bo.filetype == "txt" or vim.bo.filetype == "markdown" then
          if vim.fn.wordcount().visual_words == 1 then
            return tostring(vim.fn.wordcount().visual_words) .. " word"
          elseif not (vim.fn.wordcount().visual_words == nil) then
            return tostring(vim.fn.wordcount().visual_words) .. " words"
          else
            return tostring(vim.fn.wordcount().words) .. " words"
          end
        else
          return ""
        end
      end

      local function filename()
        local file = vim.fn.expand("%:p")
        local homedir = vim.loop.os_homedir()
        local base_dir = homedir .. "/projects"
        local _, index = string.find(file, base_dir, 1, true)
        if index then
          return vim.fn.fnamemodify(file, ":~:.")
        else
          return vim.fn.expand("%:t")
        end
      end

      local function lsp_status()
        local lsp = vim.lsp.util.get_diagnostics_count(0, [[Error]])
        local icon = ''
        if lsp > 0 then
          icon = ' '
        end
        return icon .. 'LSP'
      end

      require("lualine").setup({
        options = {
          theme = "tokyonight",
          section_separators = "",
          component_separators = "",
        },
        sections = {
          lualine_a = { { "mode", color = { gui = "bold" } } },
          lualine_b = { "branch", "diff" },
          lualine_c = { { "filename", file_status = true, path = 1, formatter = filename } },
          lualine_x = { "encoding", "fileformat", "filetype", get_words },
          lualine_y = { "progress" },
          lualine_z = { lsp_status, { "diagnostics", sources = { "nvim_lsp" } } },
        },
        extensions = {
          "fzf",
          "fugitive",
          "quickfix",
          "nvim-tree",
        },
      })
    end,
  }


  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use 'tpope/vim-sleuth'                    -- Detect tabstop and shiftwidth automatically

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }
  use { "debugloop/telescope-undo.nvim" }


  use({ "windwp/nvim-autopairs" })      -- auto-pairs
  use { "max397574/better-escape.nvim", -- better excepe experience
    config = function()
      require("better_escape").setup {
        mapping = { "jk" }, -- a table with mappings to use
      }
    end }
  -- Neovim File Manage
  use {
    'nvim-tree/nvim-tree.lua',
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  use({
    -- Hop plugin for movement
    "phaazon/hop.nvim",
    branch = "v2",
    config = function() require("hop").setup() end
  })
  -- bufferline
  use { 'akinsho/bufferline.nvim', tag = "v3.*" }

  use({
    -- to put cursor into lastplace visited in file
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = {
          "quickfix",
          "nofile",
          "help",
        },
        lastplace_ignore_filetype = {
          "gitcommit",
          "gitrebase",
          "svn",
          "hgcommit",
        },
        lastplace_open_folds = true,
      })
    end
  })

  use({
    "mvllow/modes.nvim",
    config = function()
      require("modes").setup({
        colors = {
          normal = "#8ba4b0",
          insert = "#98bb6c",
          delete = "#ff5370",
          copy = "#f78c6c",
          visual = "#8992a7"
        },
        line_opacity = 0.25,
        set_cursor = true,
        ignore_filetypes = {
          "NvimTree",
          "TelescopePrompt",
        }
      })
    end
  })

  use({
    "gen740/SmoothCursor.nvim",
    config = function()
      require("smoothcursor").setup({
        cursor = "",
        fancy = {
          enable = true,
          head = {
            cursor = "",
            texthl = "SmoothCursor",
            linehl = nil,
          }
        }
      })
    end
  })

  use {
    'AckslD/nvim-trevJ.lua',
    config = 'require("trevj").setup()',
    setup = function()
      vim.keymap.set('n', '<leader>j', function()
        require('trevj').format_at_cursor()
      end)
    end,
  }

  use({
    "NTBBloodbath/rest.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("rest-nvim").setup({
        result_split_horizontal = false,
        highlight = { enabled = true, timeout = 150 },
        result = {
          show_url = true,
          show_http_info = true,
          show_headers = true,
          formatters = {
            json = "jq",
            html = function(body)
              return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
            end
          }
        },
        jump_to_request = true,
      })
      local rest_nvim = require('rest-nvim')
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "http",
        callback = function()
          local buff = tonumber(vim.fn.expand("<abuf>"), 10)
          vim.keymap.set("n", "<leader>rn", rest_nvim.run,
            { noremap = true, buffer = buff })
          vim.keymap.set("n", "<leader>rl", rest_nvim.last,
            { noremap = true, buffer = buff })
          vim.keymap.set("n", "<leader>rp", function() rest_nvim.run(true) end,
            { noremap = true, buffer = buff })
        end
      })
    end
  })

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
vim.opt.background = "dark"

require('kanagawa').setup({
  compile = true,
  commentStyle = { italic = true },
  functionStyle = { italic = true },
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  typeStyle = {},
  transparent = true,
  theme = "dragon",
  colors = {
    palette = {},
    theme = {
      wave = {},
      lotus = {},
      dragon = {},
      all = {
        ui = {
          bg_gutter = "none"
        }
      }
    },
  },
  overrides = function(colors)
    local theme = colors.theme
    return {
      TelescopeTitle = { bold = true },
      TelescopePromptNormal = { bg = theme.ui.bg_p1, fg = "none" },
      TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = "none" },
      TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = "none" },
      TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = "none" },
      TelescopePreviewNormal = { bg = theme.ui.bg_dim },
      -- TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
      -- NormalFloat = { bg = "none" },
      LineNr = { bg = "none" },
      CursorLineNr = { bg = "none" },
      GitsignsAdd = { bg = "none" },
      GitSignsChange = { bg = "none" },
      GitsignsDelete = { bg = "none" },
    }
  end,
  background = {
    dark = "dragon",
    light = "lotus"
  },
})

require("tokyonight").setup({
  style = "moon",
  light_style = "night",
  transparent = true,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = { italic = true },
    variables = { italic = true },
    sidebars = "dark",
    floats = "dark",
  },
  sidebars = { "qf", "help" },
  day_brightness = 0.3,
  hide_inactive_statusline = true,
  dim_inactive = true,
  lualine_bold = true,
})


vim.cmd [[colorscheme tokyonight]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")


-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>")
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>")
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>")
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>")


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})




-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}

-- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup {
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 10,
    ignore_whitespace = false,
  },
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<ignore>'
    end, { expr = true })

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<ignore>'
    end, { expr = true })

    -- actions
    map('n', '<leader>hs', gs.stage_hunk)
    map('n', '<leader>hr', gs.reset_hunk)
    map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end)
    map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end)
    map('n', '<leader>hs', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hr', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line { full = true } end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('v', '<leader>hd', gs.diffthis)
    map('n', '<leader>hd', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)
    map({ 'o', 'x' }, 'ih', ':<c-u>gitsigns select_hunk<cr>')
  end
}


-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob=!.git/",
      "--glob=!node_modules/",
      "--glob=!.venv/",
    },
    prompt_prefix = "🔍 ",
    selection_caret = " ",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        preview_width = 0.55,
        results_width = 0.8,
      },
      height = 0.9,
      width = 0.87,
      preview_cutoff = 120,
    },
    entry_prefix = "  ",
    initial_mode = "insert",
    path_display = { "truncate" },
    winblend = 20,
    -- borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    borderchars = { '━', '┃', '━', '┃', '┏', '┓', '┛', '┗' },
    color_devicons = true,
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ["<C-n>"] = require('telescope.actions').cycle_history_next,
        ["<C-p>"] = require('telescope.actions').cycle_history_prev,
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<C-k>"] = require('telescope.actions').move_selection_previous,
      },
    },
  },
  extension = {
    undo = {
      side_by_side = true,
      layout_strategy = "vertical",
      layout_config = {
        preview_height = 0.8,
      },
    },
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = 'smart_case',       -- or "ignore_case" or "respect_case"
    },
  },
  pickers = {
    buffers = {
      prompt_title = '✨ Search Buffers ✨',
      mappings = {
        n = {
          ['d'] = require('telescope.actions').delete_buffer,
          ['<tab>'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_next,
          ['<s-tab>'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_previous,
          ['v'] = require('telescope.actions').file_vsplit,
          ['s'] = require('telescope.actions').file_split,
          ['<cr>'] = require('telescope.actions').file_edit,
        },
      },
      sort_mru = true,
      preview_title = false,
      initial_mode = "normal"
    },
  }
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'undo')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 15,
    previewer = false,
    prompt_title = '✨ Search Current Buffers ✨',
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sx', require('telescope.builtin').resume, { desc = '[S]earch by [X]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  -- nmap('<leader>D', vim.lsp.buf.type_definition, '[T]ype [D]efinition')
  -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  -- nmap('<leader>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  clangd = {},
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  jsonls = {
    settings = {
      json = {
        schemas = {},
      },
    },
    setup = {
      commands = {
        Format = {
          function()
            vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
          end,
        },
      },
    },
  },
  tsserver = {},
  lua_ls = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      library = {
        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        [vim.fn.stdpath("config") .. "/lua"] = true,
      },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- Turn on lsp status information
require('fidget').setup()

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

local lsp_symbol = ""
local luasnip_symbol = "﬌"
local treesitter_symbol = ""
local buffer_symbol = "﬘"
local tags_symbol = ""
local rg_symbol = ""
local path_symbol = ""
local tmux_symbol = ""

cmp.setup {
  performance = {
    max_view_entries = 20,
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<C-j>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-k>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    {
      name = 'nvim_lsp',
      icon = lsp_symbol,
      max_item_count = 10,
      entry_filter = function(entry)
        return cmp.lsp.CompletionItemKind.Snippet ~= entry:get_kind()
      end
    },
    { name = 'luasnip',    icon = luasnip_symbol,    max_item_count = 5 },
    { name = 'treesitter', icon = treesitter_symbol, max_item_count = 5 },
    { name = 'buffer',     icon = buffer_symbol,     max_item_count = 5 },
    { name = 'rg',         icon = rg_symbol,         max_item_count = 5 },
    { name = 'tags',       icon = tags_symbol,       max_item_count = 4 },
    { name = 'path',       icon = path_symbol,       max_item_count = 3 },
    { name = 'tmux',       icon = tmux_symbol,       max_item_count = 2 },
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind_icons = {
        Text = "",
        Method = "m",
        Function = "",
        Constructor = "",
        Field = "",
        Variable = "",
        Class = "",
        Interface = "",
        Module = "",
        Property = "",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = ""
      }
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        treesitter = "[Treesitter]",
        buffer = "[Buffer]",
        rg = "[Rg]",
        tags = "[Tags]",
        path = "[Path]",
        tmux = "[Tmux]",
      })[entry.source.name]
      return vim_item
    end,
  },
  window = {
    documentation = {
      border = "rounded",
    },
    experimental = { ghost_text = false, native_menu = false }
  }
}

-- Extra snippets
-- Load snippets
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()

-- Load custom javascript
require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/typescript" } }

-- Smart Split Config
require("smart-splits").setup {
  ignored_filetypes = { 'nofile', 'quickfix', 'prompt' },
  ignored_buftypes = { 'NvimTree' },
  resize_mode = {
    silent = true,
    hooks = {
      on_leave = require("bufresize").register
    }
  }
}

-- Move to the split above the current one
vim.api.nvim_set_keymap("n", "<C-j>", ":lua require('smart-splits').move_cursor_down()<cr>",
  { noremap = true, silent = true })

-- Move to the split below the current one
vim.api.nvim_set_keymap("n", "<C-k>", ":lua require('smart-splits').move_cursor_up()<cr>",
  { noremap = true, silent = true })

-- Move to the split to the left of the current one
vim.api.nvim_set_keymap("n", "<C-h>", ":lua require('smart-splits').move_cursor_left()<cr>",
  { noremap = true, silent = true })

-- Move to the split to the right of the current one
vim.api.nvim_set_keymap("n", "<C-l>", ":lua require('smart-splits').move_cursor_right()<cr>",
  { noremap = true, silent = true })

-- Load nvim-tree plugin
require('nvim-tree').setup {
  -- Set options for nvim-tree
  disable_netrw       = false, -- Disable netrw
  hijack_netrw        = false, -- Hijack netrw window on startup
  update_focused_file = {
    enable     = true,         -- Update the focused file in the tree when you change files
    update_cwd = true,         -- Update the current working directory of the tree
  },
  view                = {
    cursorline = true,
    width = 30,     -- Set the width of the tree view
    side = 'right', -- Put the tree view on the left side of the editor
    mappings = {
      custom_only = false,
      list = {
        { key = { "<CR>", "o", "<2-LeftMouse>" }, cb = require 'nvim-tree.config'.nvim_tree_callback("edit") },
        { key = { "<2-RightMouse>", "<C-]>" },    cb = require 'nvim-tree.config'.nvim_tree_callback("cd") },
        { key = "<C-v>",                          cb = require 'nvim-tree.config'.nvim_tree_callback("vsplit") },
        { key = "<C-x>",                          cb = require 'nvim-tree.config'.nvim_tree_callback("split") },
        { key = "<C-t>",                          cb = require 'nvim-tree.config'.nvim_tree_callback("tabnew") },
        { key = "<",                              cb = require 'nvim-tree.config'.nvim_tree_callback("prev_sibling") },
        { key = ">",                              cb = require 'nvim-tree.config'.nvim_tree_callback("next_sibling") },
        { key = "P",                              cb = require 'nvim-tree.config'.nvim_tree_callback("parent_node") },
        { key = "<BS>",                           cb = require 'nvim-tree.config'.nvim_tree_callback("close_node") },
        { key = "<S-CR>",                         cb = require 'nvim-tree.config'.nvim_tree_callback("close_node") },
        { key = "<Tab>",                          cb = require 'nvim-tree.config'.nvim_tree_callback("preview") },
        { key = "K",                              cb = require 'nvim-tree.config'.nvim_tree_callback("first_sibling") },
        { key = "J",                              cb = require 'nvim-tree.config'.nvim_tree_callback("last_sibling") },
        { key = "I",                              cb = require 'nvim-tree.config'.nvim_tree_callback("toggle_ignored") },
        { key = "H",                              cb = require 'nvim-tree.config'.nvim_tree_callback("toggle_dotfiles") },
        { key = "R",                              cb = require 'nvim-tree.config'.nvim_tree_callback("refresh") },
        { key = "a",                              cb = require 'nvim-tree.config'.nvim_tree_callback("create") },
        { key = "d",                              cb = require 'nvim-tree.config'.nvim_tree_callback("remove") },
        { key = "r",                              cb = require 'nvim-tree.config'.nvim_tree_callback("rename") },
        { key = "<C-r>",                          cb = require 'nvim-tree.config'.nvim_tree_callback("full_rename") },
        { key = "x",                              cb = require 'nvim-tree.config'.nvim_tree_callback("cut") },
        { key = "c",                              cb = require 'nvim-tree.config'.nvim_tree_callback("copy") },
        { key = "p",                              cb = require 'nvim-tree.config'.nvim_tree_callback("paste") },
      },
    },
  },
  actions             = {
    open_file = {
      resize_window = true,
    }
  },
  filters             = {
    dotfiles = true,
    exclude = { 'node_modules', '.venv', 'env', '.env' },
  },
  renderer            = {
    add_trailing   = true,
    group_empty    = true,
    highlight_git  = true,
    indent_width   = 1,
    indent_markers = {
      enable = true,
    },
    icons          = {
      git_placement = "after",
      show = {
        file = true,
      },
      glyphs = { default = " ", },
    },
  },
  log                 = {
    enable = true,
    truncate = true,
    types = {
      all = true,
      config = true,
      copy_paste = true,
      dev = true,
      diagnostics = true,
      git = true,
      profile = true,
      watcher = true,
    },
  },
}
-- Keybindings for nvim-tree
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })

-- Added NvimTree open on startup functionality
local function open_nvim_tree(data)
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
  local directory = vim.fn.isdirectory(data.file) == 1
  if not no_name and not directory then
    return
  end
  if directory then
    vim.cmd.cd(data.file)
  end
  require("nvim-tree.api").tree.open()
end


vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

local function load_extra_options()
  local function bind_extra_cmd(options)
    for optionCount = 1, #options do vim.cmd(options[optionCount]) end
  end
  local options = {
    "filetype plugin on", "filetype indent on", "cabbr Q q", "cabbr Q! q!",
    "cabbr W! w!", "cabbr W w", "cabbr WA wa", "cabbr Wa wa", "cabbr Wq wq",
    "cabbr WQ wq", "cabbr Qa qa", "cabbr QA qa"
  }
  bind_extra_cmd(options)
end

load_extra_options()

-- Hop Config
-- place this in one of your configuration file(s)
local hop = require('hop')
hop.setup {
  term_seq_bias = 0.5,
  keys = 'etovxqpdygfblzhckisuran',
}
local directions = require('hop.hint').HintDirection
vim.keymap.set({ 'n', 'v' }, 'f',
  function()
    hop.hint_char1({
      direction = directions.AFTER_CURSOR,
      current_line_only = true,
    })
  end,
  { remap = true })
vim.keymap.set({ 'n', 'v' }, 'F',
  function()
    hop.hint_char1(
      {
        direction = directions.BEFORE_CURSOR,
        current_line_only = true,
      }
    )
  end,
  { remap = true })
vim.keymap.set({ 'n', 'v' }, 't',
  function()
    hop.hint_char1(
      {
        direction = directions.AFTER_CURSOR,
        current_line_only = true,
        hint_offset = -1,
      }
    )
  end,
  { remap = true })
vim.keymap.set({ 'n', 'v' }, 'T',
  function()
    hop.hint_char1({
      direction = directions.BEFORE_CURSOR,
      current_line_only = true,
      hint_offset = 1,
    })
  end,
  { remap = true })
vim.keymap.set({ 'n', 'v' }, '<leader>w', function() hop.hint_words() end, {})
vim.keymap.set({ 'n', 'v' }, '<leader>k', function() hop.hint_lines() end, {})
vim.keymap.set('n', '<leader>c', function() hop.hint_char1() end, {})
vim.keymap.set('n', '<leader>C', function() hop.hint_char2() end, {})
vim.keymap.set('n', '<leader>m', function() hop.hint_patterns() end, {})

-- Config Bufferline
require("bufferline").setup {
  options = {
    number_style = "",
    diagnostics = "nvim_lsp",
    offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "left" } },
    show_close_icon = false,
    separator_style = "any",
    insert_at_end = false,
    insert_at_start = true,
    icon_separator_active = "▎",
    icon_separator_inactive = "▎",
    icon_close_tab = "",
    icon_close_tab_modified = "",
    icon_pinned = "車",
    semantic_letters = true,
    hover = {
      enabled = true,
      delay = 100,
      reveal = { "close" }
    },
    indicator = { style = "none" },
    show_buffer_close_icons = false,
    show_tab_indicators = false,
    always_show_bufferline = true,
  }
}

vim.api.nvim_set_keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", {})
vim.api.nvim_set_keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })


-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
