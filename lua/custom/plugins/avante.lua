local function AvanteUpdate()
  local url = 'https://api.githubcopilot.com/models'
  local local_json_path = vim.fn.stdpath 'config' .. '/lua/custom/plugins/ai/copilot-models.json'
  local token = vim.env.GITHUB_COPILOT_TOKEN
  if token and token ~= '' then
    -- Use the environment variable if set
  else
    -- Try to read from $HOME/.config/github-copilot/apps.json
    local copilot_config_path = vim.fn.expand '$HOME/.config/github-copilot/apps.json'
    if vim.fn.filereadable(copilot_config_path) ~= 1 then
      vim.notify('[Avante] GITHUB_COPILOT_TOKEN environment variable is not set and apps.json not found. Cannot fetch models.', vim.log.levels.ERROR)
      return
    end
    local lines = vim.fn.readfile(copilot_config_path)
    if not lines or #lines == 0 then
      vim.notify('[Avante] apps.json is empty. Cannot fetch models.', vim.log.levels.ERROR)
      return
    end
    local json_content = table.concat(lines, '\n')
    vim.notify('[Avante] Content: ' .. json_content, vim.log.levels.DEBUG)
    local ok, parsed = pcall(vim.fn.json_decode, json_content)
    if not ok or not parsed or type(parsed) ~= 'table' or vim.tbl_isempty(parsed) then
      vim.notify('[Avante] Failed to parse apps.json. Cannot fetch models.', vim.log.levels.ERROR)
      return
    end
    -- Use the first oauth_token found in the object
    for _, v in pairs(parsed) do
      if v and v.oauth_token and v.oauth_token ~= '' then
        token = v.oauth_token
        break
      end
    end
    if not token or token == '' then
      vim.notify('[Avante] No oauth_token found in apps.json. Cannot fetch models.', vim.log.levels.ERROR)
      return
    end
  end

  local status, response = pcall(vim.fn.system, {
    'curl',
    '-f',
    '-s',
    '-H',
    'Authorization: Bearer ' .. token,
    '-o',
    local_json_path,
    url,
  })

  if not status or vim.v.shell_error ~= 0 then
    vim.notify('[Avante] Failed to download copilot-models.json: ' .. (response or 'Unknown error'), vim.log.levels.ERROR)
    return
  end

  vim.notify('[Avante] Successfully updated copilot-models.json', vim.log.levels.INFO)
  vim.cmd 'redraw!' -- Redraw Neovim to reflect potential changes
end

-- Function to load Copilot model names and properties from a local JSON file
local function load_copilot_models(json_path)
  local dynamic_model_data = {}
  local default_fallback_models = {
    { name = 'claude-3.5-sonnet' },
    { name = 'gemini-2.0-flash' },
    { name = 'gemini-2.0-pro' },
    { name = 'gpt-4.1' },
    { name = 'gpt-4o' },
    { name = 'gpt-4o-copilot' },
    { name = 'gpt-4o-mini' },
  }

  local json_content_lines = vim.fn.readfile(json_path)

  if not json_content_lines or #json_content_lines == 0 then
    vim.notify('[Avante] Failed to read local copilot-models.json. File might not exist or is empty. Using fallback models.', vim.log.levels.ERROR)
    return default_fallback_models
  end

  local json_content = table.concat(json_content_lines, '\n')

  local status, parsed_json = pcall(vim.fn.json_decode, json_content)

  if not status then
    vim.notify('[Avante] Failed to parse local copilot-models.json: ' .. parsed_json .. '. Using fallback models.', vim.log.levels.ERROR)
    return default_fallback_models
  end

  local model_data = parsed_json

  if not model_data or type(model_data.data) ~= 'table' then
    vim.notify('[Avante] Local Copilot JSON structure unexpected. Missing or invalid "data" key. Using fallback models.', vim.log.levels.WARN)
    return default_fallback_models
  end

  for _, model_entry_data in pairs(model_data.data) do
    ---@type AvanteProvider
    local model_entry = {
      __inherited_from = 'copilot',
      model = model_entry_data.id,
      max_tokens = (model_entry_data.capabilities and model_entry_data.capabilities.limits and model_entry_data.capabilities.limits.max_context_window_tokens)
        or nil,
      disable_tools = (
        model_entry_data.capabilities
        and model_entry_data.capabilities.supports
        and model_entry_data.capabilities.supports.tool_calls ~= nil
        and not model_entry_data.capabilities.supports.tool_calls
      ) or nil,
      display_name = model_entry_data.name and (model_entry_data.name .. ' (' .. model_entry_data.id .. ')') or model_entry_data.id,
    }

    table.insert(dynamic_model_data, model_entry)
  end

  if #dynamic_model_data == 0 then
    vim.notify('[Avante] No models found in local Copilot JSON. Using fallback models.', vim.log.levels.WARN)
    return default_fallback_models
  end

  vim.notify('[Avante] Successfully loaded ' .. #dynamic_model_data .. ' models from local Copilot JSON.', vim.log.levels.INFO)
  return dynamic_model_data
end

return {
  'yetone/avante.nvim',
  enabled = true,
  event = 'VeryLazy',
  version = false,
  config = function()
    local local_json_path = vim.fn.stdpath 'config' .. '/lua/custom/plugins/ai/copilot-models.json'
    local model_data = load_copilot_models(local_json_path)

    local vendors = {}
    for _, model_entry in ipairs(model_data) do
      vendors['copilot-' .. model_entry.model] = model_entry
    end

    vim.api.nvim_create_user_command('AvanteUpdate', AvanteUpdate, {
      desc = 'Download and update copilot-models.json for Avante.nvim',
      bang = true,
    })

    require('avante').setup {
      provider = 'copilot-gpt-4.1',
      auto_suggestions_provider = 'copilot',
      copilot = {
        -- model = 'gpt-4.1',
        hide_in_model_selector = true,
      },
      azure = {
        hide_in_model_selector = true,
      },
      claude = {
        hide_in_model_selector = true,
      },
      ['claude-opus'] = {
        hide_in_model_selector = true,
      },
      ['claude-haiku'] = {
        hide_in_model_selector = true,
      },
      bedrock = {
        hide_in_model_selector = true,
      },
      openai = {
        hide_in_model_selector = true,
      },
      ['openai-gpt-4o-mini'] = {
        hide_in_model_selector = true,
      },
      gemini = {
        hide_in_model_selector = true,
      },
      vertex = {
        hide_in_model_selector = true,
      },
      cohere = {
        hide_in_model_selector = true,
      },
      ollama = {
        hide_in_model_selector = true,
      },
      vertex_claude = {
        hide_in_model_selector = true,
      },
      aihubmix = {
        hide_in_model_selector = true,
      },
      ['aihubmix-claude'] = {
        hide_in_model_selector = true,
      },
      ['bedrock-claude-3.7-sonnet'] = {
        hide_in_model_selector = true,
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
