return {
	{
		'zbirenbaum/copilot.lua',
		cmd = "Copilot",
		event = "InsertEnter",
		build = ":Copilot auth",
		config = function()
			local copilot = require('copilot')
			copilot.setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
				filetypes = { ["*"] = true },
			})
		end
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { 'zbirenbaum/copilot.lua' },
		config = function()
			require("copilot_cmp").setup()
			vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
		end
	},
}
