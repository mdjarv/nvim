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
        suggestion = { enabled = true, auto_trigger = false },
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
}
