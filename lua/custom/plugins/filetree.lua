-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
	'nvim-neo-tree/neo-tree.nvim',
	version = '*',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
		'MunifTanjim/nui.nvim',
	},
	config = function()
		require('neo-tree').setup {
			close_if_last_window = true,
			sort_case_insensitive = true,
			filesystem = {
				follow_current_file = {
					enabled = true,    -- This will find and focus the file in the active buffer every time the current file is changed while the tree is open.
					leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
				},
			},
			window = {
				width = 25,
				mappings = {
					['l'] = 'open',
					['h'] = 'close_node',
					['<C-v>'] = 'open_vsplit',
				},
			},
		}
	end,
	vim.api.nvim_set_keymap('n', '<localleader>e', ':Neotree toggle<CR>', { silent = true, desc = 'Open NeoTree' })
}
