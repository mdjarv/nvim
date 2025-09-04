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
        copilot_model = 'gpt-5-mini',
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
}
