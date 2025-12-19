-- Copilot blacklist for sensitive files
local copilot_blacklist = {
  -- File extensions
  '*.pem',
  '*.key',
  '*.p12',
  '*.pfx',
  '*.crt',
  '*.cer',
  '*.der',
  '*.jks',
  '*.keystore',

  -- Specific filenames
  '*id_rsa*',
  '*id_dsa*',
  '*id_ecdsa*',
  '*id_ed25519*',
  '*/.ssh/*',
  '*/.aws/credentials',
  '*/.aws/config',
  '*.env*',
  '*secrets*',
  '*password*',
  '*token*',
  '.env',
  '.env.*',
}

return {
  {
    'zbirenbaum/copilot.lua',
    enabled = false,
    dependencies = {
      'nvim-lualine/lualine.nvim',
    },
    cmd = 'Copilot',
    event = 'InsertEnter',
    build = ':Copilot auth',
    config = function()
      require('copilot').setup {
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          ['*'] = function()
            local buf_name = vim.api.nvim_buf_get_name(0)

            -- If buffer has no name, allow copilot
            if buf_name == '' then
              return true
            end

            -- Get just the filename and full path for checking
            local filename = vim.fs.basename(buf_name)
            local full_path = buf_name

            -- Check against blacklist first (early exit)
            for _, pattern in ipairs(copilot_blacklist) do
              -- Check both filename and full path against glob pattern
              if vim.fn.match(filename, pattern) ~= -1 or vim.fn.match(full_path, pattern) ~= -1 then
                return false -- Disable copilot for blacklisted files
              end
            end

            -- Check if we're in a git repository
            local git_check = io.popen 'git rev-parse --is-inside-work-tree 2>/dev/null'
            local is_git_repo = git_check:read('*a'):match 'true'
            git_check:close()

            if not is_git_repo then
              -- Not in a git repository, allow copilot
              return true
            end

            -- Check if file is ignored by git
            local git_ignore_check = io.popen('git check-ignore "' .. buf_name .. '" 2>/dev/null')
            local is_ignored = git_ignore_check:read '*a' ~= ''
            git_ignore_check:close()

            -- Disable copilot for ignored files
            return not is_ignored
          end,
        },
        copilot_model = 'gpt-5-mini',
      }
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    enabled = false,
    dependencies = { 'zbirenbaum/copilot.lua' },
    config = function()
      require('copilot_cmp').setup()
      vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })
    end,
  },
  -- {
  --   'AndreM222/copilot-lualine',
  --   dependencies = {
  --     'zbirenbaum/copilot.lua',
  --     'nvim-lualine/lualine.nvim',
  --   },
  -- },
}
