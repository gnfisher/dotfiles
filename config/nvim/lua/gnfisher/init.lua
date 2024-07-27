require('gnfisher.set')
require('gnfisher.map')
require('gnfisher.lazy_init')

vim.cmd("colorscheme habamax")

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
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)

    -- vim.keymap.set('gr', require('telescope.builtin').lsp_references)
    vim.keymap.set("n", "<leader>ds", require('telescope.builtin').lsp_document_symbols)
    vim.keymap.set("n", "<leader>ws", require('telescope.builtin').lsp_dynamic_workspace_symbols)

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

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
