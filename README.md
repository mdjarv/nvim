# Personal Neovim Configuration

Modular Neovim configuration based on kickstart.nvim, extended with custom plugins and keybindings.

## Structure

```
~/.config/nvim/
├── init.lua                 # Core settings, keymaps, and base plugins
├── lua/
│   ├── kickstart/plugins/   # Kickstart-provided plugins
│   │   ├── autopairs.lua
│   │   ├── debug.lua
│   │   ├── gitsigns.lua
│   │   ├── indent_line.lua
│   │   ├── lint.lua
│   │   └── neo-tree.lua
│   └── custom/plugins/      # Custom plugin configurations
│       ├── snacks.lua       # Dashboard, picker, notifications, git
│       ├── copilot.lua      # GitHub Copilot with smart blacklisting
│       ├── harpoon.lua      # Quick file navigation
│       ├── oil.lua          # File explorer
│       ├── trouble.lua      # Diagnostics list
│       ├── test.lua         # Neotest with Go support
│       ├── lualine.lua      # Statusline
│       └── ...
```

## Features

### Core
- **Leader**: Space
- **Theme**: Catppuccin (transparent background)
- **Plugin Manager**: lazy.nvim

### Navigation
- **Snacks Picker**: `<leader><space>` smart find, `<leader>sf` files, `<leader>sg` grep
- **Harpoon**: `<leader>h` menu, `<C-1>` to `<C-4>` quick select
- **Oil**: `-` opens file explorer

### LSP & Completion
- **Mason**: Auto-installs LSP servers
- **Languages**: Go, TypeScript, Lua, JSON, YAML with schema support
- **Completion**: nvim-cmp with Copilot integration
- **Formatting**: conform.nvim with format-on-save

### Git
- **Gitsigns**: Inline blame, hunk navigation
- **Snacks Git**: `<leader>gg` lazygit, `<leader>gs` status, `<leader>gl` log

### Testing
- **Neotest**: `<leader>tn` nearest, `<leader>tf` file, `<leader>td` debug

### AI
- **Copilot**: Enabled with security blacklist for sensitive files

## Key Bindings

| Key | Action |
|-----|--------|
| `<leader><space>` | Smart file finder |
| `<leader>sg` | Grep |
| `<leader>/` | Comment toggle |
| `<leader>f` | Format buffer |
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover documentation |
| `<leader>cr` | Rename symbol |
| `<leader>gg` | Lazygit |
| `<leader>z` | Zen mode |
| `<C-/>` | Terminal |

## Requirements

- Neovim >= 0.9
- Git
- ripgrep
- A Nerd Font
- Node.js (for TypeScript LSP)
- Go (for Go development)
