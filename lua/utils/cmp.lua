local M = {}

local cmp_status_ok, cmp = pcall(require, "cmp")
if (not cmp_status_ok) then
  vim.notify("error loading cmp")
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if (not snip_status_ok) then
  vim.notify("error loading luasnip")
  return
end

local types = require("cmp.types")

local modified_priority = {
  [types.lsp.CompletionItemKind.Variable] = types.lsp.CompletionItemKind.Method,
  [types.lsp.CompletionItemKind.Snippet] = 0, -- top
  [types.lsp.CompletionItemKind.Keyword] = 0, -- top
  [types.lsp.CompletionItemKind.Text] = 100,  -- bottom
}
---@param kind integer: kind of completion entry
local function modified_kind(kind)
  return modified_priority[kind] or kind
end


local lsp_symbol = "✳"
local luasnip_symbol = "⇨"
local treesitter_symbol = ""
local buffer_symbol = "󰕸"
local tags_symbol = ""
local rg_symbol = ""
local path_symbol = ""
local tmux_symbol = ""
local codeium_symbol = "󰨞"

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
      { name = 'treesitter', icon = treesitter_symbol, group_index = 2, max_item_count = 4, keyword_length = 2 },
      { name = 'buffer',     icon = buffer_symbol,     group_index = 2, max_item_count = 3 },
      { name = 'rg',         icon = rg_symbol,         group_index = 2, max_item_count = 3 },
      { name = 'tags',       icon = tags_symbol,       group_index = 2, max_item_count = 2 },
      { name = 'path',       icon = path_symbol,       group_index = 2, max_item_count = 2 },
      { name = 'tmux',       icon = tmux_symbol,       group_index = 2, max_item_count = 3 },
      { name = 'codeium',    icon = codeium_symbol,    group_index = 1, max_item_count = 3 },
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
          codeium = "[CODEIUM]",
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
    -- preselect = cmp.PreselectMode.Item,
    preselect = cmp.PreselectMode.None,
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    sorting = {
      priority_weight = 2,
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        function(entry1, entry2) -- sort by length ignoring "=~"
          local len1 = string.len(string.gsub(entry1.completion_item.label, "[=~()_]", ""))
          local len2 = string.len(string.gsub(entry2.completion_item.label, "[=~()_]", ""))
          if len1 ~= len2 then
            return len1 - len2 < 0
          end
        end,
        cmp.config.compare.recently_used,
        cmp.config.compare.score,
        function(entry1, entry2) -- sort by compare kind (Variable, Function etc)
          local kind1 = modified_kind(entry1:get_kind())
          local kind2 = modified_kind(entry2:get_kind())
          if kind1 ~= kind2 then
            return kind1 - kind2 < 0
          end
        end,
        cmp.config.compare.order,
        -- require "cmp-under-comparator".under,
        function(entry1, entry2)
          local _, entry1_under = entry1.completion_item.label:find "^_+"
          local _, entry2_under = entry2.completion_item.label:find "^_+"
          entry1_under = entry1_under or 0
          entry2_under = entry2_under or 0
          if entry1_under > entry2_under then
            return false
          elseif entry1_under < entry2_under then
            return true
          end
        end,
        ---@diagnostic disable-next-line: assign-type-mismatch
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
      },
    },
    matching = {
      disallow_fuzzy_matching = true,
      disallow_fullfuzzy_matching = true,
      disallow_partial_fuzzy_matching = true,
      disallow_partial_matching = false,
      disallow_prefix_unmatching = true,
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
