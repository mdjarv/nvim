return {
  'ravitemer/mcphub.nvim',
  enabled = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  build = 'npm install -g mcp-hub@latest',
  keys = {
    { '<leader>am', '<cmd>MCPHub<cr>', desc = 'MCP Hub' },
  },
  config = function()
    require('mcphub').setup {
      auto_approve = true,
      auto_toggle_mcp_servers = true,
      extensions = {
        avante = {
          enabled = true,
          make_slash_commands = true,
        },
      },
    }
    -- vim.notify('MCPHub is configured', vim.log.levels.DEBUG)
  end,
}
