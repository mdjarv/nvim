return {
	'stevearc/oil.nvim',
	opts = {},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require('oil').setup({
		})

		local opts = { noremap = true, silent = true }
		vim.keymap.set('n', '-', ':Oil<CR>', opts)
	end,
}
