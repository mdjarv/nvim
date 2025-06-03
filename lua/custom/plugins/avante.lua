return {
  'yetone/avante.nvim',
  enabled = true,
  event = 'VeryLazy',
  version = false,
  config = function()
    require('avante').setup {
      debug = false,
      -- provider = 'copilot-gpt-4.1',
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

        -- ['claude-opus'] = { hide_in_model_selector = true },
        -- ['claude-haiku'] = { hide_in_model_selector = true },
        -- bedrock = { hide_in_model_selector = true },
        -- gemini = { hide_in_model_selector = true },
        -- cohere = { hide_in_model_selector = true },
        -- aihubmix = { hide_in_model_selector = true },
        -- ['aihubmix-claude'] = { hide_in_model_selector = true },
        -- ['bedrock-claude-3.7-sonnet'] = { hide_in_model_selector = true },
      },
      system_prompt = function()
        local hub = require('mcphub').get_hub_instance()
        local prompt = hub and hub:get_active_servers_prompt() or ''
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
