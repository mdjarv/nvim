require('which-key').register {
	['<leader>g'] = { name = 'Git', _ = 'which_key_ignore' },
}

vim.keymap.set('n', '<leader>gg', '<cmd>Git<cr>', { desc = 'Git Status' })
vim.keymap.set('n', '<leader>gd', '<cmd>Gvdiffsplit<cr>', { desc = 'Git Diff' })
vim.keymap.set('n', '<leader>gl', '<cmd>Git log --graph --abbrev-commit --pretty=oneline<cr>', { desc = 'Git Log' })
vim.keymap.set('n', '<leader>gp', '<cmd>Git push<cr>', { desc = 'Git Push' })
vim.keymap.set('n', '<leader>gr', '<cmd>Git reset<cr>', { desc = 'Git Reset' })
vim.keymap.set('n', '<leader>gc', '<cmd>Git commit<cr>', { desc = 'Git Commit' })
vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<cr>', { desc = 'Git Blame' })
vim.keymap.set('n', '<leader>gp', '<cmd>Git pull<cr>', { desc = 'Git Pull' })
vim.keymap.set('n', '<leader>gP', '<cmd>Git push<cr>', { desc = 'Git Push' })
vim.keymap.set('n', '<leader>gf', '<cmd>Git fetch<cr>', { desc = 'Git Fetch' })

return {
	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',
}
