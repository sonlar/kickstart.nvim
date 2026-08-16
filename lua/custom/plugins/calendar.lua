local function gh(repo) return 'https://github.com/' .. repo end

vim.g.calendar_monday = 1
vim.g.calendar_weeknm = 5
vim.pack.add { { src = gh 'mattn/calendar-vim' } }
