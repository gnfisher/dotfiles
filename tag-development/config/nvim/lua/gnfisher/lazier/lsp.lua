-- LSP configuration with lazy loading
local M = {}

-- Common capabilities for all servers
local function make_capabilities()
  return vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities()
  )
end

-- Server-specific configurations
local servers = {
  lua_ls = {
    on_attach = function(client)
      client.server_capabilities.semanticTokensProvider = nil
    end,
    settings = {
      Lua = {
        runtime = { version = "Lua 5.1" },
        diagnostics = {
          globals = { "vim", "it", "describe", "before_each", "after_each" },
        }
      }
    }
  },
  gopls = {
  },
  ts_ls = {
    on_attach = function(client)
      -- Disable formatting in favor of eslint
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      client.server_capabilities.semanticTokensProvider = nil
    end
  },
  eslint = {
    on_attach = function(client, bufnr)
      client.server_capabilities.semanticTokensProvider = nil
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
    settings = {
      format = { enable = true },
    }
  }
}

-- Keybinding setup
local function setup_buffer_keymaps(bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }

  vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<Leader>a", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<Leader>sd", require('telescope.builtin').lsp_document_symbols, opts)
  vim.keymap.set("n", "<Leader>sw", require('telescope.builtin').lsp_dynamic_workspace_symbols, opts)

  -- Diagnostic navigation
  vim.keymap.set('n', ']d', function()
    vim.diagnostic.goto_next({ float = false })
    require('echo-diagnostics').echo_line_diagnostic()
  end, opts)

  vim.keymap.set('n', '[d', function()
    vim.diagnostic.goto_prev({ float = false })
    require('echo-diagnostics').echo_line_diagnostic()
  end, opts)
end

-- Return plugin spec for lazy.nvim
return {
  {
    'seblj/nvim-echo-diagnostics',
    event = "VeryLazy",
    config = function()
      vim.api.nvim_create_autocmd("CursorHold", {
        pattern = "*",
        callback = function()
          require('echo-diagnostics').echo_line_diagnostic()
        end
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    ft = { "lua", "typescript", "javascript", "go" }, -- specific filetypes
    config = function()
      -- Core LSP setup
      local capabilities = make_capabilities()

      -- Initialize Mason first
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })

      -- Configure Mason-LSPConfig
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = true,
      })

      -- Set up autocommand for LSP attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Setup buffer-local keymaps
          setup_buffer_keymaps(ev.buf)

          -- Set up formatting on save
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = ev.buf,
            callback = function()
              vim.lsp.buf.format({ async = false })
              -- Ensure diagnostics persist after format
              vim.defer_fn(function()
                vim.diagnostic.show(nil, ev.buf)
              end, 100)
            end
          })
        end
      })

      -- Lazy load server setups
      local lspconfig = require("lspconfig")
      for server_name, server_opts in pairs(servers) do
        server_opts = vim.tbl_deep_extend("force", {
          capabilities = capabilities,
        }, server_opts or {})

        lspconfig[server_name].setup(server_opts)
      end
    end
  }
}
