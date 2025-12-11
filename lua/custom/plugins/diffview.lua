return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewFileHistory' },
  keys = {
    { '<leader>gv', '<cmd>DiffviewOpen<cr>', desc = 'Diffview Open' },
    { '<leader>gV', '<cmd>DiffviewClose<cr>', desc = 'Diffview Close' },
    { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'File History (current)' },
    { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = 'File History (repo)' },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      merge_tool = {
        layout = 'diff3_mixed',
      },
    },
  },
}
