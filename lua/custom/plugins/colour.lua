return {
  'uga-rosa/ccc.nvim',
  config = function()
    vim.opt.termguicolors = true

    local ccc = require 'ccc'
    local mapping = ccc.mapping

    ccc.setup {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    }
    vim.keymap.set('n', '<leader>cp', ':CccPick<CR>', { desc = 'Open colourpicker' })
    vim.keymap.set('n', '<leader>cc', ':CccConvert<CR>', { desc = 'Convert to different colour layout' })
  end,
}
