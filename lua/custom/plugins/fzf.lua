return {
  'ibhagwan/fzf-lua',
  enabled = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    keymap = {
      fzf = {
        -- Add current selection(s) to the quickfix list with Ctrl-q
        ['ctrl-q'] = 'select-all+accept',
      },
    },
    winopts = {
      height = 0.9,
      width = 0.9,
      backdrop = 60,
      fullscreen = true,
      preview = {
        wrap = true,
      },
    },
  },
  keys = {
    {
      'gd',
      function()
        require('fzf-lua').lsp_definitions()
      end,
      desc = 'LSP definitions',
    },
    {
      'gi',
      function()
        require('fzf-lua').lsp_implementations()
      end,
      desc = 'LSP implementations',
    },
    {
      '<leader>sr',
      function()
        require('fzf-lua').lsp_references()
      end,
    },
    {
      '<leader>sl',
      function()
        require('fzf-lua').lsp_finder()
      end,
      desc = 'LSP finder',
    },
    {
      '<leader>sa',
      function()
        require('fzf-lua').lsp_code_actions()
      end,
      desc = 'Code actions',
    },
    {
      '<leader>sd',
      function()
        require('fzf-lua').lsp_workspace_diagnostics()
      end,
      desc = 'Workspace diagnostics',
    },
    {
      '<leader>sf',
      function()
        require('fzf-lua').files()
      end,
      desc = 'Find files',
    },
    {
      '<leader>sn',
      function()
        require('fzf-lua').files { cwd = '~/.config/nvim' }
      end,
      desc = 'Find config files',
    },
    {
      '<leader>sg',
      function()
        require('fzf-lua').live_grep()
      end,
      desc = 'Live grep',
    },
    {
      '<leader>sb',
      function()
        require('fzf-lua').buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>sh',
      function()
        require('fzf-lua').help_tags()
      end,
      desc = 'Help tags',
    },
    {
      '<leader>sq',
      function()
        require('fzf-lua').quickfix()
      end,
      desc = 'Search quickfix',
    },
  },
}
