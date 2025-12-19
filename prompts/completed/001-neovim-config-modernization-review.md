<objective>
Conduct a comprehensive review of this Neovim configuration to identify modernization opportunities, UX/DX improvements, and aesthetic enhancements.

This review should produce actionable recommendations that can be implemented to make the Neovim experience faster, more intuitive, visually appealing, and aligned with current best practices in the Neovim ecosystem.
</objective>

<context>
This is a kickstart.nvim-based configuration with extensive custom plugins in `lua/custom/plugins/`. The config uses lazy.nvim for plugin management.

Key areas to examine:
- `lua/kickstart/` - Base kickstart plugins (note: prefer not modifying these)
- `lua/custom/plugins/` - Custom plugin configurations
- `init.lua` - Main entry point
- Overall architecture and plugin choices

Read AGENTS.md first for project conventions and constraints.
</context>

<research>
Before making recommendations, thoroughly analyze:

1. **Current State Inventory**
   - Read init.lua and understand the bootstrap flow
   - Examine all files in lua/custom/plugins/ to understand current plugin choices
   - Note which plugins handle: completion, LSP, UI, git, navigation, AI assistance

2. **Reference Configurations**
   - Read the latest kickstart.nvim from ~/git/kickstart.nvim/ (local clone)
   - Compare current config against kickstart.nvim's latest patterns and plugin choices
   - Fetch and review LunarVim's structure for inspiration: https://github.com/LunarVim/LunarVim
   - Note any patterns, plugins, or UX ideas from LunarVim that could improve this config

3. **Modern Neovim Ecosystem Research**
   - Identify plugins that have been superseded by better alternatives (2024-2025 standards)
   - Look for native Neovim features (0.10+) that could replace plugins
   - Check if current plugin versions are significantly outdated in their configs

4. **Performance Considerations**
   - Identify plugins that could benefit from lazy-loading improvements
   - Look for redundant functionality across plugins
   - Check startup time optimization opportunities
</research>

<analysis_requirements>

**Category 1: Plugin Modernization**
- Which plugins have better modern alternatives?
- Which plugin configs are using deprecated options or patterns?
- Are there redundant plugins doing similar things?
- What new plugins would significantly improve the experience?

**Category 2: UI/UX Improvements**
- Color scheme and visual consistency
- Status line, bufferline, and window decorations
- Notifications and messages (noice.nvim usage)
- Dashboard and startup experience
- Floating windows, borders, transparency

**Category 3: Developer Experience**
- Keybinding organization and discoverability
- LSP configuration optimization
- Completion experience (blink.cmp setup)
- Diagnostics presentation
- Git workflow integration
- Terminal and shell integration

**Category 4: Navigation & Productivity**
- File finding and fuzzy search (fzf setup)
- Code navigation (harpoon, marks, jumps)
- Window and buffer management
- Project/workspace management

**Category 5: Modern Neovim Features**
- Native features in Neovim 0.10+ that could replace plugins
- Lua API improvements that simplify configs
- Built-in LSP enhancements

</analysis_requirements>

<output_format>
Create a comprehensive review document saved to: `./docs/config-review.md`

Structure the document as:

```markdown
# Neovim Configuration Review

## Executive Summary
[3-5 key findings and highest-impact recommendations]

## Current State Assessment
[Brief overview of the current config architecture]

## Recommendations

### High Priority (Significant Impact)
[Changes that would noticeably improve experience]
- Issue: [what's suboptimal]
- Recommendation: [specific change]
- Implementation: [brief how-to or file reference]

### Medium Priority (Quality of Life)
[Nice-to-have improvements]

### Low Priority (Polish)
[Minor enhancements when time permits]

## Plugin Audit
[Table or list of current plugins with status: keep/update/replace/remove]

## Quick Wins
[Changes that can be made immediately with minimal effort]

## Implementation Roadmap
[Suggested order to implement changes]
```
</output_format>

<constraints>
- Do not modify any files during this review - this is analysis only
- Respect that lua/kickstart/ files should generally not be modified
- Focus on practical, implementable recommendations
- Consider the existing AI integration plugins (copilot, avante, codecompanion, aider, claude-code, mcphub) as intentional and important
- Recommendations should work with the existing lazy.nvim architecture
</constraints>

<verification>
Before completing, verify:
- All plugin files in lua/custom/plugins/ have been examined
- Recommendations are specific and actionable, not vague
- Each recommendation includes the relevant file path
- The review covers all five analysis categories
- Quick wins are truly quick (< 5 minutes each)
</verification>

<success_criteria>
- Comprehensive review document created at ./docs/config-review.md
- At least 3 high-priority recommendations with clear implementation paths
- Plugin audit covers all custom plugins
- Recommendations reflect 2024-2025 Neovim ecosystem best practices
- Document is well-organized and actionable
</success_criteria>
