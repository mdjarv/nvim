return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'fredrikaverpil/neotest-golang',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-golang',
      },
    }

    require('which-key').add {
      { '<leader>T', group = 'Test' },
    }
  end,
  keys = {
    {
      '<leader>Tw',
      function()
        require('neotest').watch.toggle()
      end,
      desc = 'Toggle test watcher',
    },
    {
      '<leader>Ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = 'Toggle test summary',
    },
  },
}
