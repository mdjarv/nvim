vim.api.nvim_set_hl(0, 'BlinkCmpKindOllama', { fg = '#a6e3a1' })

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
    appearance = {
      nerd_font_variant = 'mono',
      kind_icons = {
        Ollama = '󰳆',
      },
    },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      trigger = { prefetch_on_insert = false },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'minuet', '99' },
      providers = {
        minuet = {
          name = 'minuet',
          module = 'minuet.blink',
          async = true,
          timeout_ms = 5000,
          score_offset = 50,
        },
        ['99'] = {
          name = '99',
          module = 'blink.compat.source',
        },
      },
    },
    signature = { enabled = true },
  },
}
