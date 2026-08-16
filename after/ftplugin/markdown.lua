-- Set up buffer-local zk keymaps for Markdown files inside a zk notebook.
local has_zk, zk_util = pcall(require, 'zk.util')
if has_zk and zk_util and zk_util.notebook_root(vim.fn.expand '%:p') ~= nil then
  local opts = { noremap = true, silent = false, buffer = true }

  -- <CR>: Follow the wiki link under the cursor.
  -- vim.keymap.set('n', '<CR>', '<Cmd>lua vim.lsp.buf.definition()<CR>', vim.tbl_extend('force', opts, { desc = 'ZK: Follow link' }))

  -- <leader>zn: Create a new note in the current note's directory after prompting for a title.
  -- Overrides the global `<leader>zn` so this stays local to the current folder.
  vim.keymap.set(
    'n',
    '<leader>zn',
    "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>",
    vim.tbl_extend('force', opts, { desc = 'ZK: Create note in dir' })
  )
  -- <leader>znt (visual): Create a note in the current directory using the selection as the title.
  vim.keymap.set(
    'v',
    '<leader>znt',
    ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>",
    vim.tbl_extend('force', opts, { desc = 'ZK: Create note in dir with title' })
  )
  -- <leader>znc (visual): Create a note in the current directory from the selection as content, then prompt for title.
  vim.keymap.set(
    'v',
    '<leader>znc',
    ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>",
    vim.tbl_extend('force', opts, { desc = 'ZK: Create note in dir with content' })
  )

  -- <leader>zb: Show notes that link to the current note (backlinks).
  vim.keymap.set('n', '<leader>zb', '<Cmd>ZkBacklinks<CR>', vim.tbl_extend('force', opts, { desc = 'ZK: Show backlinks' }))
  -- Alternative backlinks mapping using pure LSP with source context.
  --map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', vim.tbl_extend('force', opts, { desc = "ZK:" }))
  -- <leader>zl: Show notes linked from the current note.
  vim.keymap.set('n', '<leader>zl', '<Cmd>ZkLinks<CR>', vim.tbl_extend('force', opts, { desc = 'ZK: Show links' }))

  -- K: Preview the linked note under the cursor.
  vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', vim.tbl_extend('force', opts, { desc = 'ZK: preview linked note' }))
  -- <leader>za (visual): Open code actions for the current selection.
  vim.keymap.set('v', '<leader>za', ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", vim.tbl_extend('force', opts, { desc = 'ZK: Open code action' }))

  local function is_checkbox_line()
    local line = vim.api.nvim_get_current_line()
    -- Matches ANY "-/*+ ... [anything]" line
    return line:match '^%s*[-*+][^%[]*%['
  end

  local function toggle_checkbox()
    local line_num = vim.api.nvim_win_get_cursor(0)[1]
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()

    -- CAPTURE: prefix(-/*+ part) | [content] | rest → toggle content
    local prefix, content, rest = line:match '^(%s*[-*+][^%[]*)%[([^]]*)%](.*)$'
    if not prefix then return end -- No match → exit

    local trimmed_content = content:gsub('^%s*(.-)%s*$', '%1')
    local is_checked = trimmed_content:lower() == 'x'

    local new_content = is_checked and ' ' or 'x'
    local new_line = prefix .. '[' .. new_content .. ']' .. rest

    vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, { new_line })
    vim.api.nvim_win_set_cursor(0, { line_num, math.min(col, math.max(0, #new_line - 2)) }) -- FIXED!
  end

  local function smart_cr()
    if is_checkbox_line() then
      toggle_checkbox()
    else
      pcall(vim.lsp.buf.definition)
    end
  end

  vim.keymap.set('n', '<CR>', smart_cr, vim.tbl_extend('force', opts, { desc = 'Toggle checkbox or ZK link' }))
end
