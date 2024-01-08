return {
	'nvimtools/none-ls.nvim',
	config = function()
		local null_ls = require('null-ls')
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.eslint_d,
				null_ls.builtins.formatting.prettier.with({
					filetypes = {
						'javascript',
						'javascriptreact',
						'typescript',
						'typescriptreact',
					},
				}),
				null_ls.builtins.formatting.gofmt,
			}
		})
	end
}
