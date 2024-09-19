local function SetDark()
  vim.o.background = "dark"
  vim.cmd [[hi Normal guibg=NONE ctermbg=NONE]]
end

function ToggleBg()
  if vim.o.background == "dark" then
    vim.o.background = "light"
    vim.cmd [[hi Normal guibg=NONE ctermbg=NONE]]
  else
    SetDark()
  end
end

vim.cmd.colorscheme("rose-pine")
vim.cmd [[hi Normal guibg=NONE ctermbg=NONE]]
vim.keymap.set('n', '<F6>', ToggleBg, { noremap = true, silent = true })
