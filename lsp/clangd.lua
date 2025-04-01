---@type vim.lsp.Config
return {
  cmd = { "clangd", "--background-index", "--clang-tidy" },
  root_markers = { ".clang-format", "compile_commands.json", "compile_flags.txt", ".git/" },
  filetypes = { "c", "cpp" },
}
