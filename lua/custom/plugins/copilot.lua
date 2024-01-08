-- return {
-- 	'zbirenbaum/copilot-cmp',
-- 	events = 'InsertEnter',
-- 	dependencies = { 'zbirenbaum/copilot.lua', 'ofseed/copilot-status.nvim' },
-- 	config = function()
-- 		vim.defer_fn(function()
-- 			require('copilot').setup({
-- 				panel = {
-- 					enabled = false,
-- 				},
-- 				suggestion = {
-- 					enabled = false,
-- 					-- auto_trigger = false,
-- 					-- keymap = {
-- 					-- 	accept = '<tab>',
-- 					-- },
-- 				},
-- 				filetypes = {
-- 					yaml = true,
-- 					markdown = true,
-- 				},
-- 			})
-- 			require('copilot_cmp').setup()
-- 		end, 100)
-- 	end
-- }

return {
	'zbirenbaum/copilot.lua',
	cmd = "Copilot",
	event = "InsertEnter",
	build = ":Copilot auth",
	config = function()
		local copilot = require('copilot')
		copilot.setup({
			suggestion = {
				enabled = true,
				auto_trigger = false,
				debounce = 75,
			},
			panel = { enabled = false },
		})
	end
}
