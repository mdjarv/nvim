return {
  {
    'milanglacier/minuet-ai.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('minuet').setup {
        provider = 'openai_fim_compatible',
        n_completions = 1,
        context_window = 4096,
        request_timeout = 5,
        throttle = 1500,
        debounce = 500,
        provider_options = {
          openai_fim_compatible = {
            api_key = 'TERM',
            name = 'Ollama',
            end_point = 'http://localhost:11434/v1/completions',
            model = 'qwen2.5-coder:7b-base',
            optional = {
              max_tokens = 128,
              top_p = 0.9,
            },
          },
        },
      }
    end,
  },
}
