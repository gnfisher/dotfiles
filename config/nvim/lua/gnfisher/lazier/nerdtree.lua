return {
  'preservim/nerdtree',
  config = function()
    vim.keymap.set("n", "<Leader>nt", ":NERDTreeToggle<CR>", { silent = true })
    vim.keymap.set("n", "<Leader>nf", ":NERDTreeFocus<CR>", { silent = true })
    vim.keymap.set("n", "<Leader>nF", ":NERDTreeFind<CR>", { silent = true })

    local augroup = vim.api.nvim_create_augroup
    local autocmd = vim.api.nvim_create_autocmd

    local nerdtree_group = augroup("NERDTree", {})

    -- If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
    autocmd("BufEnter", {
      group = nerdtree_group,
      callback = function()
        if vim.fn.winnr() == vim.fn.winnr('h') and
            vim.fn.bufname('#'):match('NERD_tree_%d+') and
            not vim.fn.bufname('%'):match('NERD_tree_%d+') and
            vim.fn.winnr('$') > 1 then
          local buf = vim.fn.bufnr()
          vim.cmd('buffer#')
          vim.cmd('execute "normal! \\<C-W>w"')
          vim.cmd('execute "buffer' .. buf .. '"')
        end
      end
    })

    -- Open the existing NERDTree on each new tab.
    autocmd("BufWinEnter", {
      group = nerdtree_group,
      callback = function()
        if vim.bo.buftype ~= 'quickfix' and vim.fn.getcmdwintype() == '' then
          vim.cmd('silent NERDTreeMirror')
        end
      end
    })
  end
}
