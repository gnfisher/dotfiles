vim.lsp.set_log_level("debug")
local status_ok, config = pcall(require, "lspconfig")
if not status_ok then
  return
end

local status_ok, telescope = pcall(require, "telescope.builtin")
if not status_ok then
  return
end

-- Mappings.
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gd', telescope.lsp_definitions, bufopts)
  vim.keymap.set('n', 'gi', telescope.lsp_implementations, bufopts)
  vim.keymap.set('n', 'gR', telescope.lsp_references, bufopts)

  vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '==', vim.lsp.buf.formatting, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)

  -- Glory to the mouse.
  vim.api.nvim_set_keymap('n', '<LeftMouse>', '<LeftMouse><cmd>lua vim.lsp.buf.hover({border = "single"})<CR>', { noremap=true, silent=true })
  vim.api.nvim_set_keymap('n', '<C-LeftMouse>', '<LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>', { noremap=true, silent=true })

  if vim.fn.executable('vscode-eslint-language-server') == 1 then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end
end

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Give some borders to the hover/documentation popup
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "single",
})

if vim.fn.executable('elm-language-server') == 1 then
  config.elmls.setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end

if vim.fn.executable('gopls') == 1 then
  config.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end

if vim.fn.executable('golangci-lint-langserver') == 1 then
  config.golangci_lint_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end

if vim.fn.executable('vscode-html-language-server') == 1 then
  config.html.setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end

if vim.fn.executable('vscode-json-language-server') == 1 then
  config.jsonls.setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end

if vim.fn.executable('vscode-eslint-language-server') == 1 then
  config.eslint.setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end

if vim.fn.executable('tsserver') == 1 then
  config.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

if vim.fn.executable('srb') == 1 then
  config.sorbet.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "srb", "tc", "--lsp" }
  }
end

if vim.fn.executable('lua-language-server') == 1 then
  config.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }
end
