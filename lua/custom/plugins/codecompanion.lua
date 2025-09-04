return {
  {
    'olimorris/codecompanion.nvim',
    enabled = false,
    config = function()
      require('codecompanion').setup {
        strategies = {
          chat = {
            adapter = 'openrouter',
          },
          inline = {
            adapter = 'openrouter',
          },
        },
        adapters = {
          http = {
            openrouter = function()
              return require('codecompanion.adapters').extend('openai_compatible', {
                env = {
                  url = 'https://openrouter.ai/api',
                  api_key = 'OPENROUTER_API_KEY',
                  chat_url = '/chat/completions',
                },
                schema = {
                  default_model = 'openai/gpt-5-mini',
                },
              })
            end,
          },
        },
      }

      vim.keymap.set({ 'n', 'v' }, '<leader>ak', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
      vim.keymap.set({ 'n', 'v' }, '<leader>aa', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
      vim.keymap.set('v', 'ga', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })
      --
      -- vim.keymap.set('n', '<leader>as', select_model, { desc = 'Select Model' })
      -- -- Expand 'cc' into 'CodeCompanion' in the command line
      -- vim.cmd [[cab cc CodeCompanion]]
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'ravitemer/mcphub.nvim',
    },
  },
}
