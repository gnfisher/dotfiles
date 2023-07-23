-- We want to make sure we are in a codespace and rdm is installed.
if vim.fn.executable('rdm') == 1 and os.getenv("CODESPACES") ~= nil then
  vim.g.clipboard = {
    name = "rdm",
    copy = {
      ["+"] = {"rdm", "copy"},
      ["*"] = {"rdm", "copy"}
    },
    paste = {
      ["+"] = {"rdm", "paste"},
      ["*"] = {"rdm", "paste"}
    },
  }
end
