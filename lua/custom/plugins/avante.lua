---@diagnostic disable: missing-fields
return {
  'yetone/avante.nvim',
  enabled = true,
  build = 'make',
  event = 'VeryLazy',
  version = false,
  opts = {
    debug = false,
    provider = 'copilot',
    -- provider = 'openrouter',
    providers = {
      openrouter = {
        __inherited_from = 'openai',
        endpoint = 'https://openrouter.ai/api/v1',
        api_key_name = 'OPENROUTER_API_KEY',
        -- model = 'x-ai/grok-4',
        model = 'anthropic/claude-sonnet-4',
        -- model = 'anthropic/claude-opus-4',
        -- model = 'openai/gpt-5-mini',
      },
      morph = {
        model = 'morph-v3-fast',
      },
    },
    behaviour = {
      enable_fastapply = true,
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
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'folke/snacks.nvim',
    -- 'ravitemer/mcphub.nvim',
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
