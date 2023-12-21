return {
	'folke/zen-mode.nvim',
	config = function()
		vim.keymap.set('n', '<leader>z', '<cmd>ZenMode<cr>')
		require('zen-mode').setup({
			window = {
				backdrop = 0.7,
				width = 0.8,
				height = 1,
				options = {
					-- signcolumn = 'no',
					-- list = false,
					-- foldcolumn = '0',
				},
			},
		})
	end
}
