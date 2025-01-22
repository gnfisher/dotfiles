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

-- Return plugin spec for lazy.nvim
return {
  {
    "seblj/nvim-echo-diagnostics",
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
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/nvim-cmp",
      "L3MON4D3/LuaSnip",
    },
    ft = { "lua", "typescript", "javascript", "go" }, -- specific filetypes
    config = function()
      local cmp = require('cmp')
      local cmp_lsp = require("cmp_nvim_lsp")
      -- Core LSP setup
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities()
      )

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

      -- Setup keymaps and autocmd
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(e)
          local opts = { buffer = e.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
          vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)

          vim.keymap.set("n", "<Leader>ds", require('telescope.builtin').lsp_document_symbols)
          vim.keymap.set("n", "<Leader>ws", require('telescope.builtin').lsp_dynamic_workspace_symbols)

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

      -- Setup cmp
      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
          ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
        }, {
          { name = "buffer" },
        })
      })
    end
  }
}
