return {
  name = 'got.nvim',
  dir = '~/git/got.nvim',
  ft = { 'go', 'javascript', 'typescript', 'lua' },
  keys = {
    { '<leader>ta', '<cmd>GotRun<cr>', desc = 'Run tests' },
    { '<leader>tw', '<cmd>GotWatch<cr>', desc = 'Watch tests' },
    { '<leader>tt', '<cmd>GotRunTest<cr>', desc = 'Run test under cursor' },
    { '<leader>tp', '<cmd>GotRunPkg<cr>', desc = 'Run tests in package' },
    { '<leader>tf', '<cmd>GotRunFile<cr>', desc = 'Run tests in file' },
    { '<leader>to', '<cmd>GotToggle<cr>', desc = 'Toggle test panel' },
    { '<leader>tc', '<cmd>GotCoverageToggle<cr>', desc = 'Toggle coverage overlay' },
    { '<leader>ts', '<cmd>GotPick<cr>', desc = 'Search tests' },
    { '<leader>td', '<cmd>GotDebugTest<cr>', desc = 'Debug test at cursor' },
  },
  config = function()
    require('got').setup {
      got_cmd = 'got',
      auto_clear = true,
      tree = {
        follow_cursor = true,
      },
    }
  end,
}
