local set = vim.keymap.set

set('n', '<Leader>;', ':', { silent = true })

set("n", "<C-x>b", vim.cmd.bd)
set("n", "<C-x>c", "<cmd>cclose<CR>")
set("n", "<C-x>l", "<cmd>lclose<CR>")
set("n", "<C-x>p", "<cmd>pclose<CR>")
set("n", "<C-x>h", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == 'help' then
      vim.api.nvim_win_close(win, false)
      return
    end
  end
  print("No help window found")
end, { noremap = true, silent = true, desc = "Close help window" })

local function close_terminal_buffers()
  local closed = false
  local closed_count = 0

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == 'terminal' then
      -- Use vim.api.nvim_buf_delete() with force=true, which is equivalent to :bd!
      vim.api.nvim_buf_delete(buf, { force = true })
      closed = true
      closed_count = closed_count + 1
    end
  end

  if not closed then
    print("No terminal buffers found")
  else
    print(string.format("Closed %d terminal buffer(s)", closed_count))
  end
end
vim.keymap.set("n", "<C-x>t", close_terminal_buffers, { noremap = true, silent = true, desc = "Close terminal windows" })

set('n', '<C-h>', '<C-w>h')
set('n', '<C-j>', '<C-w>j')
set('n', '<C-k>', '<C-w>k')
set('n', '<C-l>', '<C-w>l')

set("n", "<M-,>", "<c-w>5<")
set("n", "<M-.>", "<c-w>5>")
set("n", "<M-t>", "<C-W>+")
set("n", "<M-s>", "<C-W>-")

set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

set("n", "<Leader>;", ":", { silent = true })
set("i", "<C-c>", "<Esc>")

set("n", "Q", "<nop>")
set("n", "<leader>f", vim.lsp.buf.format)

set("n", "<Leader>j", "<cmd>cnext<CR>zz")
set("n", "<Leader>k", "<cmd>cprev<CR>zz")

set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

set("n", "cp", '"+y', { silent = true })
set("n", "cv", '"+p', { silent = true })
set("n", "cV", '"+P', { silent = true })
set("v", "cp", '"+y', { silent = true })
set("v", "cv", '"+p', { silent = true })
set("v", "cV", '"+P', { silent = true })

vim.keymap.set("n", "<Leader>so", function()
  vim.cmd("so")
end)

function ToggleBg()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "light"
  end
end

vim.keymap.set("n", "<F6>", ToggleBg)
