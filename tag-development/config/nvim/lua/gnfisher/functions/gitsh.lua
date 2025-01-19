vim.api.nvim_create_user_command('Gitsh', function()
  -- Store current buffer number
  local current_buf = vim.api.nvim_get_current_buf()

  -- Open terminal with gitsh
  vim.cmd('terminal gitsh')

  -- Get the terminal buffer number
  local term_buf = vim.api.nvim_get_current_buf()

  -- Set buffer-local autocmd for when terminal job ends
  vim.api.nvim_create_autocmd("TermClose", {
    buffer = term_buf,
    callback = function()
      -- Delete the terminal buffer
      vim.api.nvim_buf_delete(term_buf, { force = true })
      -- Switch back to original buffer
      vim.api.nvim_set_current_buf(current_buf)
    end,
    once = true -- Only trigger once
  })

  -- Start in terminal (insert) mode
  vim.cmd('startinsert')
end, {})
