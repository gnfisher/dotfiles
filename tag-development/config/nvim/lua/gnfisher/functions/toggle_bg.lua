-- Create a command to toggle between dark/light background
vim.api.nvim_create_user_command("ToggleBg", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end, {})
