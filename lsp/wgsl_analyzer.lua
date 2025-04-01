---@type vim.lsp.Config
return {
  cmd = { "wgsl-analyzer" },
  root_markers = { "Cargo.toml", "Cargo.lock" },
  filetypes = { "wgsl" },
}
