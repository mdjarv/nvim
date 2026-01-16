# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

- **Lint/Format**: `stylua --check .` (check) or `stylua .` (fix)
- **No test runner** - manual testing via `:Lazy reload` in Neovim

## Code Style (StyLua enforced)

- 2-space indentation, Unix line endings
- Single quotes preferred (`'string'`)
- No parentheses on single-arg function calls: `require 'module'`
- 160 char line width max

## Architecture

Based on kickstart.nvim with lazy.nvim plugin manager.

**Entry point**: `init.lua` - core settings, base plugins, and imports `lua/custom/plugins/`

**Plugin organization**:
- `lua/kickstart/plugins/` - Base kickstart plugins (avoid modifying)
- `lua/custom/plugins/` - Custom plugins (one plugin per file, auto-imported)

**Plugin file pattern**:
```lua
return {
  'author/plugin-name',
  event = 'VimEnter',  -- lazy loading trigger
  dependencies = { ... },
  opts = { ... },      -- preferred over config function
  keys = {
    { '<leader>x', '<cmd>Command<cr>', desc = 'Description' },
  },
}
```

## Conventions

- Plugin files: lowercase with hyphens (`git-conflict.lua`)
- Prefer `opts = {}` over `config = function()` when possible
- Group keymaps under `<leader>` prefix with which-key descriptions
- Leader key is `<space>`

## Key Plugins

| Category | Primary |
|----------|---------|
| UI | snacks.nvim (dashboard, picker, git, notifications), lualine |
| Completion | blink.cmp + minuet (ollama FIM) |
| LSP | nvim-lspconfig, mason, conform |
| AI Chat | codecompanion (ollama), claude-code |
| Testing | neotest with neotest-go |
| Git | gitsigns, snacks.git |
