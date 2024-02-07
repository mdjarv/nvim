return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'VimEnter',
  keys = {
    { '<leader>tT', '<cmd>TodoTrouble<cr>', desc = 'Todo' },
  },
  opts = {
    highlight = {
      keyword = 'bg',
      pattern = [[.*<(KEYWORDS):?\s+.*]],
    },
    search = {
      pattern = [[\b(KEYWORDS):?\b]],
    },
  },
}
