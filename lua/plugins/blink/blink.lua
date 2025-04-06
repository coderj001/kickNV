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
      ['<C-l>'] = { 'accept' },
      ['<C-d>'] = { 'hide' },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },
    completion = { documentation = { auto_show = true } },
    signature = { enabled = true }
  },
}
