local autocmd = vim.api.nvim_create_autocmd

autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

vim.opt.colorcolumn = "120"

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}
