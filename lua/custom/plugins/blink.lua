return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    { 'L3MON4D3/LuaSnip', version = '2.*' },
  },
  opts = {
    keymap = {
      preset = 'default',
      ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
    },
    appearance = { nerd_font_variant = 'mono' },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets' },
    },
    signature = { enabled = true },
  },
}
