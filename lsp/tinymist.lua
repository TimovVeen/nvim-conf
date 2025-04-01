---@type vim.lsp.Config
return {
  cmd = { "tinymist" },
  root_markers = { ".git/" },
  filetypes = { "typst" },
  settings = {
    exportPdf = 'onSave',
    outputPath = '$root/out/$name',
    formatterMode = 'typstyle',
    previewFeature = 'disable',
    completion = {
      triggerOnSnippetPlaceholders = true,
    },
  },
}
