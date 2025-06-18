---@diagnostic disable: missing-fields
return {
  'yetone/avante.nvim',
  enabled = true,
  event = 'VeryLazy',
  version = false,
  config = function()
    require('avante').setup {
      debug = false,
      provider = 'copilot',
      auto_suggestions = false,
      auto_suggestions_provider = 'copilot',
      providers = {
        copilot = {
          model = 'gpt-4.1',
          hide_in_model_selector = false,
        },
        ollama = { hide_in_model_selector = true },
        azure = { hide_in_model_selector = true },
        claude = { hide_in_model_selector = true },
        openai = { hide_in_model_selector = true },
        ['openai-gpt-4o-mini'] = { hide_in_model_selector = true },
        vertex = { hide_in_model_selector = true },
        vertex_claude = { hide_in_model_selector = true },
      },
      -- system_prompt = function()
      --   local hub = require('mcphub').get_hub_instance()
      --   local prompt = hub and hub:get_active_servers_prompt() or ''
      --   return prompt
      -- end,
      -- custom_tools = function()
      --   return {
      --     require('mcphub.extensions.avante').mcp_tool(),
      --   }
      -- end,
      custom_tools = {
        {
          name = 'run_go_tests', -- Unique name for the tool
          description = 'Run Go unit tests and return results', -- Description shown to AI
          command = 'go test -v ./...', -- Shell command to execute
          param = { -- Input parameters (optional)
            type = 'table',
            fields = {
              {
                name = 'target',
                description = "Package or directory to test (e.g. './pkg/...' or './internal/pkg')",
                type = 'string',
                optional = true,
              },
            },
          },
          returns = { -- Expected return values
            {
              name = 'result',
              description = 'Result of the fetch',
              type = 'string',
            },
            {
              name = 'error',
              description = 'Error message if the fetch was not successful',
              type = 'string',
              optional = true,
            },
          },
          func = function(params, on_log, on_complete) -- Custom function to execute
            local target = params.target or './...'
            return vim.fn.system(string.format('go test -v %s', target))
          end,
        },
        {
          name = 'run_make_target',
          description = 'Run a Makefile target in the current project',
          command = 'make [target]',
          param = {
            type = 'table',
            fields = {
              {
                name = 'target',
                description = "Name of the Makefile target to run (e.g. 'build', 'test')",
                type = 'string',
                optional = false,
              },
              {
                name = 'args',
                description = 'Additional arguments to pass to make (optional)',
                type = 'string',
                optional = true,
              },
            },
          },
          returns = {
            {
              name = 'result',
              description = 'Output of the make command',
              type = 'string',
            },
            {
              name = 'error',
              description = 'Error message if the command failed',
              type = 'string',
              optional = true,
            },
          },
          func = function(params, on_log, on_complete)
            local target = params.target or ''
            local args = params.args or ''
            local cmd = string.format('make %s %s', target, args)
            return vim.fn.system(cmd)
          end,
        },
      },
      -- disabled_tools = {
      --   'list_files',
      --   'search_files',
      --   'read_file',
      --   'create_file',
      --   'rename_file',
      --   'delete_file',
      --   'create_dir',
      --   'rename_dir',
      --   'delete_dir',
      --   'bash',
      -- },
      --   windows = {
      --     position = 'right',
      --     wrap = true,
      --     width = 40,
      --     sidebar_header = {
      --       enabled = true,
      --       align = 'left',
      --       rounded = false,
      --     },
      --     input = {
      --       rounded = true,
      --       prefix = '󰭹 ',
      --       height = 8,
      --     },
      --     edit = {
      --       border = 'rounded',
      --       start_insert = true,
      --     },
      --     ask = {
      --       floating = false,
      --       start_insert = true,
      --       border = 'rounded',
      --       focus_on_apply = 'ours',
      --     },
      --   },
      --   highlights = {
      --     diff = {
      --       current = 'DiffText',
      --       incoming = 'DiffAdd',
      --     },
      --   },
      --   diff = {
      --     autojump = true,
      --     list_opener = 'copen',
      --     override_timeoutlen = 500,
      --   },
    }
  end,
  build = 'make',
  dependencies = {
    'ravitemer/mcphub.nvim',
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'hrsh7th/nvim-cmp',
    'nvim-tree/nvim-web-devicons',
    {
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}
