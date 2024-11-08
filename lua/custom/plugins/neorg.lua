return {
  'nvim-neorg/neorg',
  enabled = false,
  build = false, -- disable the build script that currently uses luarocks.nvim
  opts = {
    load = {
      ['core.defaults'] = {},
      ['core.concealer'] = {
        config = {
          init_open_folds = 'always',
        },
      },
      ['core.dirman'] = {
        config = {
          workspaces = {
            notes = '~/notes',
          },
          default_workspace = 'notes',
        },
      },
      ['core.presenter'] = {
        config = {
          zen_mode = 'zen-mode',
        },
      },
    },
  },
}
