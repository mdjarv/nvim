return {
  -- {
  --   'Davidyz/VectorCode',
  --   version = '*', -- optional, depending on whether you're on nightly or release
  --   dependencies = { 'nvim-lua/plenary.nvim' },
  --   cmd = 'VectorCode', -- if you're lazy-loading VectorCode
  -- },
  {
    'olimorris/codecompanion.nvim',
    enabled = true,
    init = function()
      -- require('custom.plugins.codecompanion.fidget-spinner'):init()
    end,
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      -- 'Davidyz/VectorCode',
      'ravitemer/mcphub.nvim',
    },
    keys = {
      { '<leader>cc', '<cmd>CodeCompanionActions<cr>', mode = { 'n', 'x' }, desc = '[C]ode [C]ompanion' },
    },
    opts = {
      display = {
        action_palette = {
          width = 95,
          height = 10,
          prompt = 'Prompt ', -- Prompt used for interactive LLM calls
          provider = 'default', -- Can be "default", "telescope", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
          opts = {
            show_default_actions = true, -- Show the default actions in the action palette?
            show_default_prompt_library = true, -- Show the default prompt library in the action palette?
          },
        },
      },
      extensions = {
        -- vectorcode = {
        --   opts = {
        --     add_tool = true,
        --     add_slash_command = true,
        --     tool_opts = {},
        --   },
        -- },
        mcphub = {
          callback = 'mcphub.extensions.codecompanion',
          opts = {
            show_result_in_chat = true,
            make_vars = true,
            make_slash_commands = true,
          },
        },
      },
      strategies = {
        chat = {
          adapter = 'copilot',
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
      adapters = {
        copilot = function()
          return require('codecompanion.adapters').extend('copilot', {
            schema = {
              model = {
                default = 'gpt-4.1',
              },
            },
          })
        end,
      },
    },
  },
}
