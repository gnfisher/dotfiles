local status_ok, config = pcall(require, "lint")
if not status_ok then
  return
end

config.linters_by_ft = {
  ruby = { 'rubocop', 'ruby' },
  javascript = { 'eslint' },
  typescript = { 'eslint' },
  typescriptreact = { 'eslint' },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    config.try_lint()
  end,
})
