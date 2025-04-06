return {
  "saghen/blink.cmp",
  enabled = true,
  dependencies = {
    "rafamadriz/friendly-snippets",
    "Kaiser-Yang/blink-cmp-dictionary",
    "mikavilpas/blink-ripgrep.nvim",
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      config = function()
        local ok, luasnip = pcall(require, "luasnip")
        if (not ok) then
          vim.notify("error loading luasnip")
          return
        end
        vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]])
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_snipmate").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/typescript" } }
        require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets/" })
      end
    },
  },
  event = { "LspAttach" },

  version = "1.*",
  opts = function(_, opts)
    opts.enabled = function()
      local filetype = vim.bo[0].filetype
      if filetype == "TelescopePrompt" or filetype == "minifiles" or filetype == "snacks_picker_input" then
        return false
      end
      return true
    end

    opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
        "ripgrep",
        "dictionary"
      },
      providers = {
        lsp = {
          name = "lsp",
          enabled = true,
          module = "blink.cmp.sources.lsp",
          min_keyword_length = 1,
          score_offset = 90, -- NOTE: the higher the number, the higher the priority
        },
        path = {
          name = "Path",
          module = "blink.cmp.sources.path",
          score_offset = 25,
          fallbacks = { "snippets", "buffer" },
          opts = {
            trailing_slash = false,
            label_trailing_slash = true,
            get_cwd = function(context)
              return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
            end,
            show_hidden_files_by_default = true,
          },
        },
        snippets = {
          name = "Snippets",
          enabled = true,
          max_items = 5,
          module = "blink.cmp.sources.snippets",
          min_keyword_length = 2,
          score_offset = 88,
        },
        buffer = {
          name = "Buffer",
          enabled = true,
          max_items = 3,
          module = "blink.cmp.sources.buffer",
          min_keyword_length = 2,
          score_offset = 45,
        },
        dictionary = {
          module = "blink-cmp-dictionary",
          name = "Dict",
          score_offset = 20,
          enabled = true,
          max_items = 8,
          min_keyword_length = 3,
        },
        ripgrep = {
          module = "blink-ripgrep",
          name = "Ripgrep",
          score_offset = 20,
          opts = {
            prefix_min_len = 3,
            context_size = 5,
            max_filesize = "1M",
            project_root_marker = { ".git", "package.json", ".root" },
            project_root_fallback = true,
            search_casing = "--ignore-case",
            fallback_to_regex_highlighting = true,
            ignore_paths = {},
            additional_paths = {},
            toggles = {
              on_off = nil,
            },
            future_features = {
              backend = {
                use = "ripgrep",
              },
            },
          },
          transform_items = function(_, items)
            for _, item in ipairs(items) do
              item.labelDetails = {
                description = "(rg)",
              }
            end
            return items
          end,
        },
      }
    })
    opts.snippets = {
      preset = "luasnip",
    }
    opts.cmdline = {
      enabled = true,
    }
    opts.completion = {
      keyword = {
        range = 'prefix',
      },
      trigger = {
        show_on_keyword = true,
        prefetch_on_insert = true,
        show_in_snippet = true,
        show_on_trigger_character = true,
        show_on_blocked_trigger_characters = { '.', ' ', '\n', '\t' },
        show_on_x_blocked_trigger_characters = { "'", '"', '(' },
        show_on_insert_on_trigger_character = true,
      },
      menu = {
        border = "single",
        draw = {
          treesitter = { 'lsp' }
        }
      },
      documentation = {
        auto_show = true,
        window = {
          border = "single",
        },
      },
    }
    opts.keymap = {
      preset = "default",
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },

      ["<S-k>"] = { "scroll_documentation_up", "fallback" },
      ["<S-j>"] = { "scroll_documentation_down", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-l>"] = { "accept" },
      ["<C-d>"] = { "hide", "fallback" },
      ["<C-g>"] = {
        function()
          -- invoke manually, requires blink >v0.8.0
          require("blink-cmp").show({ providers = { "ripgrep" } })
        end,
      },
    }
    return opts
  end,
}
