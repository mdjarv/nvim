-- document existing key chains
require('which-key').register {
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>l'] = { name = '[L]SP', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- vim.keymap.set('n', '<leader>c', '<cmd>bd<cr>', { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>', { desc = 'Quit' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Better indent
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>lk', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', '<leader>lj', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>lq', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Window motions
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to buffer left' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to buffer down' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to buffer up' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to buffer right' })

vim.keymap.set('n', '<S-h>', ':BufferLineCyclePrev<cr>', { desc = 'Previous tab' })
vim.keymap.set('n', '<S-l>', ':BufferLineCycleNext<cr>', { desc = 'Next tab' })

-- Edit vimrc
vim.keymap.set('n', '<leader>,', ':e $MYVIMRC<cr>', { desc = 'Edit Settings' })

return {}
