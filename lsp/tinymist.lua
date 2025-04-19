---@type vim.lsp.Config
return {
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
