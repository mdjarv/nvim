return {
  'fedepujol/move.nvim',
  keys = {
    { '<A-j>', ':MoveLine(1)<CR>' },
    { '<A-k>', ':MoveLine(-1)<CR>' },
    { '<A-h>', ':MoveHChar(-1)<CR>' },
    { '<A-l>', ':MoveHChar(1)<CR>' },
    { '<leader>wb', ':MoveWord(-1)<CR>' },
    { '<leader>wf', ':MoveWord(1)<CR>' },
    { '<A-j>', ':MoveBlock(1)<CR>', mode = 'v' },
    { '<A-k>', ':MoveBlock(-1)<CR>', mode = 'v' },
    { '<A-h>', ':MoveHBlock(-1)<CR>', mode = 'v' },
    { '<A-l>', ':MoveHBlock(1)<CR>', mode = 'v' },
  },
  config = true,
}
