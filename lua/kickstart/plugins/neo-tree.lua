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
    auto_clean_after_session_restore = true,
    close_if_last_window = true,
    filesystem = {
      window = {
        width = 30,
        mappings = {
          ['h'] = 'close_node',
          ['l'] = 'open',
          ['oa'] = 'avante_add_files',
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
      commands = {
        avante_add_files = function(state)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local relative_path = require('avante.utils').relative_path(filepath)

          local sidebar = require('avante').get()

          local open = sidebar:is_open()
          -- ensure avante sidebar is open
          if not open then
            require('avante.api').ask()
            sidebar = require('avante').get()
          end

          sidebar.file_selector:add_selected_file(relative_path)

          -- remove neo tree buffer
          if not open then
            sidebar.file_selector:remove_selected_file 'neo-tree filesystem [1]'
          end
        end,
      },
    },
  },
}
