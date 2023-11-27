return {
	'zbirenbaum/copilot-cmp',
	events = 'InsertEnter',
	dependencies = { 'zbirenbaum/copilot.lua' },
	config = function()
		vim.defer_fn(function()
			require('copilot').setup({
				panel = {
					enabled = false,
				},
				suggestion = {
					enabled = false,
					-- auto_trigger = false,
					-- keymap = {
					-- 	accept = '<tab>',
					-- },
				},
				filetypes = {
					yaml = true,
					markdown = true,
				},
			})
			require('copilot_cmp').setup()
		end, 100)
	end
}
