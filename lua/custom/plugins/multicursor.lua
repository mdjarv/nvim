return {
  'mg979/vim-visual-multi',
  branch = 'master',
  init = function()
    -- C-n to select word / add next match (default)
    -- C-Down/Up to add cursors vertically
    -- n/N to get next/prev occurrence
    -- [/] to select next/prev cursor
    -- q to skip current and get next
    -- Q to remove current cursor
    vim.g.VM_maps = {
      ['Find Under'] = '<C-n>',
      ['Find Subword Under'] = '<C-n>',
      ['Add Cursor Down'] = '<C-Down>',
      ['Add Cursor Up'] = '<C-Up>',
    }
    vim.g.VM_theme = 'iceblue'
  end,
}
