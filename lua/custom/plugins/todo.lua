-- Highlight todo, notes, etc in comments
return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim', 'folke/snacks.nvim' },
  keys = {
    {
      '<leader>st',
      function()
        Snacks.picker.todo_comments()
      end,
      desc = 'Todo Comments',
    },
  },
  opts = {
    -- signs = false,
  },
}
