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
        themeable = true,
        diagnostics = 'nvim_lsp',
        -- separator_style = 'slant',
        always_show_bufferline = true,
        separator_style = 'thick',
        indicator = {
          -- icon = '>',
          style = 'underline',
        },
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match 'error' and ' ' or ' '
          return ' ' .. icon .. count
        end,
      },
      highlights = {},
    }
  end,
}
