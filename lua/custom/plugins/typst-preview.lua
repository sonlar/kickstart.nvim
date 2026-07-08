local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { { src = gh 'chomosuke/typst-preview.nvim', version = vim.version.range '1.*' } }
require('typst-preview').setup {}

vim.lsp.config.tinymist = {
  cmd = { 'tinymist' },
  filetypes = { 'typst' },
  settings = {
    formatterMode = 'typstyle',
    exportPdf = 'onType',
    semanticTokens = 'disable',
  },
}
vim.lsp.enable 'tinymist'
