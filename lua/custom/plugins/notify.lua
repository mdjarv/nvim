return {
  'rcarriga/nvim-notify',
  event = 'VeryLazy',
  config = function()
    local notify = require 'notify'
    notify.setup {
      render = 'wrapped-compact',
      -- stages = 'fade_in_slide_out',
      stages = 'fade',
      -- Timeout doesn't seem to work with stages
      timeout = 500,
      icons = {
        ERROR = '',
        WARN = '',
        INFO = '',
        DEBUG = '',
        TRACE = '✎',
      },
    }
    vim.notify = notify
  end,
}
