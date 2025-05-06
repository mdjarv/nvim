return {
  'yetone/avante.nvim',
  enabled = true,
  event = 'VeryLazy',
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  keys = {
    -- { '<leader>cc', '<cmd>AvanteToggle<cr>', desc = 'Avante toggle' },
  },
  opts = {
    -- auto_suggestions_provider = 'copilot',
    -- behaviour = {
    --   auto_suggestions = false,
    --   auto_suggestions_debounce = 500,
    --   auto_set_highlight_group = true,
    --   auto_set_keymaps = true,
    --   auto_apply_diff_after_generation = false,
    --   support_paste_from_clipboard = false,
    --   minimize_diff = true,
    -- },
    provider = 'copilot',
    copilot = {
      -- model = 'claude-3.7-sonnet',
      temperature = 0.1,
    },
    -- openai = {
    --   endpoint = 'https://api.openai.com/v1',
    --   model = 'gpt-4o', -- your desired model (or use gpt-4o, etc.)
    --   timeout = 30000, -- timeout in milliseconds
    --   temperature = 0, -- adjust if needed
    --   max_tokens = 4096,
    --   -- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
    -- },
    -- Add Go test tool
    -- custom_tools = {
    --   {
    --     name = 'Go Test',
    --     description = 'Run Go tests in the current directory',
    --     run = function()
    --       local job = require 'plenary.job'
    --       local output = ''
    --       job
    --         :new({
    --           command = 'go',
    --           args = { 'test', './...' },
    --           cwd = vim.fn.getcwd(),
    --           on_stdout = function(_, data)
    --             output = output .. table.concat(data, '\n')
    --           end,
    --           on_stderr = function(_, data)
    --             output = output .. table.concat(data, '\n')
    --           end,
    --           on_exit = function(j, return_code)
    --             output = output .. '\nJob finished with return code: ' .. return_code
    --           end,
    --         })
    --         :sync()
    --       return output
    --     end,
    --   },
    -- },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = 'make',
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'echasnovski/mini.pick', -- for file_selector provider mini.pick
    'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
    'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
    'ibhagwan/fzf-lua', -- for file_selector provider fzf
    'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
    'zbirenbaum/copilot.lua', -- for providers='copilot'
    {
      -- support for image pasting
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    -- {
    --   -- Make sure to set this up properly if you have lazy=true
    --   'MeanderingProgrammer/render-markdown.nvim',
    --   opts = {
    --     file_types = { 'markdown', 'Avante' },
    --   },
    -- ft = { 'markdown', 'Avante' },
    -- },
  },
}
