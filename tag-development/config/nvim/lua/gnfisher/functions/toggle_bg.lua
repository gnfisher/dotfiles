-- Create a command to toggle between dark/light background
vim.api.nvim_create_user_command("ToggleBg", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
    vim.cmd("GrbLuciusLightHighContrast")
  else
    vim.o.background = "dark"
    vim.cmd("GrbLuciusDarkHighContrast")
  end
end, {})
