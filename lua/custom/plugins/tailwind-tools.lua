return {
  'roobert/tailwindcss-colorizer-cmp.nvim',
  event = 'LspAttach',
  opts = {
    color_square_width = 2,
  },
  config = function(_, opts)
    require('tailwindcss-colorizer-cmp').setup(opts)

    -- Add to nvim-cmp formatting
    local cmp = require 'cmp'
    local cmp_config = cmp.get_config()
    local format = cmp_config.formatting.format

    cmp.setup {
      formatting = {
        format = function(entry, vim_item)
          vim_item = format(entry, vim_item)
          return require('tailwindcss-colorizer-cmp').formatter(entry, vim_item)
        end,
      },
    }
  end,
}
