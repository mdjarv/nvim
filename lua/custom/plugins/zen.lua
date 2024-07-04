return {
  'folke/zen-mode.nvim',
  keys = {
    { '<leader>z', '<cmd>ZenMode<cr>', desc = 'Zen mode' },
  },
  config = function()
    require('zen-mode').setup {
      window = {
        backdrop = 0.7,
        width = 0.8,
        height = 1,
        options = {
          -- signcolumn = 'no',
          -- list = false,
          -- foldcolumn = '0',
        },
      },
    }
  end,
}
