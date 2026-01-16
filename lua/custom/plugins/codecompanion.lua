return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'ravitemer/mcphub.nvim',
    },
    keys = {
      { '<leader>ak', '<cmd>CodeCompanionActions<cr>', mode = { 'n', 'v' }, desc = 'CodeCompanion Actions' },
      { '<leader>aa', '<cmd>CodeCompanionChat Toggle<cr>', mode = { 'n', 'v' }, desc = 'CodeCompanion Chat' },
      { 'ga', '<cmd>CodeCompanionChat Add<cr>', mode = 'v', desc = 'Add to CodeCompanion' },
    },
    opts = {
      interactions = {
        chat = { adapter = 'ollama' },
        inline = { adapter = 'ollama' },
        cmd = { adapter = 'ollama' },
      },
      adapters = {
        ollama = function()
          return require('codecompanion.adapters').extend('ollama', {
            schema = {
              model = { default = 'qwen3-coder:30b' },
              num_ctx = { default = 16384 },
            },
          })
        end,
      },
    },
  },
}
