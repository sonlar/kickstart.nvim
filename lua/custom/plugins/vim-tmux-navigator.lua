local function gh(repo) return 'https://github.com/' .. repo end

-- 1. Last inn pakken
vim.pack.add { { src = gh 'christoomey/vim-tmux-navigator' } }

-- 2. Definer snarveiene (Siden .setup{} ikke eksisterer)
local opts = { silent = true, noremap = true }

vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<cr>', opts)
vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<cr>', opts)
vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<cr>', opts)
vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<cr>', opts)
vim.keymap.set('n', '<C-\\>', '<cmd>TmuxNavigatePrevious<cr>', opts)
