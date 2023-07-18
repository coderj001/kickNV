local M = {}

function M.setup()
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
    -- Keybindings for luasnip
    ['<A-k>'] = function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end,
    ['<A-j>'] = function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
    ['<A-l>'] = function(fallback)
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      else
        -- Print current time
        local t = os.date("*t")
        local time = string.format("%02d:%02d:%02d", t.hour, t.min, t.sec)
        print(time)
      end
    end,
    ['<A-h>'] = function(fallback)
      if luasnip.choice_active() then
        luasnip.change_choice(-1)
      else
        fallback()
      end
    end,
  },
    sources = {
      { name = 'nvim_lsp',   icon = lsp_symbol },
      { name = 'luasnip',    icon = luasnip_symbol },
      { name = 'treesitter', icon = treesitter_symbol },
      { name = 'buffer',     icon = buffer_symbol },
      { name = 'rg',         icon = rg_symbol },
      { name = 'tags',       icon = tags_symbol },
      { name = 'path',       icon = path_symbol },
      { name = 'tmux',       icon = tmux_symbol },
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
    max_limit = 9,
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
end

return M
