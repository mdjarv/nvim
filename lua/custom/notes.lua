-- Lightweight plain-markdown note taking.
--
--   ~/notes/journal/YYYY-MM-DD.md   daily capture (the default dumping ground)
--   ~/notes/<slug>.md               flat topic notes, found via the picker
--
-- No plugin dependency beyond snacks (picker) and render-markdown (display),
-- both already in the config. The Hyprland scratchpad launches nvim straight
-- into `today()`.

local M = {}

M.root = vim.fn.expand '~/notes'
M.journal = M.root .. '/journal'

local function ensure_dir(dir)
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, 'p')
  end
end

-- Open `path` (creating dir + seeding `header` on new files), cursor at end of
-- buffer, insert mode -- so you land ready to type.
function M.open(path, header)
  ensure_dir(vim.fn.fnamemodify(path, ':h'))
  local is_new = vim.fn.filereadable(path) == 0
  vim.cmd.edit(vim.fn.fnameescape(path))
  if is_new and header then
    vim.api.nvim_buf_set_lines(0, 0, -1, false, { header, '' })
  end
  vim.api.nvim_win_set_cursor(0, { vim.api.nvim_buf_line_count(0), 0 })
  vim.cmd.startinsert { bang = true }
end

-- Today's daily note.
function M.today()
  local date = os.date '%Y-%m-%d'
  M.open(M.journal .. '/' .. date .. '.md', '# ' .. date)
end

-- Yesterday's daily note (does not create, just opens whatever is there).
function M.yesterday()
  local date = os.date('%Y-%m-%d', os.time() - 86400)
  M.open(M.journal .. '/' .. date .. '.md', '# ' .. date)
end

-- New flat topic note from a title prompt.
function M.new()
  vim.ui.input({ prompt = 'Note title: ' }, function(title)
    if not title or title:match '^%s*$' then
      return
    end
    local slug = title:lower():gsub('[^%w]+', '-'):gsub('^%-+', ''):gsub('%-+$', '')
    M.open(M.root .. '/' .. slug .. '.md', '# ' .. title)
  end)
end

function M.find()
  Snacks.picker.files { cwd = M.root }
end

function M.grep()
  Snacks.picker.grep { cwd = M.root }
end

function M.setup()
  vim.api.nvim_create_user_command('Note', M.today, { desc = "Open today's note" })
  vim.api.nvim_create_user_command('NoteNew', M.new, { desc = 'New topic note' })

  local map = vim.keymap.set
  map('n', '<leader>Nn', M.today, { desc = 'Today' })
  map('n', '<leader>Ny', M.yesterday, { desc = 'Yesterday' })
  map('n', '<leader>Nc', M.new, { desc = 'Create topic note' })
  map('n', '<leader>Nf', M.find, { desc = 'Find notes' })
  map('n', '<leader>Ng', M.grep, { desc = 'Grep notes' })

  local ok, wk = pcall(require, 'which-key')
  if ok then
    wk.add { { '<leader>N', group = 'Notes' } }
  end

  -- Scratchpad launch sets NVIM_NOTES=1; open today's note once startup settles
  -- (scheduled past VimEnter so it wins over the dashboard).
  if vim.env.NVIM_NOTES == '1' then
    vim.api.nvim_create_autocmd('VimEnter', {
      once = true,
      callback = function()
        vim.schedule(M.today)
      end,
    })
  end

  -- Autosave notes buffers so the scratchpad persists without an explicit :w.
  local grp = vim.api.nvim_create_augroup('custom_notes_autosave', { clear = true })
  vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufLeave', 'FocusLost' }, {
    group = grp,
    callback = function(a)
      local name = vim.api.nvim_buf_get_name(a.buf)
      if name ~= '' and vim.startswith(name, M.root) and vim.bo[a.buf].buftype == '' and vim.bo[a.buf].modified then
        vim.api.nvim_buf_call(a.buf, function()
          vim.cmd 'silent! write'
        end)
      end
    end,
  })
end

return M
