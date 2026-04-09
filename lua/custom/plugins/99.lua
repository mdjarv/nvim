return {
  'ThePrimeagen/99',
  dependencies = {
    'saghen/blink.compat',
  },
  keys = {
    { '<leader>9v', function() require('99').visual() end, desc = '99: Edit selection', mode = 'v' },
    { '<leader>9f', function()
        vim.cmd 'normal! vaf'
        require('99').visual()
      end, desc = '99: Fill function' },
    { '<leader>9x', function() require('99').stop_all_requests() end, desc = '99: Stop requests', mode = { 'n', 'v' } },
    { '<leader>9l', function() require('99').view_logs() end, desc = '99: View logs' },
    { '<leader>9[', function() require('99').prev_request_logs() end, desc = '99: Prev logs' },
    { '<leader>9]', function() require('99').next_request_logs() end, desc = '99: Next logs' },
    { '<leader>9q', function() require('99').previous_requests_to_qfix() end, desc = '99: Requests to qfix' },
    { '<leader>9c', function() require('99').clear_previous_requests() end, desc = '99: Clear requests' },
    { '<leader>9m', function() require('99').clear_all_marks() end, desc = '99: Clear marks' },
    { '<leader>9i', function() require('99').info() end, desc = '99: Info' },
  },
  config = function()
    local _99 = require '99'
    local cwd = vim.uv.cwd()
    local basename = vim.fs.basename(cwd)
    _99.setup {
      provider = _99.Providers.ClaudeCodeProvider,
      model = 'claude-haiku-4-5',
      logger = {
        level = _99.DEBUG,
        path = '/tmp/' .. basename .. '.99.debug',
        print_on_error = true,
      },
      completion = {
        custom_rules = {},
        source = 'blink',
      },
      md_files = {
        'CLAUDE.md',
      },
    }
  end,
}
