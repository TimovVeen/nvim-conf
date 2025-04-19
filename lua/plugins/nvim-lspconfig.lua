return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'j-hui/fidget.nvim', opts = {} },
    'saghen/blink.cmp',
  },
  config = function()

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspAttach', { clear = true }),
      callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method('textDocument/completion') then
          vim.lsp.completion.enable(true, client.id, args.buf)
        end

        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = vim.api.nvim_create_augroup('UserLspAttach', {clear=false}),
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
            end,
          })
        end

        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = args.buf, desc = 'LSP: ' .. desc })
        end

        if client:supports_method('textDocument/inlayHint') then
          map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = args.buf })
            end, '[T]oggle Inlay [H]ints')
        end

        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

        map('fr', require('fzf-lua').lsp_references, 'Find references')
        map('fd', require('fzf-lua').lsp_definitions, 'Find definitions')
        map('fc', require('fzf-lua').lsp_declarations, 'Find declarations')
        map('ft', require('fzf-lua').lsp_typedefs, 'Find typedefs')
        map('fi', require('fzf-lua').lsp_implementations, 'Find implementations')
        map('fa', require('fzf-lua').lsp_code_actions, 'Find code actions')
      end,
    })

  end,
}
