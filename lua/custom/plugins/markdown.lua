return {
  'MeanderingProgrammer/render-markdown.nvim',
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    file_types = { 'markdown', 'copilot-chat', 'Avante' },
    checkbox = {
      unchecked = {
        -- A clean, empty square for an unchecked state.
        -- (Font Awesome: fa-square-o)
        icon = ' ',
        highlight = 'RenderMarkdownUnchecked',
        scope_highlight = nil,
      },
      checked = {
        -- A clear checkmark inside a square for a checked state.
        -- (Font Awesome: fa-check-square)
        icon = ' ',
        highlight = 'RenderMarkdownChecked',
        scope_highlight = nil,
      },
      custom = {
        cancelled = {
          -- For items that have been deliberately cancelled or struck off.
          raw = '[~]',
          rendered = ' ',
          highlight = 'RenderMarkdownError',
          scope_highlight = nil,
        },
        important = {
          -- For items that require immediate attention or are critical.
          raw = '[!]',
          rendered = ' ',
          highlight = 'RenderMarkdownWarn',
          scope_highlight = nil,
        },
        later = {
          -- For items deferred to a later time or to be revisited.
          raw = '[>]',
          rendered = ' ',
          highlight = 'RenderMarkdownInfo',
          scope_highlight = nil,
        },
        question = {
          -- For items that need clarification, are uncertain, or require a decision.
          raw = '[?]',
          rendered = ' ',
          highlight = 'RenderMarkdownInfo',
          scope_highlight = nil,
        },
        in_progress = {
          -- For tasks that are actively being worked on.
          raw = '[/]',
          rendered = ' ',
          highlight = 'RenderMarkdownInfo',
          scope_highlight = nil,
        },
      },
    },
  },
  ft = { 'markdown', 'copilot-chat', 'Avante' },
}
