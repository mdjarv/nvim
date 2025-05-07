local model_names = {
  -- 'claude-1.3',
  -- 'claude-1.3-100k',
  -- 'claude-2.0',
  -- 'claude-2.1',
  'claude-3.5-sonnet',
  'claude-3.7-sonnet',
  'claude-3.7-sonnet-thought',
  -- 'claude-3-sonnet-20240229',
  -- 'claude-instant-1.1',
  -- 'claude-instant-1.1-100k',
  -- 'claude-instant-1.2',
  'gemini-2.0-flash',
  -- 'gemini-2.0-flash-001',
  'gemini-2.0-pro',
  -- 'gemini-2.0-pro-exp-02-05',
  -- 'gpt-3.5-turbo',
  -- 'gpt-4',
  'gpt-4.1',
  -- 'gpt-4.5',
  'gpt-4o',
  'gpt-4o-copilot',
  -- 'gpt-4o-instant-apply-full-ft',
  -- 'gpt-4o-instant-apply-full-ft-ppe-a',
  'gpt-4o-mini',
  -- 'gpt-4-turbo',
}

return {
  'yetone/avante.nvim',
  enabled = true,
  event = 'VeryLazy',
  version = false, -- Using latest version to get the most recent fixes
  config = function()
    local vendors = {}
    for _, model in ipairs(model_names) do
      vendors['copilot-' .. model] = {
        __inherited_from = 'copilot',
        model = model,
      }
    end

    require('avante').setup {
      provider = 'copilot',

      -- temperature = 0.1, -- Slight increase for more creative responses
      -- top_p = 0.95, -- Add top_p for better response quality
      -- top_k = 50, -- Add top_k for better response filtering
      -- max_tokens = 4096,
      -- timeout = 60000, -- Increase timeout for complex queries
      auto_suggestions_provider = 'copilot',
      copilot = {
        model = 'gpt-4.1',
        -- temperature = 0.1,
      },
      -- Token counting configuration (helps track token usage)
      token_counting = {
        enabled = true, -- Enable token counting for cost awareness
        show_in_status_line = true, -- Don't show in status line to keep it clean
      },
      system_prompt = function()
        local hub = require('mcphub').get_hub_instance()
        local prompt = hub and hub:get_active_servers_prompt() or ''
        -- vim.notify('[Avante] mcphub active servers prompt: ' .. prompt, vim.log.levels.DEBUG)
        return prompt
      end,
      custom_tools = function()
        return {
          require('mcphub.extensions.avante').mcp_tool(),
        }
      end,
      disabled_tools = {
        'list_files',
        'search_files',
        'read_file',
        'create_file',
        'rename_file',
        'delete_file',
        'create_dir',
        'rename_dir',
        'delete_dir',
        'bash',
      },
      windows = {
        position = 'right',
        wrap = true,
        width = 40,
        sidebar_header = {
          enabled = true,
          align = 'left',
          rounded = false,
        },
        input = {
          rounded = true,
          prefix = '󰭹 ',
          height = 8,
        },
        edit = {
          border = 'rounded',
          start_insert = true,
        },
        ask = {
          floating = false,
          start_insert = true,
          border = 'rounded',
          focus_on_apply = 'ours',
        },
      },
      highlights = {
        diff = {
          current = 'DiffText',
          incoming = 'DiffAdd',
        },
      },
      diff = {
        autojump = true,
        list_opener = 'copen',
        override_timeoutlen = 500,
      },
      vendors = vendors,
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
