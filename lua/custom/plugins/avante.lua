local function AvanteUpdate()
  local url = 'https://main.vscode-cdn.net/extensions/copilotChat.json'
  local local_json_path = vim.fn.stdpath 'config' .. '/lua/custom/plugins/ai/copilot-models.json'

  local status, response = pcall(vim.fn.system, { 'curl', '-f', '-s', '-o', local_json_path, url })

  if not status or vim.v.shell_error ~= 0 then
    vim.notify('[Avante] Failed to download copilot-models.json: ' .. (response or 'Unknown error'), vim.log.levels.ERROR)
    return
  end

  vim.notify('[Avante] Successfully updated copilot-models.json', vim.log.levels.INFO)
  vim.cmd 'redraw!' -- Redraw Neovim to reflect potential changes
end

-- Function to load Copilot model names from a local JSON file
-- Defined at the top-level, before the main plugin return table
local function load_copilot_models(json_path)
  local dynamic_model_names = {}
  local default_fallback_models = {
    'claude-3.5-sonnet',
    'gemini-2.0-flash',
    'gemini-2.0-pro',
    'gpt-4.1',
    'gpt-4o',
    'gpt-4o-copilot',
    'gpt-4o-mini',
  }

  -- Read the local JSON file
  local json_content_lines = vim.fn.readfile(json_path)

  -- Guard clause: If file content is empty or nil, use fallback and return
  if not json_content_lines or #json_content_lines == 0 then
    vim.notify('[Avante] Failed to read local copilot-models.json. File might not exist or is empty. Using fallback models.', vim.log.levels.ERROR)
    return default_fallback_models
  end

  local json_content = table.concat(json_content_lines, '\n')

  -- Attempt to parse the JSON content
  -- local status, parsed_json = pcall(plenary_json.decode, json_content)
  local status, parsed_json = pcall(vim.fn.json_decode, json_content)

  -- Guard clause: If JSON parsing fails, use fallback and return
  if not status then
    vim.notify('[Avante] Failed to parse local copilot-models.json: ' .. parsed_json .. '. Using fallback models.', vim.log.levels.ERROR)
    return default_fallback_models
  end

  local model_data = parsed_json

  -- Guard clause: If 'modelInfo' key is missing or not a table, use fallback and return
  if not model_data or type(model_data.modelInfo) ~= 'table' then
    vim.notify('[Avante] Local Copilot JSON structure unexpected. Missing or invalid "modelInfo" key. Using fallback models.', vim.log.levels.WARN)
    return default_fallback_models
  end

  -- Extract model names
  for _, vendor_models in pairs(model_data.modelInfo) do
    for model_name, _ in pairs(vendor_models) do
      table.insert(dynamic_model_names, model_name)
    end
  end

  -- Guard clause: If no models were extracted, use fallback and return
  if #dynamic_model_names == 0 then
    vim.notify('[Avante] No models found in local Copilot JSON. Using fallback models.', vim.log.levels.WARN)
    return default_fallback_models
  end

  vim.notify('[Avante] Successfully loaded ' .. #dynamic_model_names .. ' models from local Copilot JSON.', vim.log.levels.INFO)
  return dynamic_model_names
end

return {
  'yetone/avante.nvim',
  enabled = true,
  event = 'VeryLazy',
  version = false, -- Using latest version to get the most recent fixes
  config = function()
    local local_json_path = vim.fn.stdpath 'config' .. '/lua/custom/plugins/ai/copilot-models.json'
    local model_names = load_copilot_models(local_json_path)

    -- Populate the 'vendors' table using the obtained model names
    local vendors = {}
    for _, model in ipairs(model_names) do
      vendors['copilot-' .. model] = {
        __inherited_from = 'copilot',
        model = model,
      }
    end

    -- Define the user command :AvanteUpdate
    vim.api.nvim_create_user_command('AvanteUpdate', AvanteUpdate, {
      desc = 'Download and update copilot-models.json for Avante.nvim',
      bang = true, -- Allows :AvanteUpdate! for forceful execution if needed (though not strictly used by the function itself)
    })

    require('avante').setup {
      provider = 'copilot',

      auto_suggestions_provider = 'copilot',

      -- Default model for the provider
      copilot = {
        model = 'gpt-4.1',
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
