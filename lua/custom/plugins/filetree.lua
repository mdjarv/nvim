-- return {
-- 	'nvim-tree/nvim-tree.lua',
-- 	dependencies = { 'nvim-tree/nvim-web-devicons' },
-- 	config = function()
-- 		require('nvim-tree').setup({
-- 			sync_root_with_cwd = true,
-- 			respect_buf_cwd = true,
-- 			update_focused_file = {
-- 				enable = true,
-- 				update_root = true,
-- 			},
-- 			renderer = {
-- 				icons = {
-- 					glyphs = {
-- 						default = "",
-- 						symlink = "",
-- 						bookmark = "󰆤",
-- 						modified = "●",
-- 						folder = {
-- 							arrow_closed = "",
-- 							arrow_open = "",
-- 							default = "",
-- 							open = "",
-- 							empty = "",
-- 							empty_open = "",
-- 							symlink = "",
-- 							symlink_open = "",
-- 						},
-- 						git = {
-- 							unstaged = "✗",
-- 							staged = "✓",
-- 							unmerged = "",
-- 							renamed = "➜",
-- 							untracked = "★",
-- 							deleted = "",
-- 							ignored = "◌",
-- 						},
-- 					},
-- 				},
-- 			},
-- 			on_attach = function(bufnr)
-- 				local api = require("nvim-tree.api")
-- 				local function opts(desc)
-- 					return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
-- 				end
--
-- 				api.config.mappings.default_on_attach(bufnr)
--
-- 				vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
-- 				vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
-- 				vim.keymap.set('n', 'v', api.node.open.vertical, opts('Vertical Split'))
-- 			end
-- 		})
--
-- 		vim.keymap.set('n', '<leader>e', require('nvim-tree.api').tree.toggle, { desc = 'Toggle Filetree' })
-- 	end
-- }

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  keys = {
    { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'Toggle Filetree' },
  },
  config = function()
    require('neo-tree').setup {
      close_if_last_window = true,
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        filtered_items = {
          visible = true,
        },
      },
      window = {
        mappings = {
          ['l'] = 'open',
          ['h'] = 'close_node',
        },
      },
    }
  end,
}

-- return {
--   'nvim-telescope/telescope-file-browser.nvim',
--   dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
--   keys = {
--     -- { '<leader>e', '<cmd>Telescope file_browser<cr>', desc = 'Toggle Filetree' },
--     { '<leader>e', '<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>', desc = 'Toggle Filetree' },
--   },
-- }
