# Neovim Configuration Review

*Generated: December 2024*

## Executive Summary

1. **Migrate from nvim-cmp to blink.cmp** - Latest kickstart.nvim uses blink.cmp. Your config has nvim-cmp active with blink.lua commented out. blink.cmp offers better performance, rust fuzzy matching, and simpler configuration.

2. **Consolidate fuzzy finder stack** - Telescope, fzf-lua (disabled), Snacks.picker, and mini.pick all configured. Snacks.picker handles most keymaps but Telescope still loads for LSP mappings. Commit to Snacks.picker fully.

3. **Redundant statuslines** - Both lualine AND mini.statusline configured. Pick one (lualine recommended given your customizations).

4. **Deprecated vim.loop usage** - `vim.loop` deprecated for `vim.uv` (Neovim 0.10+). Found in `init.lua:184` and `lualine.lua:100`.

5. **Dead code accumulation** - Multiple files contain only commented code (bufferline.lua, blink.lua, noice.lua) or disabled plugins. Clean these up for maintainability.

## Current State Assessment

### Architecture Overview
```
init.lua (1180 lines)
├── Options & Keymaps
├── Diagnostic Config
├── lazy.nvim Bootstrap
├── Core Plugins (inline)
│   ├── vim-sleuth
│   ├── Comment.nvim
│   ├── gitsigns.nvim
│   ├── which-key.nvim
│   ├── telescope.nvim (+ fzf-native, ui-select)
│   ├── nvim-lspconfig (+ mason, lazydev)
│   ├── conform.nvim
│   ├── nvim-cmp (+ luasnip, lspkind)
│   ├── catppuccin (colorscheme)
│   └── nvim-treesitter
└── Import: custom.plugins/
```

### Plugin Inventory by Category

| Category | Active Plugins | Disabled/Commented |
|----------|---------------|-------------------|
| **Completion** | nvim-cmp | blink.cmp |
| **Fuzzy Finder** | Telescope, Snacks.picker, mini.pick | fzf-lua |
| **Statusline** | lualine, mini.statusline | - |
| **Bufferline** | mini.tabline | bufferline.nvim |
| **File Explorer** | neo-tree, oil.nvim | mini.files |
| **Git** | gitsigns, git-conflict, diffview, Snacks.lazygit | fugitive |
| **AI** | claude-code, opencode, llm.nvim | copilot, avante, codecompanion, aider, mcphub |
| **Dashboard** | Snacks.dashboard | dashboard-nvim |
| **Notifications** | Snacks.notifier | noice.nvim |
| **Zen/Focus** | zen-mode.nvim, Snacks.zen | - |

---

## Recommendations

### High Priority (Significant Impact)

#### 1. Migrate to blink.cmp

**Issue**: nvim-cmp is legacy; kickstart.nvim and most modern configs use blink.cmp.

**File**: `init.lua:779-995`, `lua/custom/plugins/blink.lua`

**Implementation**:
1. Add `enabled = false` to nvim-cmp block in `init.lua:779`
2. Replace `blink.lua` contents:

```lua
return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    { 'L3MON4D3/LuaSnip', version = '2.*' },
    'folke/lazydev.nvim',
  },
  opts = {
    keymap = {
      preset = 'default',
      ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
    },
    appearance = { nerd_font_variant = 'mono' },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },
    signature = { enabled = true },
  },
}
```

3. Update LSP capabilities in `init.lua:601-602`:
```lua
-- Before:
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

-- After:
local capabilities = require('blink.cmp').get_lsp_capabilities()
```

#### 2. Disable Telescope, Commit to Snacks.picker

**Issue**: Telescope loads at startup but Snacks.picker handles all your keymaps. Redundant.

**Files**: `init.lua:323-454`, `snacks.lua`

**Implementation**:
1. Add `enabled = false` to Telescope block in `init.lua:324`
2. Update LSP mappings in `init.lua:517-537` to use Snacks.picker (already overridden by snacks.lua keymaps)
3. Remove telescope builtin references from LSP attach

#### 3. Remove Redundant mini.statusline

**Issue**: Both lualine and mini.statusline configured. lualine has macro recording customization worth keeping.

**File**: `lua/custom/plugins/mini.lua:257-267`

**Implementation**: Delete mini.statusline setup:
```lua
-- DELETE lines 257-267:
local statusline = require 'mini.statusline'
statusline.setup { use_icons = vim.g.have_nerd_font }
statusline.section_location = function()
  return '%2l:%-2v'
end
```

Also delete `mini.pick` setup on line 372 (Snacks.picker is primary).

---

### Medium Priority (Quality of Life)

#### 4. Update Deprecated APIs

**Files**: `init.lua:184`, `lualine.lua:100`

```lua
-- init.lua:184
-- Before: vim.loop.fs_stat(lazypath)
-- After:  vim.uv.fs_stat(lazypath)

-- lualine.lua:100
-- Before: vim.loop.new_timer()
-- After:  vim.uv.new_timer()
```

#### 5. Enable fidget.nvim for LSP Progress

**Issue**: LSP progress notifications commented out.

**File**: `init.lua:466`

```lua
-- Uncomment:
{ 'j-hui/fidget.nvim', opts = {} },
```

#### 6. Add Missing Modern Options

**File**: `init.lua`

```lua
-- Add after line 77:
vim.opt.confirm = true  -- Ask to save instead of failing

-- Add to diagnostic.config around line 90:
vim.diagnostic.config {
  severity_sort = true,  -- Show errors before warnings
  -- ... existing config
}
```

#### 7. Consolidate Zen Mode

**Issue**: Both zen-mode.nvim and Snacks.zen available. Snacks.zen already bound to `<leader>z` in snacks.lua.

**File**: `lua/custom/plugins/zen.lua`

**Implementation**: Delete file entirely. Snacks.zen handles this.

#### 8. Update lazydev.nvim Configuration

**File**: `init.lua:470`

```lua
{
  'folke/lazydev.nvim',
  ft = 'lua',  -- Add ft
  opts = {
    library = {
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
  },
},
```

---

### Low Priority (Polish)

#### 9. Clean Up Harpoon Keybindings

**Issue**: Ctrl+1-4 conflicts with some terminals. Consider Alt or leader-based.

**File**: `lua/custom/plugins/harpoon.lua`

#### 10. Add Treesitter-Context

**Issue**: No sticky header showing current function/class.

**Implementation**: Add to custom plugins:
```lua
return {
  'nvim-treesitter/nvim-treesitter-context',
  event = 'BufReadPost',
  opts = {
    max_lines = 3,
  },
}
```

#### 11. Consider flash.nvim or leap.nvim

**Issue**: No enhanced motion plugin for quick jumping.

#### 12. Remove workspace-diagnostics.nvim Empty Config

**File**: `lua/custom/plugins/workspace_diagnostics.lua`

Currently just returns plugin name with no config. Either configure or remove.

---

## Plugin Audit

### Keep (Well Configured)
| Plugin | File | Notes |
|--------|------|-------|
| snacks.nvim | snacks.lua | Excellent all-in-one, 652 lines of config |
| lualine | lualine.lua | Good macro recording feature |
| trouble.nvim | trouble.lua | Nice Snacks integration |
| harpoon | harpoon.lua | Good harpoon2 config |
| diffview | diffview.lua | Well configured |
| tiny-code-action | codeactions.lua | Nice snacks picker integration |
| neotest | test.lua | Solid Go testing setup |
| render-markdown | markdown.lua | Good checkbox customization |
| git-conflict | git.lua | Useful for merge conflicts |
| todo-comments | todo.lua | Nice Snacks picker integration |
| oil.nvim | oil.lua | Simple file management |
| nvim-ufo | folding.lua | Modern folding |
| coerce.nvim | coerce.lua | Case conversion |
| typescript-tools | typescript.lua | Better than tsserver |
| go.nvim | go.lua | Go tooling |
| octo.nvim | octo.lua | GitHub integration |

### Update Configuration
| Plugin | File | Issue |
|--------|------|-------|
| mini.nvim | mini.lua | Remove statusline, pick |
| blink.cmp | blink.lua | Enable and configure |
| claude-code | claude-code.lua | Works, no changes needed |
| opencode | opencode.lua | Works, no changes needed |
| llm.nvim | llm.lua | Works, good FIM support |

### Delete (Commented/Disabled)
| File | Reason |
|------|--------|
| bufferline.lua | Entirely commented |
| noice.lua | Entirely commented |
| fzf.lua | Disabled, Snacks.picker used |
| dashboard.lua | Disabled, Snacks.dashboard used |
| zen.lua | Redundant with Snacks.zen |

### Consider Removing (Disabled)
| File | Reason |
|------|--------|
| copilot.lua | Disabled |
| avante.lua | Disabled |
| codecompanion.lua | Disabled |
| aider.lua | Disabled |
| mcphub.lua | Disabled |
| neorg.lua | Disabled |
| obsidian.lua | Disabled |
| sonarlint.lua | Disabled |

---

## Quick Wins (< 5 minutes each)

| Change | File:Line | Time |
|--------|-----------|------|
| Add `severity_sort = true` to diagnostics | init.lua:90 | 1 min |
| Add `vim.opt.confirm = true` | init.lua:78 | 1 min |
| Replace `vim.loop` with `vim.uv` | init.lua:184 | 1 min |
| Replace `vim.loop` with `vim.uv` | lualine.lua:100 | 1 min |
| Uncomment fidget.nvim | init.lua:466 | 1 min |
| Delete bufferline.lua | - | 30 sec |
| Delete noice.lua | - | 30 sec |
| Delete fzf.lua | - | 30 sec |
| Delete dashboard.lua | - | 30 sec |
| Delete zen.lua | - | 30 sec |

---

## Implementation Roadmap

### Phase 1: Quick Wins (Day 1)
1. Apply all quick wins listed above
2. Test config loads without errors
3. Run `:checkhealth`

### Phase 2: Completion Migration (Day 2)
1. Enable blink.cmp
2. Disable nvim-cmp
3. Update LSP capabilities
4. Test completion in various file types

### Phase 3: Picker Consolidation (Day 3)
1. Disable Telescope
2. Remove mini.pick
3. Verify all Snacks.picker keymaps work
4. Update any remaining Telescope references

### Phase 4: Cleanup (Day 4)
1. Delete disabled plugin files
2. Remove commented code blocks
3. Remove mini.statusline
4. Run stylua formatting

### Phase 5: Polish (Day 5+)
1. Consider treesitter-context
2. Evaluate motion plugins (flash/leap)
3. Review and update keybindings consistency

---

## Notes

### What's Working Well
- Snacks.nvim integration is comprehensive and well-configured
- AI plugin setup (claude-code, opencode, llm.nvim) is intentional and focused
- Catppuccin with transparency looks good
- Dashboard with git status is useful
- Incremental selection keymaps (CR/BS) are intuitive

### Potential Issues
- No explicit nil-ls/none-ls for additional linting (only eslint_d via nvim-lint)
- nvim-ts-autotag might conflict with typescript-tools JSX handling
- Large init.lua (1180 lines) could be modularized further

### Modern Features Not Utilized
- Neovim 0.10+ native snippets (using LuaSnip)
- `vim.lsp.buf.format()` synchronous option (using conform.nvim)
- `vim.keymap.del()` for conditional keymaps
