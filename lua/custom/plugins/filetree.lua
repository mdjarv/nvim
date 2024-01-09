-- Unless you are still migrating, remove the deprecated commands from v1.x
-- vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
--
-- return {
-- 	'nvim-neo-tree/neo-tree.nvim',
-- 	version = '*',
-- 	dependencies = {
-- 		'nvim-lua/plenary.nvim',
-- 		'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
-- 		'MunifTanjim/nui.nvim',
-- 	},
-- 	config = function()
-- 		require('neo-tree').setup {
-- 			close_if_last_window = true,
-- 			sort_case_insensitive = true,
-- 			filesystem = {
-- 				filtered_items = {
-- 					hide_hidden = false,
-- 				},
-- 				follow_current_file = {
-- 					enabled = true,    -- This will find and focus the file in the active buffer every time the current file is changed while the tree is open.
-- 					leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
-- 				},
-- 			},
-- 			window = {
-- 				width = 35,
-- 				mappings = {
-- 					['l'] = 'open',
-- 					['h'] = 'close_node',
-- 					['s'] = 'open_split',
-- 					['<C-v>'] = 'open_vsplit',
-- 				},
-- 			},
-- 			default_component_configs = {
-- 				git_status = {
-- 					symbols = {
-- 						-- Change type
-- 						added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
-- 						modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
-- 						deleted   = "✖", -- this can only be used in the git_status source
-- 						renamed   = "󰁕", -- this can only be used in the git_status source
-- 						-- Status type
-- 						untracked = "",
-- 						ignored   = "",
-- 						unstaged  = "󰄱",
-- 						staged    = "",
-- 						conflict  = "",
-- 					},
-- 				},
-- 			},
-- 		}
-- 	end,
-- 	vim.api.nvim_set_keymap('n', '<localleader>e', ':Neotree toggle<CR>', { silent = true, desc = 'Open NeoTree' })
-- }

return {
	'nvim-tree/nvim-tree.lua',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		require('nvim-tree').setup({
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = true,
			},
			renderer = {
				icons = {
					glyphs = {
						default = "",
						symlink = "",
						bookmark = "󰆤",
						modified = "●",
						folder = {
							arrow_closed = "",
							arrow_open = "",
							default = "",
							open = "",
							empty = "",
							empty_open = "",
							symlink = "",
							symlink_open = "",
						},
						git = {
							unstaged = "✗",
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							untracked = "★",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")
				local function opts(desc)
					return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				api.config.mappings.default_on_attach(bufnr)

				vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
				vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
				vim.keymap.set('n', 'v', api.node.open.vertical, opts('Vertical Split'))
			end
		})

		vim.keymap.set('n', '<leader>e', require('nvim-tree.api').tree.toggle, { desc = 'Toggle Filetree' })
	end
}
