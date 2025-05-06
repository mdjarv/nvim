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
    'zbirenbaum/copilot-cmp',
    dependencies = { 'zbirenbaum/copilot.lua' },
    config = function()
      require('copilot_cmp').setup()
      vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })
    end,
  },
  -- {
  --   'AndreM222/copilot-lualine',
  --   dependencies = {
  --     'zbirenbaum/copilot.lua',
  --     'nvim-lualine/lualine.nvim',
  --   },
  -- },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      file_types = { 'markdown', 'copilot-chat', 'Avante' },
    },
    ft = { 'markdown', 'copilot-chat', 'Avante' },
  },
}
