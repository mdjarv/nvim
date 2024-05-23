return {
  'ray-x/go.nvim',
  commit='591a0b8',
  dependencies = { -- optional packages
    'ray-x/guihua.lua',
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('go').setup()
    require('which-key').register {
      ['<leader>G'] = { name = '[G]o', _ = 'which_key_ignore' },
    }
  end,
  event = { 'CmdlineEnter' },
  ft = { 'go', 'gomod' },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  keys = {
    { '<leader>Gc', '<cmd>GoCmt<cr>', desc = 'Comment' },
  },
}
