return {
  {
    'chomosuke/typst-preview.nvim',
    lazy = false, -- or ft = 'typst'
    version = '1.*',
    opts = {}, -- lazy.nvim will implicitly calls `setup {}`
    config = function()
      vim.lsp.config['tinymist'] = {
        cmd = { 'tinymist' },
        filetypes = { 'typst' },
        settings = {
          formatterMode = 'typstyle',
          exportPdf = 'onType',
          semanticTokens = 'disable',
        },
      }
      vim.lsp.enable 'tinymist'
    end,
  },
}
