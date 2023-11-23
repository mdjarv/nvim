return {
	'zbirenbaum/copilot-cmp',
	events = 'InsertEnter',
	dependencies = { 'zbirenbaum/copilot.lua' },
	config = function()
		vim.defer_fn(function()
			require('copilot').setup()
			require('copilot_cmp').setup()
		end, 100)
	end
}
