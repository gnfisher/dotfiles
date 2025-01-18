return {
  {
    'seblj/nvim-echo-diagnostics',
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
    tag = "v1.0.0",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },

    config = function()
      vim.diagnostic.config({
        signs = false,
        virtual_text = false,
        underline = true,
        float = false,
        severity_sort = true,
      })

      local util = require 'lspconfig.util'
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities()
      )

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "gopls",
          "ts_ls",
          "eslint",
        },
        handlers = {
          function(server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {
              capabilities = capabilities
            }
          end,

          ["lua_ls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup {
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime = { version = "Lua 5.1" },
                  diagnostics = {
                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                  }
                }
              }
            }
          end,
          ["golangci_lint_ls"] = function()
            require("lspconfig").golangci_lint_ls.setup {
              root_dir = function(fname)
                return util.root_pattern('go.mod')(fname)
              end,
            }
          end,
          ["ts_ls"] = function()
            require("lspconfig").ts_ls.setup {
              capabilities = capabilities,
              on_attach = function(client)
                -- Disable ts_ls formatting, using eslint
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
              end,
            }
          end,
          ["eslint"] = function()
            require("lspconfig").eslint.setup {
              capabilities = capabilities,
              on_attach = function(client, bufnr)
                vim.api.nvim_create_autocmd("BufWritePre", {
                  buffer = bufnr,
                  command = "EslintFixAll",
                })
              end,
              settings = {
                format = { enable = true },
              },
            }
          end,
        }
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(e)
          local opts = { buffer = e.buf }
          vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<Leader>ds", require('telescope.builtin').lsp_document_symbols)
          vim.keymap.set("n", "<Leader>ws", require('telescope.builtin').lsp_dynamic_workspace_symbols)

          vim.keymap.set('n', ']d', function()
            vim.diagnostic.goto_next({ float = false })
            require('echo-diagnostics').echo_line_diagnostic()
          end)

          vim.keymap.set('n', '[d', function()
            vim.diagnostic.goto_prev({ float = false })
            require('echo-diagnostics').echo_line_diagnostic()
          end)
          -- Create a command `:Format` local to the LSP buffer
          vim.api.nvim_buf_create_user_command(e.buf, "Format", function(_)
            vim.lsp.buf.format()
          end, { desc = "Format current buffer with LSP" })

          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = e.buf,
            callback = function()
              vim.lsp.buf.format { async = false }
            end
          })
        end,
        group = vim.api.nvim_create_augroup("lsp_attach", {}),
      })
    end,
  }
}
