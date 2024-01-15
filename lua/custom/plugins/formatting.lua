return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require 'conform'
    conform.setup {
      formatters_by_ft = {
        javascript = { { 'prettierd', 'prettier', 'eslint_d' } },
        typescript = { { 'prettierd', 'prettier', 'eslint_d' } },
        javascriptreact = { { 'prettierd', 'prettier', 'eslint_d' } },
        typescriptreact = { { 'prettierd', 'prettier', 'eslint_d' } },
        css = { { 'prettierd', 'prettier', 'eslint_d' } },
        html = { { 'prettierd', 'prettier', 'eslint_d' } },

        lua = { 'stylua' },
        go = { 'goimports', 'gofmt' },
      },
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 5000,
      },
    }

    vim.keymap.set({ 'n', 'v' }, '<leader>lf', function()
      conform.format {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      }
    end, { desc = '[F]ormat file or selection' })
  end,
}
