return {
  'nvim-pack/nvim-spectre',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = 'Spectre',
  keys = {
    { '<leader>sr', '<cmd>Spectre<cr>', desc = 'Search and Replace (Spectre)' },
    {
      '<leader>sR',
      function()
        require('spectre').open_file_search { select_word = true }
      end,
      desc = 'Search word in file (Spectre)',
    },
  },
  opts = {
    open_cmd = 'noswapfile vnew',
  },
}
