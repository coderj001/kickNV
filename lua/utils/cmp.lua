local M = {}

local status_cmp, cmp = pcall(require, "cmp")
if (not status_cmp) then
  return
end

local status_luasnip, luasnip = pcall(require, "luasnip")
if (not status_luasnip) then
  return
end

local types = require("cmp.types")


local lsp_symbol = ""
local luasnip_symbol = ""
local treesitter_symbol = ""
local buffer_symbol = ""
local tags_symbol = ""
local rg_symbol = ""
local path_symbol = ""
local tmux_symbol = ""
local codeium_symbol = ""

local function deprioritize_snippet(entry1, entry2)
  if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
    return false
  end
  if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
    return true
  end
end

function M.setup()
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
      {
        name = 'nvim_lsp',
        icon = lsp_symbol,
        group_index = 1,
        max_item_count = 10,
        entry_filter = function(entry)
          return cmp.lsp.CompletionItemKind.Snippet ~= entry:get_kind()
        end
      },
      { name = 'luasnip',    icon = luasnip_symbol,    group_index = 1, max_item_count = 8 },
      { name = 'treesitter', icon = treesitter_symbol, group_index = 2, max_item_count = 4 },
      { name = 'buffer',     icon = buffer_symbol,     group_index = 2, max_item_count = 3 },
      { name = 'rg',         icon = rg_symbol,         group_index = 2, max_item_count = 3 },
      { name = 'tags',       icon = tags_symbol,       group_index = 2, max_item_count = 2 },
      { name = 'path',       icon = path_symbol,       group_index = 2, max_item_count = 2 },
      { name = 'tmux',       icon = tmux_symbol,       group_index = 2, max_item_count = 3 },
      -- { name = 'codeium',    icon = codeium_symbol,group_index = 1,    max_item_count = 3 },
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
          -- codeium = "[CODEIUM]",
        })[entry.source.name]
        return vim_item
      end,
    },
    max_limit = 9,
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      }
    },
    sorting = {
      priority_weight = 2,
      comparators = {
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        ---@diagnostic disable-next-line: assign-type-mismatch
        cmp.config.compare.locality,
        require "cmp-under-comparator".under,
        deprioritize_snippet,
        cmp.config.compare.exact,
        cmp.config.compare.offset,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
  }

  luasnip.config.set_config({
    region_check_events = "InsertEnter",
    delete_check_events = "TextChanged,InsertLeave",
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
      [require("luasnip.util.types").choiceNode] = {
        active = {
          virt_text = { { "●", "GruvboxOrange" } },
        },
      },
    },
  })

  vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]])

  -- Extra snippets
  -- Load snippets
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_snipmate").lazy_load()

  -- Load custom javascript
  require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/typescript" } }
  -- Load custom snippets
  require('luasnip.loaders.from_lua').load({ paths = { "./snippets" } })
end

return M
