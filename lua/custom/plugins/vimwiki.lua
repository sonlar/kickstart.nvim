local function gh(repo) return 'https://github.com/' .. repo end

vim.g.vimwiki_global_ext = 0

vim.g.vimwiki_list = {
  {
    path = '~/Documents/vimwiki/',
    syntax = 'markdown',
    ext = '.md.gpg',
    auto_generate_links = 1,
    auto_diary_index = 1,
    auto_tags = 1,
    auto_toc = 1,
    diary_frequency = 'weekly',
  },
}

vim.pack.add { { src = gh 'vimwiki/vimwiki' } }

-- Weekly Diary Template Autocmd
local diary_group = vim.api.nvim_create_augroup('VimwikiDiaryTemplate', { clear = true })
local day_names = { 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday' }
local month_names = {
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
}

local function ordinal(n)
  local d = n % 10
  local d10 = n % 100
  if d10 >= 11 and d10 <= 13 then
    return n .. 'th'
  elseif d == 1 then
    return n .. 'st'
  elseif d == 2 then
    return n .. 'nd'
  elseif d == 3 then
    return n .. 'rd'
  else
    return n .. 'th'
  end
end

local function format_day(t, day_name)
  local day_num = tonumber(os.date('%d', t))
  local month_name = month_names[tonumber(os.date('%m', t))]
  return string.format('%s %s of %s', day_name, ordinal(day_num), month_name)
end

local function get_monday_from_filename(filename)
  -- Match ISO week pattern like "2026-W33" or "2026-33"
  local year, week = filename:match '^(%d%d%d%d)%-[wW]?(%d+)$'
  if year and week then
    year, week = tonumber(year), tonumber(week)
    local jan4 = os.time { year = year, month = 1, day = 4, hour = 12 }
    local jan4_wday = tonumber(os.date('%w', jan4))
    if jan4_wday == 0 then jan4_wday = 7 end
    local week1_monday = jan4 - (jan4_wday - 1) * 86400
    return week1_monday + (week - 1) * 7 * 86400
  end

  -- Match YYYY-MM-DD pattern like "2026-08-10"
  local y, m, d = filename:match '^(%d%d%d%d)%-(%d%d)%-(%d%d)$'
  if y and m and d then
    local t = os.time { year = tonumber(y), month = tonumber(m), day = tonumber(d), hour = 12 }
    local wday = tonumber(os.date('%w', t))
    if wday == 0 then wday = 7 end
    return t - (wday - 1) * 86400
  end

  -- Fallback: current week's Monday
  local now = os.time()
  local wday = tonumber(os.date('%w', now))
  if wday == 0 then wday = 7 end
  return now - (wday - 1) * 86400
end

vim.api.nvim_create_autocmd('BufNewFile', {
  group = diary_group,
  pattern = '*/vimwiki/diary/*.md',
  callback = function(args)
    local filename = vim.fn.expand '%:t:r' -- e.g. "2026-W33" or "2026-08-10"
    local monday_time = get_monday_from_filename(filename)
    local sunday_time = monday_time + (6 * 86400)

    local week_nr = tonumber(os.date('%V', monday_time))
    local year_str = os.date('%G', monday_time)
    local monday_str = format_day(monday_time, day_names[1])
    local sunday_str = format_day(sunday_time, day_names[7])
    local title = string.format('# Diary week: %d %s (%s - %s)', week_nr, year_str, monday_str, sunday_str)

    local lines = {
      title,
      '',
      '## TODO',
      '- [ ] ',
      '',
      '## Notes',
    }

    for i = 0, 6 do
      local day_time = monday_time + (i * 86400)
      local date_str = os.date('%d-%m-%Y', day_time)
      local day_name = day_names[i + 1]

      table.insert(lines, '')
      table.insert(lines, '### ' .. day_name .. ', ' .. date_str)
      table.insert(lines, '- ')
    end

    table.insert(lines, '')
    table.insert(lines, '## Weekly Review')
    table.insert(lines, '')

    vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, lines)
  end,
})
