return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  event = { 'LspAttach' },

  version = '1.*',
  opts = {
    keymap = {
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-space>'] = { 'show' },
      ['<CR>'] = { 'accept' },
      ['<C-d>'] = { 'hide' },
      -- ['<Tab>'] = { 'snippet_forward' },
      -- ['<S-Tab>'] = { 'snippet_backword' },
    },
    appearance = {
      nerd_font_variant = 'mono'
    },
    completion = { documentation = { auto_show = true } },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev', 'ripgrip' },
      providers = {
        ripgrip = { module = "blink-ripgrep" },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },

      }
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true }
  },
  opts_extend = { "sources.default" }
}
