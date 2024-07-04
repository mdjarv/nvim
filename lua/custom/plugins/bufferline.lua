return {
  'akinsho/bufferline.nvim',
  version = '*',
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<S-h>', ':BufferLineCyclePrev<cr>', desc = 'Previous tab' },
    { '<S-l>', ':BufferLineCycleNext<cr>', desc = 'Next tab' },

    { '<leader>co', ':BufferLineCloseOthers<cr>', desc = 'Close others' },
    { '<leader>ch', ':BufferLineCloseLeft<cr>', desc = 'Close left' },
    { '<leader>cl', ':BufferLineCloseRight<cr>', desc = 'Close right' },
  },
  config = function()
    require('bufferline').setup {
      options = {
        separator_style = 'slant',
        always_show_bufferline = true,
      },
      highlights = {},
    }
  end,
}
