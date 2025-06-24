return {
  'pwntester/octo.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    -- 'nvim-telescope/telescope.nvim',
    'folke/snacks.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('octo').setup { picker = 'snacks' }
  end,
  keys = {
    { '<leader>gp', '<cmd>Octo pr list<cr>', desc = 'GitHub Pull Requests' },
    -- { '<leader>gP', '<cmd>Octo pr create<cr>', desc = 'Create GitHub Pull Request' },
    { '<leader>gl', '<cmd>Octo pr checkout<cr>', desc = 'Checkout PR' },
  },
}
