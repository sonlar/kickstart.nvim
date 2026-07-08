local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'tpope/vim-dadbod',
  gh 'kristijanhusak/vim-dadbod-completion',
  gh 'kristijanhusak/vim-dadbod-ui',
}

vim.g.db_ui_use_nerd_fonts = 1
