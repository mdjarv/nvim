return {
	'VonHeikemen/fine-cmdline.nvim',
	dependencies = { 'MunifTanjim/nui.nvim' },
	config = function()
		require('fine-cmdline').setup({
			cmdline = {
				prompt = ': ',
			},
			popup = {},
			hooks = {},
		})

		vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', { noremap = true, desc = 'Command line' })
		-- vim.api.nvim_set_keymap('v', ':', '<cmd>FineCmdline \'<,\'><CR>', { noremap = true, desc = 'Command line' })
	end
}
