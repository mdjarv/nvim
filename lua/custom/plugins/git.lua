require('which-key').add {
  { '<leader>g', group = '[G]it' },
  { '<leader>g_', hidden = true },
}

return {
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    event = 'BufReadPre',
    opts = {
      default_mappings = {
        ours = 'co',
        theirs = 'ct',
        none = 'c0',
        both = 'cb',
        next = ']x',
        prev = '[x',
      },
      disable_diagnostics = true, -- Disable diagnostics in conflict buffers
      list_opener = 'copen', -- Command to open quickfix list
      highlights = {
        incoming = 'DiffAdd',
        current = 'DiffText',
      },
    },
    keys = {
      { '<leader>gx', '<cmd>GitConflictListQf<cr>', desc = 'List conflicts (quickfix)' },
      { '<leader>gr', '<cmd>GitConflictRefresh<cr>', desc = 'Refresh conflicts' },
    },
  },
  -- {
  --   'tpope/vim-fugitive',
  --   keys = {
  --     { '<leader>gg', '<cmd>Git<cr>', desc = 'Git Status' },
  --     { '<leader>gd', '<cmd>Gvdiffsplit<cr>', desc = 'Git Diff' },
  --     { '<leader>gl', '<cmd>Git log --graph --abbrev-commit --pretty=oneline<cr>', desc = 'Git Log' },
  --     { '<leader>gp', '<cmd>Git push<cr>', desc = 'Git Push' },
  --     { '<leader>gr', '<cmd>Git reset<cr>', desc = 'Git Reset' },
  --     { '<leader>gc', '<cmd>Git commit<cr>', desc = 'Git Commit' },
  --     { '<leader>gb', '<cmd>Git blame<cr>', desc = 'Git Blame' },
  --     { '<leader>gp', '<cmd>Git pull<cr>', desc = 'Git Pull' },
  --     { '<leader>gP', '<cmd>Git push<cr>', desc = 'Git Push' },
  --     { '<leader>gf', '<cmd>Git fetch<cr>', desc = 'Git Fetch' },
  --   },
  --   config = function() end,
  -- },
  -- 'tpope/vim-rhubarb',
  -- {
  --   'kdheepak/lazygit.nvim',
  --   cmd = {
  --     'LazyGit',
  --     'LazyGitConfig',
  --     'LazyGitCurrentFile',
  --     'LazyGitFilter',
  --     'LazyGitFilterCurrentFile',
  --   },
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --   },
  --   keys = {
  --     { '<leader>l', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
  --   },
  -- },
}
