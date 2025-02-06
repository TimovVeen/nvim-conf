return {
  'nvim-neorg/neorg',
  lazy = false,
  version = '*',
  config = function()
    require('neorg').setup {
      load = {
        ['core.defaults'] = {},
        ['core.concealer'] = {},
        ['core.dirman'] = {
          config = {
            workspaces = {
              notes = '~/notes',
              personal = '~/personal',
            },
            index = 'index.norg',
            default_workspace = 'notes',
          },
        },
        ['core.journal'] = {
          config = {
            workspace = 'personal',
          },
        },
        ['core.export'] = {},
        -- ['core.latex.renderer'] = {
        --   config = {
        --     debounce_ms = 300,
        --   },
        -- },
      },
    }
  end,
}
