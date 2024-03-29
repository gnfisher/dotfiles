return {
  'scalameta/nvim-metals',
  config = function()
    local function metals_status_handler(_, status, ctx)
      -- https://github.com/scalameta/nvim-metals/blob/main/lua/metals/status.lua#L36-L50
      local val = {}
      if status.hide then
        val = { kind = "end" }
      elseif status.show then
        val = { kind = "begin", message = status.text }
      elseif status.text then
        val = { kind = "report", message = status.text }
      else
        return
      end
      local info = { client_id = ctx.client_id }
      local msg = { token = "metals", value = val }
      -- call fidget progress handler
      vim.lsp.handlers["$/progress"](nil, msg, info)
    end

    local handlers = {}
    handlers['metals/status'] = metals_status_handler

    local status_ok, metals = pcall(require, "metals")
    if not status_ok then
      return
    end

    local metals_config = metals.bare_config()
    metals_config.init_options.statusBarProvider = "on"
    metals_config.settings = {
      showImplicitArguments = true,
    }

    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    metals_config.capabilities = capabilities

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    on_attach = function(client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions

      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

      nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
      nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
      nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
      nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      -- See `:help K` for why this keymap
      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- Lesser used LSP functionality
      nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
      nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
      nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, '[W]orkspace [L]ist Folders')
    end

    metals_config.on_attach = on_attach

    metals_config.handlers = handlers

    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "scala", "sbt", "java" },
      callback = function()
        metals.initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end
}
