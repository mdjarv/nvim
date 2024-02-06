return {
  'stevearc/conform.nvim',
  -- event = { 'BufReadPre', 'BufNewFile' },
  cmd = 'ConformInfo',
  keys = {
    {
      '<leader>lf',
      function()
        require('conform').format()
      end,
      mode = { 'n', 'v' },
      desc = '[F]ormat file or selection',
    },
  },
  config = function()
    local conform = require 'conform'
    conform.setup {
      format = {
        timeout_ms = 5000,
        async = false,
        quiet = false,
      },
      formatters_by_ft = {
        javascript = { { 'prettier', 'eslint_d' } },
        typescript = { { 'prettier', 'eslint_d' } },
        javascriptreact = { { 'prettier', 'eslint_d' } },
        typescriptreact = { { 'prettier', 'eslint_d' } },
        css = { { 'prettier', 'eslint_d' } },
        html = { { 'prettier', 'eslint_d' } },

        lua = { 'stylua' },
        go = { 'goimports', 'gofmt' },
      },
      -- format_on_save = {
      --   lsp_fallback = true,
      --   timeout_ms = 5000,
      -- },
    }
    --
    -- vim.keymap.set({ 'n', 'v' }, '<leader>lf', function()
    --   conform.format {
    --     lsp_fallback = true,
    --     async = false,
    --     timeout_ms = 1000,
    --   }
    -- end, { desc = '[F]ormat file or selection' })
  end,
}
