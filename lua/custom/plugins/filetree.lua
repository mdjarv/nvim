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
				width = 35,
				mappings = {
					['l'] = 'open',
					['h'] = 'close_node',
					['s'] = 'open_split',
					['<C-v>'] = 'open_vsplit',
				},
			},
			default_component_configs = {
				git_status = {
					symbols = {
						-- Change type
						added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
						modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
						deleted   = "✖", -- this can only be used in the git_status source
						renamed   = "󰁕", -- this can only be used in the git_status source
						-- Status type
						untracked = "",
						ignored   = "",
						unstaged  = "󰄱",
						staged    = "",
						conflict  = "",
					},
				},
			},
		}
	end,
	vim.api.nvim_set_keymap('n', '<localleader>e', ':Neotree toggle<CR>', { silent = true, desc = 'Open NeoTree' })
}
