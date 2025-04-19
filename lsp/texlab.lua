---@type vim.lsp.Config
return {
  settings = {
    texlab = {
      build = {
        executable = 'tectonic',
        args = { '-X', 'compile', '%f', '--untrusted', '--synctex', '--keep-logs', '--keep-intermediates' },
        onSave = true,
      },
      latexindent = {
        modifyLineBreaks = true,
      },
      chktex = {
        onOpenAndSave = true,
      },
      -- forwardSearch = {
      --   executable = 'zathura',
      --   args = '%f',
      -- },
    },
  },
}
