return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {
      '<leader>h',
      function()
        require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
      end,
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
      '<C-S-a>',
      function()
        require('harpoon'):list():add()
      end,
    },
  },
  opts = {
    settings = {
      save_on_toggle = true,
      sync_on_ui_close = true,
    },
  },
}
