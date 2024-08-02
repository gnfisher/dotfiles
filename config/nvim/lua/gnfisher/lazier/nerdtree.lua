return {
  'preservim/nerdtree',
  lazy = false,
  config = function()
    vim.keymap.set("n", "<Leader>nt", ":NERDTreeToggle<CR>", { silent = true })
    vim.keymap.set("n", "<Leader>nf", ":NERDTreeFocus<CR>", { silent = true })
    vim.keymap.set("n", "<Leader>nF", ":NERDTreeFind<CR>", { silent = true })

    local augroup = vim.api.nvim_create_augroup
    local autocmd = vim.api.nvim_create_autocmd

    local nerdtree_group = augroup("NERDTree", {})

    autocmd("VimEnter", {
      group = nerdtree_group,
      callback = function()
        vim.cmd("NERDTree")
        vim.cmd("wincmd p")
      end
    })

    autocmd("BufEnter", {
      group = nerdtree_group,
      callback = function()
        if vim.fn.winnr() == vim.fn.winnr('h')
            and vim.fn.bufname('#'):match('NERD_tree_%d+')
            and not vim.fn.bufname('%'):match('NERD_tree_%d+')
            and vim.fn.winnr('$') > 1 then
          local buf = vim.fn.bufnr()
          vim.cmd('buffer #')
          vim.cmd('wincmd w')
          vim.cmd('buffer ' .. buf)
        end
      end
    })
  end,
}
