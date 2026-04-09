return {
  'nvim-pack/nvim-spectre',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = 'Spectre',
  keys = {
    { '<leader>sr', '<cmd>Spectre<cr>', desc = 'Search and Replace (Spectre)' },
  },
  opts = {
    open_cmd = 'noswapfile vnew',
  },
}
