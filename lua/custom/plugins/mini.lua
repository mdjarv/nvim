local logo = {
  '                                              ',
  '       ███████████           █████      ██',
  '      ███████████             █████ ',
  '      ████████████████ ███████████ ███   ███████',
  '     ████████████████ ████████████ █████ ██████████████',
  '    ██████████████    █████████████ █████ █████ ████ █████',
  '  ██████████████████████████████████ █████ █████ ████ █████',
  ' ██████  ███ █████████████████ ████ █████ █████ ████ ██████',
}

return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    -- require('mini.sessions').setup {
    --   autoread = true,
    --   autoload = true,
    -- }

    local starter = require 'mini.starter'
    starter.setup {
      evaluate_single = true,
      items = {
        -- starter.sections.telescope(),
        starter.sections.builtin_actions(),
        starter.sections.recent_files(10, false),
        starter.sections.recent_files(10, true),
        starter.sections.sessions(5, true),
      },
      content_hooks = {
        starter.gen_hook.adding_bullet(),
        starter.gen_hook.indexing('all', { 'Builtin actions' }),
        starter.gen_hook.padding(3, 2),
        -- starter.gen_hook.aligning('center', 'center'),
      },
    }

    require('mini.tabline').setup {
      -- show_icons = false,
      -- format = function(buf_id, label)
      --   return string.format(' %s ', label)
      -- end,
    }

    require('mini.splitjoin').setup()

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
