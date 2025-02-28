return {
  {
    'zbirenbaum/copilot.lua',
    dependencies = {
      'nvim-lualine/lualine.nvim',
    },
    cmd = 'Copilot',
    event = 'InsertEnter',
    build = ':Copilot auth',
    config = function()
      require('copilot').setup {
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = { ['*'] = true },
      }
    end,
  },
  {
    'AndreM222/copilot-lualine',
    dependencies = {
      'zbirenbaum/copilot.lua',
      'nvim-lualine/lualine.nvim',
    },
  },
  {
    'zbirenbaum/copilot-cmp',
    dependencies = { 'zbirenbaum/copilot.lua' },
    config = function()
      require('copilot_cmp').setup()
      vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      file_types = { 'markdown', 'copilot-chat' },
    },
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      'zbirenbaum/copilot.lua',
      'nvim-lua/plenary.nvim',
      'MeanderingProgrammer/render-markdown.nvim',
    },
    build = 'make tiktoken',
    keys = {
      { '<leader>cc', '<cmd>CopilotChatToggle<cr>', mode = { 'n', 'x' }, desc = '[C]opilot [C]hat' },
      { '<leader>cf', '<cmd>CopilotChatFix<cr>', mode = { 'n', 'x' }, desc = '[C]opilot [F]ix' },
    },
    opts = {
      window = {
        width = 80,
      },
      highlight_headers = false,
      separator = '---',
      error_header = '> [!ERROR] Error',
      model = 'claude-3.7-sonnet',
    },
  },
  {
    'David-Kunz/gen.nvim',
    opts = {
      model = 'mistral',
    },
  },
}
