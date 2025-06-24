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
      behaviour = {
        auto_approve_tool_permissions = { 'run_go_tests', 'go_test_in_suite' },
      },
      custom_tools = {
        {
          name = 'go_test_in_suite',
          description = 'Run a single test within a Go suite and return summary and details',
          param = {
            type = 'table',
            fields = {
              {
                name = 'path',
                description = 'Path to the Go package to test (e.g. ./api)',
                type = 'string',
              },
              {
                name = 'suite_name',
                description = 'Name of the suite entrypoint function (e.g. TestAPI)',
                type = 'string',
              },
              {
                name = 'test',
                description = 'Specific test within the suite to run (e.g. TestCreateCollectionMemberStudentTravel)',
                type = 'string',
              },
              {
                name = 'flags',
                description = 'Extra flags for go test (default -v)',
                type = 'string',
                optional = true,
                default = '-v',
              },
            },
          },
          returns = {
            {
              name = 'summary',
              description = 'Summary of the test run (PASS/FAIL, time, etc.)',
              type = 'string',
            },
            {
              name = 'details',
              description = 'Full raw output of the test command',
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
            -- Construct the go test command to run a single test in a suite
            local path = params.path or '.'
            local suite_name = params.suite_name or ''
            local test = params.test or ''
            local flags = params.flags or '-v'

            if suite_name == '' or test == '' then
              return { summary = '', details = '', error = 'suite_name and test are required' }
            end

            local cmd = string.format("go test %s %s -run '^%s$' -testify.m %s", flags, path, suite_name, test)
            local output = vim.fn.system(cmd)

            -- Extract summary
            local summary = ''
            -- Look for overall PASS/FAIL, time, and possibly the test name
            if output:find('^FAIL', 1, true) or output:find('\nFAIL', 1, true) then
              local m = output:match 'FAIL%s+([%w%p_/]+)%s+(%d+%.?%d*)s'
              if m then
                summary = 'FAIL: ' .. m
              else
                summary = 'FAIL'
              end
            elseif output:find('^ok', 1, true) or output:find('\nok', 1, true) or output:find('PASS', 1, true) then
              local m = output:match 'ok%s+([%w%p_/]+)%s+(%d+%.?%d*)s'
              if m then
                summary = 'PASS: ' .. m
              else
                summary = 'PASS'
              end
            else
              summary = 'Test output could not be summarized.'
            end

            return { summary = summary, details = output, error = nil }
          end,
        },
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
        -- {
        --   name = 'go_test_suite',
        --   description = 'Run a specific Go test suite',
        --   param = {
        --     type = 'table',
        --     fields = {
        --       {
        --         name = 'flags',
        --         description = 'Additional flags to pass to the `go test` command (optional)',
        --         type = 'string',
        --         optional = true,
        --         default = '-v',
        --       },
        --       {
        --         name = 'path',
        --         description = 'Path to the Go package containing the test suite',
        --         type = 'string',
        --       },
        --       {
        --         name = 'suite_name',
        --         description = 'Name of the test suite to run',
        --         type = 'string',
        --       },
        --       {
        --         name = 'test',
        --         description = 'Specific test to run within the suite (optional)',
        --         type = 'string',
        --         optional = true,
        --       },
        --     },
        --   },
        --   returns = { -- Expected return values
        --     {
        --       name = 'result',
        --       description = 'Result of the fetch',
        --       type = 'string',
        --     },
        --     {
        --       name = 'error',
        --       description = 'Error message if the fetch was not successful',
        --       type = 'string',
        --       optional = true,
        --     },
        --   },
        --   func = function(params, on_log, on_complete) -- Custom function to execute
        --     local path = params.path or '.'
        --     local flags = params.flags or '-v'
        --     local test = params.test and (' -run ' .. params.test) or ''
        --     local cmd = string.format('go test %s %s -run "^%s$" -testify.m %s', flags, path, params.suite_name, test)
        --     local result = vim.fn.system(cmd)
        --     return result
        --   end,
        -- },
      },
      disabled_tools = {
        'git_commit',
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
      },
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
    'folke/snacks.nvim',
    'ravitemer/mcphub.nvim',
    -- 'stevearc/dressing.nvim',
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
