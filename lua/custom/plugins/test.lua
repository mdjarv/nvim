return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      -- { 'fredrikaverpil/neotest-golang', version = '*' },
      'nvim-neotest/neotest-go',
    },
    config = function()
      local neotest_ns = vim.api.nvim_create_namespace 'neotest'
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
            return message
          end,
        },
      }, neotest_ns)

      require('neotest').setup {
        adapters = {
          -- require 'neotest-golang' {
          --   log_level = 1,
          --   testify_enabled = true,
          --   --   runner = 'gotestsum',
          -- },
          require 'neotest-go',
        },
      }

      require('which-key').add {
        { '<leader>t', group = '[T]est' },
      }
    end,
    keys = {
      {
        '<leader>ta',
        function()
          require('neotest').run.attach()
        end,
        desc = '[t]est [a]ttach',
      },
      {
        '<leader>tf',
        function()
          require('neotest').run.run(vim.fn.expand '%')
        end,
        desc = '[t]est run [f]ile',
      },
      {
        '<leader>tA',
        function()
          require('neotest').run.run(vim.uv.cwd())
        end,
        desc = '[t]est [A]ll files',
      },
      {
        '<leader>tS',
        function()
          require('neotest').run.run { suite = true }
        end,
        desc = '[t]est [S]uite',
      },
      {
        '<leader>tn',
        function()
          require('neotest').run.run()
        end,
        desc = '[t]est [n]earest',
      },
      {
        '<leader>tl',
        function()
          require('neotest').run.run_last()
        end,
        desc = '[t]est [l]ast',
      },
      {
        '<leader>ts',
        function()
          require('neotest').summary.toggle()
        end,
        desc = '[t]est [s]ummary',
      },
      {
        '<leader>to',
        function()
          require('neotest').output.open { enter = true, auto_close = true }
        end,
        desc = '[t]est [o]utput',
      },
      {
        '<leader>tO',
        function()
          require('neotest').output_panel.toggle()
        end,
        desc = '[t]est [O]utput panel',
      },
      {
        '<leader>tt',
        function()
          require('neotest').run.stop()
        end,
        desc = '[t]est [t]erminate',
      },
      {
        '<leader>td',
        function()
          require('neotest').run.run { suite = false, strategy = 'dap' }
        end,
        desc = 'Debug nearest test',
      },
      {
        '<leader>tD',
        function()
          require('neotest').run.run { vim.fn.expand '%', strategy = 'dap' }
        end,
        desc = 'Debug current file',
      },

      -- {
      --   '<leader>tw',
      --   function()
      --     require('neotest').watch.toggle()
      --   end,
      --   desc = 'Toggle test watcher',
      -- },
      -- {
      --   '<leader>tf',
      --   function()
      --     require('neotest').run.run(vim.fn.expand '%')
      --   end,
      --   desc = 'Test current file',
      -- },
      -- {
      --   '<leader>tt',
      --   function()
      --     require('neotest').run.run { suite = true }
      --   end,
      -- },
      -- {
      --   '<leader>ts',
      --   function()
      --     require('neotest').summary.toggle()
      --   end,
      --   desc = 'Toggle test summary',
      -- },
    },
  },
  {
    'andythigpen/nvim-coverage',
    version = '*',
    config = function()
      require('coverage').setup {
        auto_reload = true,
      }
    end,
  },
}
