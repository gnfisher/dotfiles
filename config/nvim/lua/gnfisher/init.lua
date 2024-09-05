vim.g.mapleader = " "

require('gnfisher.lazy_init')

local function jump_to_last_line()
  local ft = vim.bo.filetype
  local ln = vim.fn.line("'\"")
  local last_line = vim.fn.line("$")
  if ft ~= "gitcommit" and ln > 0 and ln < last_line then
    vim.api.nvim_command([[:normal g`"]])
  end
end

local augroup = vim.api.nvim_create_augroup
local GnfisherGroup = augroup("gnfisher", {})
local yank_group = augroup("YankHighlight", { clear = true })

local autocmd = vim.api.nvim_create_autocmd

autocmd("BufWritePre", {
  command = [[%s/\s\+$//e]],
  group = GnfisherGroup,
})

autocmd("BufReadPost", {
  callback = jump_to_last_line,
  group = GnfisherGroup,
})

autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = yank_group,
  pattern = "*",
})

autocmd("LspAttach", {
  group = GnfisherGroup,
  callback = function(e)
    local opts = { buffer = e.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)

    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
    vim.keymap.set("n", "<Leader>ds", require('telescope.builtin').lsp_document_symbols)
    vim.keymap.set("n", "<Leader>ws", require('telescope.builtin').lsp_dynamic_workspace_symbols)

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(e.buf, "Format", function(_)
      vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })

    autocmd("BufWritePre", {
      buffer = e.buf,
      callback = function()
        vim.lsp.buf.format { async = false }
      end
    })
  end,
})
