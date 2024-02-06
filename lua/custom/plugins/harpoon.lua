return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup {
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    }

    require('which-key').register {
      ['<leader>h'] = { name = '[H]arpoon', _ = 'which_key_ignore' },
    }

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():append()
    end, { desc = '[A]ppend file' })
    vim.keymap.set('n', '<leader>hh', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Open [H]arpoon' })

    for i = 1, 4 do
      vim.keymap.set('n', '<M-' .. i .. '>', function()
        harpoon:list():select(i)
      end, {
        desc = 'Navigate to [' .. i .. ']',
      })
      vim.keymap.set('n', '<leader>h' .. i, function()
        harpoon:list():select(i)
      end, { desc = 'Navigate to [' .. i .. ']' })
    end
  end,
}
