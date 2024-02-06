return {
  'deponian/nvim-base64',
  version = '*',
  keys = {
    { '<leader>d', '<Plug>(FromBase64)', desc = 'Decode base64', mode = 'x' },
    { '<leader>e', '<Plug>(ToBase64)', desc = 'Encode base64', mode = 'x' },
  },
  config = function()
    require('nvim-base64').setup()
  end,
}
