return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  init = function() vim.g.barbar_auto_setup = false end,
  opts = {
    animation = false,
    auto_hide = 1,
    focus_on_close = 'previous'
    -- insert_at_start = true,
    -- …etc.
  },
}
