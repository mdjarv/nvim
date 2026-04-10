vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- [[ Setting options ]]

vim.g.sleuth__defaults = 'shiftwidth=4'
vim.opt.tabstop = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'

vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.wrap = false
vim.opt.confirm = true
vim.opt.foldlevel = 99
vim.opt.conceallevel = 0
vim.wo.foldlevel = 99
vim.wo.conceallevel = 0

-- [[ Basic Keymaps ]]

vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.diagnostic.config {
  severity_sort = true,
  underline = true,
  virtual_text = { spacing = 4, prefix = '●' },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.HINT] = '',
      [vim.diagnostic.severity.INFO] = '',
    },
  },
  update_in_insert = true,
  float = {
    border = 'rounded',
    format = function(diagnostic)
      local msg = diagnostic.message
      if diagnostic.source then
        msg = msg .. '\n\nSource: ' .. diagnostic.source
      end
      if diagnostic.code then
        msg = msg .. '\nCode: ' .. tostring(diagnostic.code)
      end
      return msg
    end,
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1 }
end, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1 }
end, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>ce', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics [q]uickfix (buffer)' })
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist, { desc = 'Diagnostics [Q]uickfix (all)' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Split navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-M-h>', '<cmd>vertical resize -2<cr>', { desc = 'Shrink window width' })
vim.keymap.set('n', '<C-M-l>', '<cmd>vertical resize +2<cr>', { desc = 'Grow window width' })
vim.keymap.set('n', '<C-M-j>', '<cmd>resize +2<cr>', { desc = 'Grow window height' })
vim.keymap.set('n', '<C-M-k>', '<cmd>resize -2<cr>', { desc = 'Shrink window height' })

-- Move lines
vim.keymap.set('n', '<M-S-j>', ':m .+1<CR>==') -- move line down(n)
vim.keymap.set('n', '<M-S-k>', ':m .-2<CR>==') -- move line up(n)
vim.keymap.set('v', '<M-S-j>', ":m '>+1<CR>gv=gv") -- move line down(v)
vim.keymap.set('v', '<M-S-k>', ":m '<-2<CR>gv=gv") -- move line up(v)

-- Better indent
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })

-- Insert UUID
vim.keymap.set('i', '<M-u>', '<c-r>=trim(system("uuidgen"))<cr>', { desc = 'Insert UUID' })
vim.keymap.set('n', '<M-u>', 'i<c-r>=trim(system("uuidgen"))<cr><esc>', { desc = 'Insert UUID' })
vim.keymap.set('v', '<M-u>', 'c<c-r>=trim(system("uuidgen"))<cr><esc>', { desc = 'Insert UUID' })

-- [[ Autocommands ]]

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ lazy.nvim ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Plugins ]]
require('lazy').setup({
  'tpope/vim-sleuth',

  {
    'numToStr/Comment.nvim',
    opts = {
      toggler = {
        line = '<leader>/',
      },
      opleader = {
        line = '<leader>/',
      },
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'right_align',
        delay = 500,
        ignore_whitespace = true,
        virt_text_priority = 100,
        use_focus = true,
      },
    },
  },

  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()

      require('which-key').add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>c_', hidden = true },
        { '<leader>h', group = 'Git [H]unk' },
        { '<leader>h_', hidden = true },
        { '<leader>r', group = '[R]ename' },
        { '<leader>r_', hidden = true },
        { '<leader>s', group = '[S]earch' },
        { '<leader>s_', hidden = true },
        { '<leader>T', group = '[T]oggle' },
        { '<leader>T_', hidden = true },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>w_', hidden = true },
        { '<leader>h', desc = 'Git [H]unk', mode = 'v' },
        { '<leader>lr', ':LspRestart<cr>', desc = 'Restart LSP', mode = 'n' },
      }
    end,
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', config = true },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      { 'j-hui/fidget.nvim', opts = {} },
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- LSP navigation keymaps handled by Snacks.picker in snacks.lua
          map('<leader>cr', vim.lsp.buf.rename, '[R]e[n]ame')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true)
            map('<leader>Th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local servers = {
        gopls = {},
        rust_analyzer = {},
        tailwindcss = {},
        ts_ls = {},
        jsonls = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              schemas = require('schemastore').yaml.schemas {
                extra = {
                  {
                    name = '.github/workflows/*.yaml',
                    description = 'GitHub workflow file',
                    url = 'https://json.schemastore.org/github-workflow.json',
                    fileMatch = { '/.github/workflows/*' },
                  },
                  {
                    name = 'kubernetes',
                    description = 'Kubernetes configuration file',
                    url = 'https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json',
                    fileMatch = { '/*.k8s.yaml' },
                  },
                  {
                    name = 'kustomization',
                    description = 'Kustomize configuration file',
                    url = 'https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/kustomization.json',
                    fileMatch = { 'kustomization.yaml' },
                  },
                },
              },
              schemaStore = {
                enable = false,
                url = '',
              },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      require('mason').setup {
        registries = {
          'github:mason-org/mason-registry',
        },
        ui = {
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'eslint_d',
        'prettierd',
        'goimports',
        'gofumpt',
        'gomodifytags',
        'impl',
        'delve',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  {
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      formatters = {
        sqlfluff = {
          args = { 'format', '-' },
        },
      },
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 15000,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        sql = { 'sqlfluff' },
        markdown = { 'prettierd', 'prettier', stop_after_first = true },
      },
    },
  },

  {
    'catppuccin/nvim',
    enabled = true,
    name = 'catppuccin',
    priority = 1000,
    opts = {
      transparent_background = true,
      custom_highlights = function(colors)
        return {
          Pmenu = { bg = colors.base },
          NormalFloat = { bg = colors.base },
        }
      end,
    },
    init = function()
      vim.cmd.colorscheme 'catppuccin'
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false, -- main branch does not support lazy-loading
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup()

      -- Parsers to keep installed. Main branch has no auto_install, so list
      -- everything explicitly. install() is a no-op for already-installed parsers.
      local parsers = {
        'bash',
        'c',
        'commonlisp',
        'css',
        'csv',
        'diff',
        'dockerfile',
        'fish',
        'gdscript',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'git_rebase',
        'go',
        'gomod',
        'html',
        'hyprlang',
        'ini',
        'javascript',
        'json',
        'just',
        'lua',
        'luadoc',
        'make',
        'markdown',
        'markdown_inline',
        'pem',
        'python',
        'qmljs',
        'query',
        'rust',
        'sql',
        'tmux',
        'toml',
        'tsx',
        'typescript',
        'vhs',
        'vim',
        'vimdoc',
        'yaml',
      }
      require('nvim-treesitter.install').install(parsers)

      -- Enable highlight + indent on FileType for any installed parser.
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          if not pcall(vim.treesitter.start, args.buf) then
            return
          end
          -- Ruby's TS indent is broken; keep vim regex indent + extra regex highlight.
          if ft == 'ruby' then
            vim.bo[args.buf].syntax = 'ON'
            return
          end
          vim.bo[args.buf].indentexpr = 'v:lua.require"nvim-treesitter".indentexpr()'
        end,
      })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    lazy = false,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter-textobjects').setup {
        select = { enable = true, lookahead = true },
        move = { enable = true, set_jumps = true },
      }

      local select = require 'nvim-treesitter-textobjects.select'
      local move = require 'nvim-treesitter-textobjects.move'

      vim.keymap.set({ 'x', 'o' }, 'af', function()
        select.select_textobject('@function.outer', 'textobjects')
      end, { desc = 'Select outer function' })
      vim.keymap.set({ 'x', 'o' }, 'if', function()
        select.select_textobject('@function.inner', 'textobjects')
      end, { desc = 'Select inner function' })
      vim.keymap.set({ 'x', 'o' }, 'aa', function()
        select.select_textobject('@parameter.outer', 'textobjects')
      end, { desc = 'Select outer parameter' })
      vim.keymap.set({ 'x', 'o' }, 'ia', function()
        select.select_textobject('@parameter.inner', 'textobjects')
      end, { desc = 'Select inner parameter' })

      vim.keymap.set({ 'n', 'x', 'o' }, ']a', function()
        move.goto_next_start('@parameter.outer', 'textobjects')
      end, { desc = 'Next parameter start' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[a', function()
        move.goto_previous_start('@parameter.outer', 'textobjects')
      end, { desc = 'Previous parameter start' })
    end,
  },

  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns',

  { import = 'custom.plugins' },
}, {
  change_detection = {
    enable = false,
  },
  install = {
    colorscheme = { 'catppuccin' },
  },
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
