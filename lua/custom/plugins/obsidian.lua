return {
  'epwalsh/obsidian.nvim',
  version = '*',
  lazy = false,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  -- opts = {
  -- 	workspaces = {
  -- 		{
  -- 			name = 'obsidian',
  -- 			path = '~/Documents/Obsidian'
  -- 		},
  -- 	},
  -- },
  config = function()
    local obsidian = require 'obsidian'

    require('which-key').register {
      ['<leader>o'] = { name = '[O]bsidian', _ = 'which_key_ignore' },
    }

    obsidian.setup {
      workspaces = {
        {
          name = 'obsidian',
          path = '~/Documents/Obsidian',
        },
      },
      follow_url_func = function(url)
        vim.fn.jobstart { 'xdg-open', url }
      end,
    }

    vim.keymap.set('n', '<leader>ot', function()
      obsidian.util.toggle_checkbox()
    end, { desc = '[T]oggle checkbox' })
    vim.keymap.set('n', '<leader>oo', '<cmd>ObsidianQuickSwitch<cr>', { desc = 'Quick Switch' })
    vim.keymap.set('n', '<leader>od', '<cmd>ObsidianToday<cr>', { desc = 'To[d]ay' })
    vim.keymap.set('n', '<leader>ob', '<cmd>ObsidianBacklinks<cr>', { desc = '[B]acklinks' })
    vim.keymap.set('n', '<leader>op', '<cmd>ObsidianPasteImg<cr>', { desc = '[P]aste Image' })
  end,
}
