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
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      {
        "L3MON4D3/LuaSnip",
        wants = { "friendly-snippets", "vim-snippets" },
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
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  use({ "p00f/nvim-ts-rainbow" }) -- Additional Color to Brackets
  use({ "windwp/nvim-ts-autotag" }) -- Additional Auto open tags

  -- Window Split Manager
  use {
    "mrjones2014/smart-splits.nvim",
  }
  use {
    "kwkarlwang/bufresize.nvim",
    config = function()
      require("bufresize").setup()
    end
  }

  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'

  use 'navarasu/onedark.nvim' -- Theme inspired by Atom
  use 'nyoom-engineering/oxocarbon.nvim'
  use 'folke/tokyonight.nvim'
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }
  use({ "windwp/nvim-autopairs" }) -- auto-pairs
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
require("tokyonight").setup({ style = "night", transparent = true, dim_inactive = true, lualine_bold = true })
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

-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'tokyonight',
    component_separators = '|',
    section_separators = '',
  },
}

-- Enable Comment.nvim
require('Comment').setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}

-- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      "rg", "--color=never", "--no-heading", "--with-filename",
      "--line-number", "--column", "--smart-case", "--hidden",
      "--glob=!.git/", "--glob=!node_modules/", "--glob=!.venv/"
    },
    prompt_prefix = " ",
    selection_caret = " ",
    entry_prefix = "  ",
    initial_mode = "insert",
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
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
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { "cpp", "python", "javascript", "html", "json", "tsx", "go", "gomod",
    "typescript", "bash", "lua", "dockerfile", "comment", "markdown",
    "glimmer", "regex", "tsx", "vim", "yaml", "toml" },

  highlight = { enable = true, additional_vim_regex_highlighting = false, disable = { "cpp", "latex" } },
  indent = { enable = { "javascriptreact" }, disable = { 'python' } },
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
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

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
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

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
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  jsonls = {
    settings = {
      json = {
        schemas = {
          {
            description = "TypeScript compiler configuration file",
            fileMatch = {
              "tsconfig.json",
              "tsconfig.*.json",
            },
            url = "https://json.schemastore.org/tsconfig.json",
          },
          {
            description = "Lerna config",
            fileMatch = { "lerna.json" },
            url = "https://json.schemastore.org/lerna.json",
          },
          {
            description = "Babel configuration",
            fileMatch = {
              ".babelrc.json",
              ".babelrc",
              "babel.config.json",
            },
            url = "https://json.schemastore.org/babelrc.json",
          },
          {
            description = "ESLint config",
            fileMatch = {
              ".eslintrc.json",
              ".eslintrc",
            },
            url = "https://json.schemastore.org/eslintrc.json",
          },
          {
            description = "Bucklescript config",
            fileMatch = { "bsconfig.json" },
            url = "https://raw.githubusercontent.com/rescript-lang/rescript-compiler/8.2.0/docs/docson/build-schema.json",
          },
          {
            description = "Prettier config",
            fileMatch = {
              ".prettierrc",
              ".prettierrc.json",
              "prettier.config.json",
            },
            url = "https://json.schemastore.org/prettierrc",
          },
          {
            description = "Vercel Now config",
            fileMatch = { "now.json" },
            url = "https://json.schemastore.org/now",
          },
          {
            description = "Stylelint config",
            fileMatch = {
              ".stylelintrc",
              ".stylelintrc.json",
              "stylelint.config.json",
            },
            url = "https://json.schemastore.org/stylelintrc",
          },
          {
            description = "A JSON schema for the ASP.NET LaunchSettings.json files",
            fileMatch = { "launchsettings.json" },
            url = "https://json.schemastore.org/launchsettings.json",
          },
          {
            description = "Schema for CMake Presets",
            fileMatch = {
              "CMakePresets.json",
              "CMakeUserPresets.json",
            },
            url = "https://raw.githubusercontent.com/Kitware/CMake/master/Help/manual/presets/schema.json",
          },
          {
            description = "Configuration file as an alternative for configuring your repository in the settings page.",
            fileMatch = {
              ".codeclimate.json",
            },
            url = "https://json.schemastore.org/codeclimate.json",
          },
          {
            description = "LLVM compilation database",
            fileMatch = {
              "compile_commands.json",
            },
            url = "https://json.schemastore.org/compile-commands.json",
          },
          {
            description = "Config file for Command Task Runner",
            fileMatch = {
              "commands.json",
            },
            url = "https://json.schemastore.org/commands.json",
          },
          {
            description = "AWS CloudFormation provides a common language for you to describe and provision all the infrastructure resources in your cloud environment.",
            fileMatch = {
              "*.cf.json",
              "cloudformation.json",
            },
            url = "https://raw.githubusercontent.com/awslabs/goformation/v5.2.9/schema/cloudformation.schema.json",
          },
          {
            description = "The AWS Serverless Application Model (AWS SAM, previously known as Project Flourish) extends AWS CloudFormation to provide a simplified way of defining the Amazon API Gateway APIs, AWS Lambda functions, and Amazon DynamoDB tables needed by your serverless application.",
            fileMatch = {
              "serverless.template",
              "*.sam.json",
              "sam.json",
            },
            url = "https://raw.githubusercontent.com/awslabs/goformation/v5.2.9/schema/sam.schema.json",
          },
          {
            description = "Json schema for properties json file for a GitHub Workflow template",
            fileMatch = {
              ".github/workflow-templates/**.properties.json",
            },
            url = "https://json.schemastore.org/github-workflow-template-properties.json",
          },
          {
            description = "golangci-lint configuration file",
            fileMatch = {
              ".golangci.toml",
              ".golangci.json",
            },
            url = "https://json.schemastore.org/golangci-lint.json",
          },
          {
            description = "JSON schema for the JSON Feed format",
            fileMatch = {
              "feed.json",
            },
            url = "https://json.schemastore.org/feed.json",
            versions = {
              ["1"] = "https://json.schemastore.org/feed-1.json",
              ["1.1"] = "https://json.schemastore.og/feed.json",
            },
          },
          {
            description = "Packer template JSON configuration",
            fileMatch = {
              "packer.json",
            },
            url = "https://json.schemastore.org/packer.json",
          },
          {
            description = "NPM configuration file",
            fileMatch = {
              "package.json",
            },
            url = "https://json.schemastore.org/package.json",
          },
          {
            description = "JSON schema for Visual Studio component configuration files",
            fileMatch = {
              "*.vsconfig",
            },
            url = "https://json.schemastore.org/vsconfig.json",
          },
          {
            description = "Resume json",
            fileMatch = { "resume.json" },
            url = "https://raw.githubusercontent.com/jsonresume/resume-schema/v1.0.0/schema.json",
          },
        },
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
  tsserver = {
    on_attach = function(client)
      -- Disable formatting since it is handled by Prettier
      client.resolved_capabilities.document_formatting = false

      -- Use Prettier for formatting
      local ts_utils = require("nvim-lsp-ts-utils")
      ts_utils.setup {
        eslint_enable_diagnostics = true,
        enable_formatting = true,
        formatter = "prettier",
        formatter_opts = {
          args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote" },
          stdin = true,
        },
      }
      ts_utils.setup_client(client)
    end,
    settings = {
      -- You can configure TypeScript-specific settings here
    },
  },
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

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs( -4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable( -1) then
        luasnip.jump( -1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'tags' },
    { name = 'treesitter' },
    { name = 'path' },
    { name = 'cmdline' },
    { name = 'tmux' },
  },
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

-- Disable lualine in nvim-tree
vim.g.nvim_tree_disable_netrw = 0
vim.g.nvim_tree_hijack_netrw = 0
vim.g.nvim_tree_hide_dotfiles = 1
-- Load nvim-tree plugin
require('nvim-tree').setup{
  -- Set options for nvim-tree
  disable_netrw       = true, -- Disable netrw
  hijack_netrw        = true, -- Hijack netrw window on startup
  open_on_setup       = true, -- Open the tree when running this setup function
  ignore_ft_on_setup  = {'node_modules', 'venv', '%.git', 'DS_Store', '._*'}, -- Don't open tree when these filetypes are opened
  auto_close          = true, -- Auto close tree when leaving last file
  update_focused_file = {
    enable      = true, -- Update the focused file in the tree when you change files
    update_cwd  = true, -- Update the current working directory of the tree
  },
  view = {
    width = 30, -- Set the width of the tree view
    side = 'right', -- Put the tree view on the left side of the editor
    auto_resize = true, -- Auto resize the tree view when the window is resized
    mappings = {
      custom_only = false,
      list = {
        { key = {"<CR>", "o", "<2-LeftMouse>"}, cb = require'nvim-tree'.on_node_open },
        { key = {"<2-RightMouse>", "<C-]>"},    cb = require'nvim-tree'.on_node_middle_click },
        { key = {"<C-v>"},                      cb = require'nvim-tree'.on_vsplit },
        { key = {"<C-x>"},                      cb = require'nvim-tree'.on_split },
        { key = {"<C-t>"},                      cb = require'nvim-tree'.on_tabnew },
        { key = {"<"},                           cb = require'nvim-tree'.on_keypress },
        { key = {">"},                           cb = require'nvim-tree'.on_keypress },
      },
    },
  }
}
-- Keybindings for nvim-tree
vim.api.nvim_set_keymap('n', '<Leader>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>r', ':NvimTreeRefresh<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>n.', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })


-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
