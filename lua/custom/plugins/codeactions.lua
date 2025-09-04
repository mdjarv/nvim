return {
  'rachartier/tiny-code-action.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },

    -- optional picker via telescope
    -- { 'nvim-telescope/telescope.nvim' },
    -- optional picker via fzf-lua
    -- { 'ibhagwan/fzf-lua' },
    -- .. or via snacks
    {
      'folke/snacks.nvim',
      opts = {
        terminal = {},
      },
    },
  },
  event = 'LspAttach',
  opts = {
    picker = 'snacks',
    signs = {
      quickfix = { '', { link = 'DiagnosticWarning' } },
      others = { '', { link = 'DiagnosticWarning' } },
      refactor = { '', { link = 'DiagnosticInfo' } },
      ['refactor.move'] = { '󰪹', { link = 'DiagnosticInfo' } },
      ['refactor.extract'] = { '', { link = 'DiagnosticError' } },
      ['source.organizeImports'] = { '', { link = 'DiagnosticWarning' } },
      ['source.fixAll'] = { '󰃢', { link = 'DiagnosticError' } },
      ['source'] = { '', { link = 'DiagnosticError' } },
      ['rename'] = { '󰑕', { link = 'DiagnosticWarning' } },
      ['codeAction'] = { '', { link = 'DiagnosticWarning' } },
    },
  },
  keys = {
    {
      '<leader>ca',
      function()
        require('tiny-code-action').code_action {}
      end,
      desc = 'Tiny Code Action',
    },
    {
      '<leader>cA',
      function()
        require('tiny-code-action').code_action_all()
      end,
      desc = 'Tiny Code Action All',
    },
  },
}
