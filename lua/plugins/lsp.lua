return { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Useful status updates for LSP.
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim',    opts = {} },

    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          -- Load luvit types when the `vim.uv` word is found
          { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        },
      },
    },
    { 'Bilal2453/luvit-meta', lazy = true },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = event.buf,
          callback = function()
            vim.lsp.buf.format { async = false, id = event.data.client_id }
          end,
        })
        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    local lspconfig = require 'lspconfig'

    lspconfig.clangd.setup { capabilities = capabilities }
    lspconfig.pylsp.setup {
      capabilities = capabilities,
      settings = {
        pylsp = {
          plugins = {
            black = { enabled = true },
            autopep8 = { enabled = false },
            yapf = { enabled = false },
            -- linter options
            pylint = { args = { '--ignore=C0114,C0115,C0116', '-' }, enabled = true, executable = 'pylint' },
            pyflakes = { enabled = false },
            pycodestyle = { enabled = false },
            mccabe = { enabled = false },
            -- type checker
            pylsp_mypy = { enabled = false },
            -- auto-completion options
            jedi_completion = { fuzzy = true },
            -- import sorting
            pyls_isort = { enabled = true },
          },
        },
      },
    }

    lspconfig.lua_ls.setup {
      capabilities = capabilities,
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
          -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          -- diagnostics = { disable = { 'missing-fields' } },
        },
      },
    }

    lspconfig.julials.setup { capabilities = capabilities }

    lspconfig.texlab.setup {
      capabilities = capabilities,
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

    lspconfig.tinymist.setup {
      capabilities = capabilities,
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
  end,
}
