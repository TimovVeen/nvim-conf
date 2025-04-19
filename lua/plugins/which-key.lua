return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.opt.timeoutlen
    delay = 200,
    icons = {
      -- set icon mappings to true if you have a Nerd Font
      mappings = vim.g.have_nerd_font,
      keys = {},
    },

    -- Document existing key chains
    spec = {
      { 'f',         group = '[F]ind' },
      { '<leader>f', group = '[F]iles' },
      { '<leader>g', group = '[G]it',  mode = { 'n', 'v' } },
    },

    triggers = {
      { "<auto>", mode = "nxso" },
      { "f",      mode = { "n", "v" } },
    },
  },
}
