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
