return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-go',
  },
  keys = {
    {
      '<leader>Tp',
      function()
        require('neotest').run.run(vim.fn.getcwd())
      end,
      desc = 'Project',
    },
    {
      '<leader>Tf',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = 'File',
    },
    {
      '<leader>Tt',
      function()
        require('neotest').run.run()
      end,
      desc = 'Current function',
    },
    {
      '<leader>Ta',
      function()
        require('neotest').run.attach()
      end,
      desc = 'Attach',
    },
    {
      '<leader>Td',
      function()
        require('neotest').run.run { strategy = 'dap' }
      end,
      desc = 'Debug',
    },
    {
      '<leader>Ts',
      function()
        require('neotest').run.stop()
      end,
      desc = 'Stop debug',
    },
    {
      '<leader>Tw',
      function()
        require('neotest').watch.toggle(vim.fn.expand '%')
      end,
      desc = 'Stop debug',
    },
  },
  config = function()
    -- get neotest namespace (api call creates or returns namespace)
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
      diagnostic = {
        enabled = true,
      },
      status = {
        virtual_text = true,
        signs = true,
      },
      strategies = {
        integrated = {
          width = 180,
        },
      },
      adapters = {
        require 'neotest-go' {
          args = { '-count=1', '-timeout=60s', '-race', '-cover' },
        },
      },
      library = { plugins = { 'neotest' }, types = true },
    }
  end,
}
