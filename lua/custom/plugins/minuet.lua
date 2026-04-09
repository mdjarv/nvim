return {
  {
    'milanglacier/minuet-ai.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local model = 'qwen2.5-coder:14b-base'
      _G.llm_current_model = model

      require('minuet').setup {
        provider = 'openai_fim_compatible',
        n_completions = 1,
        context_window = 8192,
        request_timeout = 8,
        throttle = 1000,
        debounce = 400,
        provider_options = {
          openai_fim_compatible = {
            api_key = 'TERM',
            name = 'Ollama',
            end_point = 'http://localhost:11434/v1/completions',
            model = model,
            optional = {
              max_tokens = 256,
              top_p = 0.9,
              keep_alive = '30m',
            },
          },
        },
      }
    end,
  },
}
