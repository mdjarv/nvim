require('which-key').add {
  { '<leader>g', group = '[G]it' },
  { '<leader>g_', hidden = true },
}

return {
  {
    'tpope/vim-fugitive',
    keys = {
      { '<leader>gg', '<cmd>Git<cr>', desc = 'Git Status' },
      { '<leader>gd', '<cmd>Gvdiffsplit<cr>', desc = 'Git Diff' },
      { '<leader>gl', '<cmd>Git log --graph --abbrev-commit --pretty=oneline<cr>', desc = 'Git Log' },
      { '<leader>gp', '<cmd>Git push<cr>', desc = 'Git Push' },
      { '<leader>gr', '<cmd>Git reset<cr>', desc = 'Git Reset' },
      { '<leader>gc', '<cmd>Git commit<cr>', desc = 'Git Commit' },
      { '<leader>gb', '<cmd>Git blame<cr>', desc = 'Git Blame' },
      { '<leader>gp', '<cmd>Git pull<cr>', desc = 'Git Pull' },
      { '<leader>gP', '<cmd>Git push<cr>', desc = 'Git Push' },
      { '<leader>gf', '<cmd>Git fetch<cr>', desc = 'Git Fetch' },
    },
    config = true,
  },
  'tpope/vim-rhubarb',
}
