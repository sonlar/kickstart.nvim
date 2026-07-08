local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'nvim-telescope/telescope.nvim',
  gh 'brianhuster/live-preview.nvim',
}
