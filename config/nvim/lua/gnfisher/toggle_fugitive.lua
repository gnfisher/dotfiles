vim.api.nvim_create_user_command("ToggleFugitive", function()
  local winids = vim.api.nvim_list_wins()
  for _, id in pairs(winids) do
    -- you can omit the underscore `_` if it's the second variable.
    local status = pcall(vim.api.nvim_win_get_var, id, "fugitive_status")
    if status then
      vim.api.nvim_win_close(id, false)
      return
    end
  end
  vim.cmd("Git")
end, {})
