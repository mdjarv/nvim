return {
  {
    'zbirenbaum/copilot.lua',
    dependencies = { 'nvim-lualine/lualine.nvim' },
    cmd = 'Copilot',
    event = 'InsertEnter',
    build = ':Copilot auth',
    config = function()
      local copilot = require 'copilot'
      copilot.setup {
        suggestion = { enabled = true },
        panel = { enabled = false },
        filetypes = { ['*'] = true },
      }
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    dependencies = { 'zbirenbaum/copilot.lua' },
    config = function()
      require('copilot_cmp').setup()
      vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })
    end,
  },
  {
    'jonahgoldwastaken/copilot-status.nvim',
    dependencies = { 'zbirenbaum/copilot.lua' },
    lazy = true,
    event = 'BufReadPost',
    config = function()
      require('copilot_status').setup()

      require('lualine').setup {
        sections = {
          lualine_x = {
            function()
              return require('copilot_status').status_string()
            end,
            'filetype',
          },
        },
      }
    end,
  },
  -- {
  --   'zbirenbaum/copilot.lua',
  --   cmd = 'Copilot',
  --   build = ':Copilot auth',
  --   opts = {
  --     suggestion = { enabled = false },
  --     panel = { enabled = false },
  --     filetypes = {
  --       markdown = true,
  --       help = true,
  --     },
  --   },
  -- },
}
