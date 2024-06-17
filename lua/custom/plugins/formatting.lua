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
        javascript = { { 'prettier', 'eslint' } },
        typescript = { { 'prettier', 'eslint' } },
        javascriptreact = { { 'prettier', 'eslint' } },
        typescriptreact = { { 'prettier', 'eslint' } },
        css = { { 'prettier', 'eslint' } },
        html = { { 'prettier', 'eslint' } },

        lua = { 'stylua' },
        go = { 'goimports', 'gofmt' },
      },
      -- format_on_save = {
      --   lsp_fallback = true,
      --   timeout_ms = 5000,
      -- },
    }
  end,
}
