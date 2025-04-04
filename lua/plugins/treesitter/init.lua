return {
  {
    "nvim-treesitter/nvim-treesitter",
    name = "treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
      {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufWinEnter",
        main = "ibl",
        config = function()
          require("utils.indent_blankline").setup()
        end
      },
    },
    cmd = {
      "TSUpdateSync",
      "TSUpdate",
      "TSInstall",
      "TSBufEnable",
      "TSModuleInfo",
    },
    event = {
      "BufReadPost",
      "BufNewFile"
    },
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
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
          additional_vim_regex_highlighting = false,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
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
        },
        context = {
          enable = true,
        }
      }
    end,
  },
}
