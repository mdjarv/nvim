-- local logo = {
--   '                                              ',
--   '       ███████████           █████      ██',
--   '      ███████████             █████ ',
--   '      ████████████████ ███████████ ███   ███████',
--   '     ████████████████ ████████████ █████ ██████████████',
--   '    ██████████████    █████████████ █████ █████ ████ █████',
--   '  ██████████████████████████████████ █████ █████ ████ █████',
--   ' ██████  ███ █████████████████ ████ █████ █████ ████ ██████',
-- }

return {
  'nvimdev/dashboard-nvim',
  lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
  opts = function()
    local logo = [[
          ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
          ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
          ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
          ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
          ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
          ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
    ]]

    logo = string.rep('\n', 8) .. logo .. '\n\n'

    local opts = {
      theme = 'doom',
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        header = vim.split(logo, '\n'),
        -- stylua: ignore
        center = {
          { action = 'Telescope find_files',                      desc = " Find File",       icon = "  ", key = "f" },
          { action = "ene | startinsert",                         desc = " New File",        icon = "  ", key = "n" },
          { action = 'Telescope oldfiles',                        desc = " Recent Files",    icon = "  ", key = "r" },
          { action = 'Telescope live_grep',                       desc = " Find Text",       icon = "  ", key = "g" },
          { action = function()
            require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
          end,                                                    desc = " Config",          icon = "  ", key = "c" },
          { action = "Lazy",                                      desc = " Lazy",            icon = "󰒲  ", key = "l" },
          { action = "Mason",                                     desc = " Mason",           icon = "  ", key = "m" },
          { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit",        icon = "  ", key = "q" },
        },
        footer = function()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
        end,
      },
    }

    -- Fetch recent files and add them to the dashboard center actions
    vim.cmd 'rshada'
    local recent_files = {}
    local cwd = vim.fn.getcwd()
    for _, f in ipairs(vim.v.oldfiles) do
      if f:find(cwd, 1, true) and vim.fn.filereadable(f) == 1 then
        table.insert(recent_files, f)
      end

      if #recent_files >= 3 then
        break
      end
    end

    if #recent_files == 0 then
      table.insert(opts.config.center, {
        desc = ' No recent files',
        -- action = function()
        --   vim.api.nvim_command 'Telescope oldfiles'
        -- end,
        icon = '  ',
        -- key = 'r',
      })
    else
      table.insert(opts.config.center, {
        desc = ' Recent files',
        -- action = function()
        --   vim.api.nvim_command 'Telescope oldfiles'
        -- end,
        icon = '  ',
        -- key = 'r',
      })
      for i, file in ipairs(recent_files) do
        table.insert(opts.config.center, {
          desc = ' ' .. vim.fn.fnamemodify(file, ':~:.'),
          action = function()
            vim.api.nvim_command('edit ' .. vim.fn.fnameescape(file))
          end,
          key = tostring(i),
        })
      end
    end

    -- open dashboard after closing lazy
    if vim.o.filetype == 'lazy' then
      vim.api.nvim_create_autocmd('WinClosed', {
        pattern = tostring(vim.api.nvim_get_current_win()),
        once = true,
        callback = function()
          vim.schedule(function()
            vim.api.nvim_exec_autocmds('UIEnter', { group = 'dashboard' })
          end)
        end,
      })
    end

    return opts
  end,
}
