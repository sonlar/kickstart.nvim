local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'uga-rosa/ccc.nvim' }

vim.opt.termguicolors = true

local ccc = require 'ccc'
ccc.setup {
  highlighter = {
    auto_enable = true,
    lsp = true,
  },
}
vim.keymap.set('n', '<leader>cp', ':CccPick<CR>', { desc = 'Open colourpicker' })
vim.keymap.set('n', '<leader>cc', ':CccConvert<CR>', { desc = 'Convert to different colour layout' })
