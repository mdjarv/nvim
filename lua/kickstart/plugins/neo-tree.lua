-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>e', ':Neotree toggle<CR>', { desc = 'NeoTree toggle' } },
  },
  opts = {
    close_if_last_window = true,
    filesystem = {
      window = {
        width = 30,
        mappings = {
          ['h'] = 'close_node',
          ['l'] = 'open',
        },
      },
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      filtered_items = {
        always_show = {
          '.github',
          '.env',
          '.gitignore',
          '.dockerignore',
        },
      },
    },
  },
}
