---@type vim.lsp.Config
return {
  cmd = { "texlab" },
  root_markers = { "main.tex" },
  filetypes = { "tex", "plaintex", "bib" },
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
