return {
  {
    'folke/trouble.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      { '<leader>tt', function() require('trouble').toggle() end, desc = 'Toggle trouble' },
      { '<leader>tw', function() require('trouble').toggle 'workspace_diagnostics' end, desc = 'Toggle workspace diagnostics' },
      { '<leader>td', function() require('trouble').toggle 'document_diagnostics' end, desc = 'Toggle document diagnostics' },
      { '<leader>tq', function() require('trouble').toggle 'quickfix' end, desc = 'Toggle quickfix' },
      { '<leader>tl', function() require('trouble').toggle 'loclist' end, desc = 'Toggle loclist' },
      { 'gR', function() require('trouble').toggle 'lsp_references' end, desc = 'Toggle lsp references' },
      { '<leader>[', function() require('trouble').previous { skip_groups = true, jump = true } end, desc = 'Go to previous diagnostic message' },
      { '<leader>]', function() require('trouble').next { skip_groups = true, jump = true } end, desc = 'Go to next diagnostic message' },
    },
    config = function()
      require('trouble').setup {}

      require('which-key').register {
        ['<leader>t'] = { name = '[T]rouble', _ = 'which_key_ignore' },
      }
    end,
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VimEnter',
    keys = {
      { '<leader>tc', '<cmd>TodoTrouble<cr>', desc = 'Todo comments' },
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
  },
}
