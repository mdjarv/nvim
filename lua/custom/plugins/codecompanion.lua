return {
  -- {
  --   'Davidyz/VectorCode',
  --   version = '*', -- optional, depending on whether you're on nightly or release
  --   dependencies = { 'nvim-lua/plenary.nvim' },
  --   -- cmd = 'VectorCode', -- if you're lazy-loading VectorCode
  -- },
  {
    'olimorris/codecompanion.nvim',
    enabled = false,
    init = function()
      require('custom.plugins.codecompanion.fidget-spinner'):init()
    end,
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'Davidyz/VectorCode',
    },
    keys = {
      { '<leader>cc', '<cmd>CodeCompanionActions<cr>', mode = { 'n', 'x' }, desc = '[C]ode [C]ompanion' },
    },
    opts = {
      copilot = function()
        return require('codecompanion.adapters').extend('copilot', {
          schema = {
            model = {
              default = 'claude-3.7-sonnet',
            },
          },
        })
      end,
      strategies = {
        chat = {
          tools = {
            -- vectorcode = {
            --   description = 'Run VectorCode to retrieve the project context.',
            --   callback = function()
            --     local vectorcode = require 'vectorcode.integrations'
            --     return vectorcode.codecompanion.chat.make_tool {}
            --   end,
            -- },
          },
        },
      },
    },
  },
}
