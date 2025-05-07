local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == '' then
    return ''
  end

  return ' ' .. recording_register
end

return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local lualine = require 'lualine'

    lualine.setup {
      options = {
        icons_enabled = true,
        -- theme = 'catppuccin',
        component_separators = { left = '', right = '|' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'Avante', 'AvanteInput', 'AvanteSelectedFiles' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          'branch',
          'diff',
          'diagnostics',
        },
        lualine_c = {
          'filename',
          { 'macro-recording', fmt = show_macro_recording, fg = '#ff0000' },
        },
        lualine_x = {
          -- {
          --   'copilot',
          --   symbols = {
          --     status = {
          --       icons = {
          --         enabled = ' ',
          --         sleep = ' ', -- auto-trigger disabled
          --         disabled = ' ',
          --         warning = ' ',
          --         unknown = ' ',
          --       },
          --       hl = {
          --         enabled = require('copilot-lualine.colors').get_hl_value(0, 'DiagnosticWarn', 'fg'), -- hl value
          --         -- enabled = '#50FA7B',
          --         sleep = '#AEB7D0',
          --         disabled = '#6272A4',
          --         warning = '#FFB86C',
          --         unknown = '#FF5555',
          --       },
          --     },
          --     spinners = require('copilot-lualine.spinners').dots,
          --     spinner_color = '#6272A4',
          --   },
          --   show_colors = true,
          --   show_loading = true,
          -- },
          'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    }

    vim.api.nvim_create_autocmd('RecordingEnter', {
      callback = function()
        lualine.refresh {
          place = { 'statusline' },
        }
      end,
    })

    vim.api.nvim_create_autocmd('RecordingLeave', {
      callback = function()
        -- This is going to seem really weird!
        -- Instead of just calling refresh we need to wait a moment because of the nature of
        -- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
        -- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
        -- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
        -- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
        local timer = vim.loop.new_timer()
        timer:start(
          50,
          0,
          vim.schedule_wrap(function()
            lualine.refresh {
              place = { 'statusline' },
            }
          end)
        )
      end,
    })
  end,
}
