return {
	'stevearc/conform.nvim',
	event = { 'BufReadPre', 'BufNewFile' },
	config = function()
		local conform = require('conform')
		conform.setup({
			formatters_by_ft = {
				javascript = { { 'eslint_d', 'prettier' } },
				typescript = { { 'eslint_d', 'prettier' } },
				javascriptreact = { { 'eslint_d', 'prettier' } },
				typescriptreact = { { 'eslint_d', 'prettier' } },
				css = { { 'eslint_d', 'prettier' } },
				html = { { 'eslint_d', 'prettier' } },

				lua = { 'stylua' },
				go = { 'gofmt' },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		vim.keymap.set({ 'n', 'v' }, '<leader>lf', function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = '[F]ormat file or selection' })
	end
}
