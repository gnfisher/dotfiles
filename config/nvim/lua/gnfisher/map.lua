vim.g.mapleader = " "

vim.keymap.set('n', '<Leader>;', ':', { silent = true })

vim.keymap.set("n", "<C-x>b", vim.cmd.bd)
vim.keymap.set("n", "<C-x>c", "<cmd>cclose<CR>")
vim.keymap.set("n", "<C-x>l", "<cmd>lclose<CR>")
vim.keymap.set("n", "<C-x>h", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == 'help' then
      vim.api.nvim_win_close(win, false)
      return
    end
  end
  print("No help window found")
end, { noremap = true, silent = true, desc = "Close help window" })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<Leader>;", ":", { silent = true })
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "cp", '"+y', { silent = true })
vim.keymap.set("n", "cv", '"+p', { silent = true })
vim.keymap.set("n", "cV", '"+P', { silent = true })
vim.keymap.set("v", "cp", '"+y', { silent = true })
vim.keymap.set("v", "cv", '"+p', { silent = true })
vim.keymap.set("v", "cV", '"+P', { silent = true })

local function ToggleBg()
  if vim.o.background == "dark" then
    vim.o.background = "light"
    vim.cmd("colorscheme peachpuff")
  else
    vim.o.background = "dark"
    vim.cmd("colorscheme habamax")
  end
end

vim.keymap.set('n', '<F6>', ToggleBg, { noremap = true, silent = true })
