return {
  {
    "nvim-treesitter/nvim-treesitter",
    name = "treesitter",
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- {
      --   "lukas-reineke/indent-blankline.nvim",
      --   event = "BufWinEnter",
      --   main = "ibl",
      --   config = function()
      --     require("utils.indent_blankline").setup()
      --   end
      -- },
      {
        "mizlan/iswap.nvim",
        -- Ensure treesitter loads first by using 'after' and same events
        after = "nvim-treesitter",
        event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
        cmd = {
          'ISwapWith',
          'ISwap',
          'ISwapNode',
          'ISwapNodeWith',
        },
        keys = {
          {
            "<leader>k",
            mode = { "n" },
            ":ISwap<CR>",
            desc = "Swap variables",
          },
        },
      },
    },
    cmd = {
      "TSUpdateSync",
      "TSUpdate",
      "TSInstall",
      "TSBufEnable",
      "TSModuleInfo",
    },
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      -- Note: query_predicates is loaded automatically when treesitter loads
      -- No need to require it here as it's not available until plugin is loaded
    end,
    build = ":TSUpdate",
    config = function()
      local status, treesitter = pcall(require, "nvim-treesitter.configs")
      if (not status) then return end
      treesitter.setup {
        ensure_installed = {
          "cpp",
          "java",
          "python",
          "html",
          "javascript",
          "typescript",
          "json",
          "json5",
          "jsonc",
          "go",
          "gomod",
          "gosum",
          "bash",
          "lua",
          "luadoc",
          "luap",
          "comment",
          "markdown",
          "markdown_inline",
          "glimmer",
          "regex",
          "vim",
          "vimdoc",
          "yaml",
          "toml",
          "tsx",
          "css",
          "scss",
          "http",
          "dockerfile",
          "requirements",
          "make",
          "csv",
          "tsv",
          "ssh_config",
          "git_config",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore",
        },
        sync_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
          disable = function(lang, buf)
            local max_filesize = 50 * 1024 -- 50 KB (reduced for better performance)
            ---@diagnostic disable-next-line: undefined-global
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
        textobjects = {
          select = {
            enable = true,
          }
        }
      }
    end,
  },
}
