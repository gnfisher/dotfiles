vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local ft = vim.bo.filetype
    local ln = vim.fn.line("'\"")
    local last_line = vim.fn.line("$")
    if ft ~= "gitcommit" and ln > 0 and ln < last_line then
      vim.api.nvim_command([[:normal g`"]])
    end
  end,
  group = vim.api.nvim_create_augroup("jump_to_last_line", {})
})
