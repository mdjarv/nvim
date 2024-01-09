return {
	'folke/trouble.nvim',
	requires = {
		'nvim-tree/nvim-web-devicons',
	},
	config = function()
		require('trouble').setup({})

		require('which-key').register {
			['<leader>t'] = { name = '[T]rouble', _ = 'which_key_ignore' },
		}

		vim.keymap.set("n", "<leader>tt", function() require("trouble").toggle() end, { desc = "Toggle trouble" })
		vim.keymap.set("n", "<leader>tw", function() require("trouble").toggle("workspace_diagnostics") end,
			{ desc = "Toggle workspace diagnostics" })
		vim.keymap.set("n", "<leader>td", function() require("trouble").toggle("document_diagnostics") end,
			{ desc = "Toggle document diagnostics" })
		vim.keymap.set("n", "<leader>tq", function() require("trouble").toggle("quickfix") end, { desc = "Toggle quickfix" })
		vim.keymap.set("n", "<leader>tl", function() require("trouble").toggle("loclist") end, { desc = "Toggle loclist" })
		vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end,
			{ desc = "Toggle lsp references" })
		vim.keymap.set('n', '<leader>[', function() require("trouble").previous({ skip_groups = true, jump = true }) end,
			{ desc = 'Go to previous diagnostic message' })
		vim.keymap.set('n', '<leader>]', function() require("trouble").next({ skip_groups = true, jump = true }) end,
			{ desc = 'Go to next diagnostic message' })
	end,
}
