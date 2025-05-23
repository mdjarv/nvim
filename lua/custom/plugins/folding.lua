return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  config = function()
    -- vim.opt.foldmethod = 'expr'
    --
    -- -- :h vim.treesitter.foldexpr()
    -- vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    --
    -- -- ref: https://github.com/neovim/neovim/pull/20750
    -- vim.opt.foldtext = ''
    -- vim.opt.fillchars:append 'fold: '
    --
    -- -- Open all folds by default, zm is not available
    -- vim.opt.foldlevelstart = 99

    require('ufo').setup {
      provider_selector = function()
        return { 'treesitter', 'indent' }
      end,
    }
  end,
}
