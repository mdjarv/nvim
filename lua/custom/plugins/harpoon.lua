return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {
      '<leader>m',
      function()
        require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
      end,
      desc = 'Harpoon menu',
    },
    {
      '<C-1>',
      function()
        require('harpoon'):list():select(1)
      end,
    },
    {
      '<C-2>',
      function()
        require('harpoon'):list():select(2)
      end,
    },
    {
      '<C-3>',
      function()
        require('harpoon'):list():select(3)
      end,
    },
    {
      '<C-4>',
      function()
        require('harpoon'):list():select(4)
      end,
    },
    {
      '<leader>ma',
      function()
        require('harpoon'):list():add()
      end,
      desc = 'Add to Harpoon',
    },
  },
  opts = {
    settings = {
      save_on_toggle = true,
      sync_on_ui_close = true,
    },
  },
}
