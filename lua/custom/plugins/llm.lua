-- FIM configurations for known compatible base models
local fim_configs = {
  ['qwen2.5-coder'] = {
    fim = { enabled = true, prefix = '<|fim_prefix|>', middle = '<|fim_middle|>', suffix = '<|fim_suffix|>' },
    tokens_to_clear = { '<|endoftext|>', '<|fim_pad|>', '</s>' },
  },
  ['starcoder2'] = {
    fim = { enabled = true, prefix = '<fim_prefix>', middle = '<fim_middle>', suffix = '<fim_suffix>' },
    tokens_to_clear = { '<|endoftext|>' },
  },
  ['starcoder'] = {
    fim = { enabled = true, prefix = '<fim_prefix>', middle = '<fim_middle>', suffix = '<fim_suffix>' },
    tokens_to_clear = { '<|endoftext|>' },
  },
  ['codellama'] = {
    fim = { enabled = true, prefix = '<PRE> ', middle = ' <MID>', suffix = ' <SUF>' },
    tokens_to_clear = { '<EOT>' },
  },
  ['deepseek-coder'] = {
    fim = { enabled = true, prefix = '<｜fim▁begin｜>', middle = '<｜fim▁hole｜>', suffix = '<｜fim▁end｜>' },
    tokens_to_clear = { '<｜end▁of▁sentence｜>' },
  },
  ['codegemma'] = {
    fim = { enabled = true, prefix = '<|fim_prefix|>', middle = '<|fim_middle|>', suffix = '<|fim_suffix|>' },
    tokens_to_clear = { '<|file_separator|>', '<end_of_turn>' },
  },
  ['stable-code'] = {
    fim = { enabled = true, prefix = '<fim_prefix>', middle = '<fim_middle>', suffix = '<fim_suffix>' },
    tokens_to_clear = { '<|endoftext|>' },
  },
  ['codestral'] = {
    fim = { enabled = true, prefix = '[PREFIX]', middle = '[MIDDLE]', suffix = '[SUFFIX]' },
    tokens_to_clear = { '</s>' },
  },
  ['granite-code'] = {
    fim = { enabled = true, prefix = '<fim_prefix>', middle = '<fim_middle>', suffix = '<fim_suffix>' },
    tokens_to_clear = { '<|endoftext|>' },
  },
}

-- Patterns to identify FIM-compatible models
local fim_patterns = {
  'base', -- Generic base models (e.g., qwen2.5-coder:7b-base)
  'starcoder',
  'codellama',
  'codegemma',
  'deepseek%-coder', -- Escaped hyphen for pattern matching
  'stable%-code',
  'codestral',
  'granite%-code',
}

-- Patterns that indicate non-FIM models (instruct/chat tuned)
local non_fim_patterns = {
  'instruct',
  'chat',
  'it$', -- Common suffix for instruct models (e.g., codellama:7b-it)
}

local function is_fim_compatible(model_name)
  local name_lower = model_name:lower()

  -- Exclude instruct/chat variants first
  for _, pattern in ipairs(non_fim_patterns) do
    if name_lower:match(pattern) then
      return false
    end
  end

  -- Check if model matches known FIM patterns
  for _, pattern in ipairs(fim_patterns) do
    if name_lower:match(pattern) then
      return true
    end
  end
  return false
end

local function get_fim_config(model_name)
  local name_lower = model_name:lower()
  for pattern, config in pairs(fim_configs) do
    -- Use plain string find instead of pattern match (dots in model names)
    if name_lower:find(pattern, 1, true) then
      return config
    end
  end
  -- Default fallback (starcoder style)
  return {
    fim = { enabled = true, prefix = '<fim_prefix>', middle = '<fim_middle>', suffix = '<fim_suffix>' },
    tokens_to_clear = { '<|endoftext|>', '</s>' },
  }
end

-- Track current model for statusline
_G.llm_current_model = 'qwen2.5-coder:7b-base'

local function select_model()
  vim.fn.jobstart('curl -s http://localhost:11434/api/tags', {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data or not data[1] then
        vim.notify('Failed to fetch Ollama models', vim.log.levels.ERROR)
        return
      end

      local ok, json = pcall(vim.json.decode, table.concat(data, ''))
      if not ok or not json or not json.models then
        vim.notify('Failed to parse Ollama response', vim.log.levels.ERROR)
        return
      end

      -- Filter to FIM-compatible models only
      local models = {}
      for _, model in ipairs(json.models) do
        if is_fim_compatible(model.name) then
          table.insert(models, model.name)
        end
      end

      if #models == 0 then
        vim.notify('No FIM-compatible models found. Pull a base model like qwen2.5-coder:7b-base', vim.log.levels.WARN)
        return
      end

      vim.ui.select(models, { prompt = 'Select LLM Model:' }, function(choice)
        if not choice then
          return
        end

        local fim_config = get_fim_config(choice)
        local cfg = require('llm.config').config
        if cfg then
          cfg.model = choice
          cfg.fim = fim_config.fim
          cfg.tokens_to_clear = fim_config.tokens_to_clear
          _G.llm_current_model = choice
          vim.notify('LLM: ' .. choice)
        end
      end)
    end,
  })
end

return {
  'huggingface/llm.nvim',
  keys = {
    { '<leader>lm', select_model, desc = 'Select LLM model' },
    { '<leader>lt', '<cmd>LLMToggleAutoSuggest<cr>', desc = 'Toggle LLM auto-suggest' },
  },
  config = function()
    require('llm').setup {
      backend = 'ollama',
      model = 'qwen2.5-coder:7b-base',
      url = 'http://localhost:11434',
      request_body = {
        options = {
          temperature = 0.2,
          top_p = 0.95,
        },
      },
      fim = {
        enabled = true,
        prefix = '<|fim_prefix|>',
        middle = '<|fim_middle|>',
        suffix = '<|fim_suffix|>',
      },
      tokens_to_clear = { '<|endoftext|>', '<|fim_pad|>', '</s>' },
      accept_keymap = '<C-y>',
      dismiss_keymap = '<C-e>',
      lsp = {
        cmd_env = { LLM_LOG_LEVEL = 'DEBUG' },
      },
    }
  end,
}
