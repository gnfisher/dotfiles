vim.api.nvim_create_user_command("ToggleBg", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "light"
  end
end, {})
