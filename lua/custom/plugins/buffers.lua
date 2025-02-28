-- local function close_buffers_others()
--   local current_buf = vim.fn.bufnr '%'
--   for _, buf in ipairs(vim.api.nvim_list_bufs()) do
--     if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
--       vim.cmd('bd ' .. buf)
--     end
--   end
-- end
--
-- local function close_buffers_left()
--   local current_buf = vim.fn.bufnr '%'
--   for i = 1, current_buf - 1 do
--     if vim.api.nvim_buf_is_loaded(i) then
--       vim.cmd('bd ' .. i)
--     end
--   end
-- end
--
-- local function close_buffers_right()
--   local current_buf = vim.fn.bufnr '%'
--   local last_buf = vim.fn.bufnr '$'
--   for i = current_buf + 1, last_buf do
--     if vim.api.nvim_buf_is_loaded(i) then
--       vim.cmd('bd ' .. i)
--     end
--   end
-- end
--
-- local wk = require 'which-key'
-- wk.add {
--   { '<S-h>', '<cmd>bprevious<cr>', desc = 'Previous buffer' },
--   { '<S-l>', '<cmd>bnext<cr>', desc = 'Next buffer' },
--   -- { '<M-w>', '<cmd>bd<cr>', desc = 'Destroy buffer' },
--   -- { '<leader>cb', '<cmd>bd<cr>', desc = 'Destroy buffer' },
--   {
--     '<leader>cb',
--     function()
--       MiniBufremove.delete()
--     end,
--     desc = '[C]lose [B]uffer',
--   },
--   { '<leader>co', close_buffers_others },
--   { '<leader>ch', close_buffers_left },
--   { '<leader>cl', close_buffers_right },
-- }
--
-- return {
--   -- 'famiu/bufdelete.nvim',
--   -- keys = {
--   --   {'<leader>co', function() require('bufdelete') end}
--   -- }
-- }

local function remove_buffers(buf_list)
  for _, buf in ipairs(buf_list) do
    require('mini.bufremove').delete(buf)
  end
end

local function close_current_buffer()
  remove_buffers { 0 } -- 0 represents the current buffer
end

local function close_all_except_current_buffer()
  local current_buf = vim.api.nvim_get_current_buf()
  local bufs = vim.api.nvim_list_bufs()
  local bufs_to_close = {}

  for _, buf in ipairs(bufs) do
    if buf ~= current_buf then
      table.insert(bufs_to_close, buf)
    end
  end

  remove_buffers(bufs_to_close)
end

local function close_buffers_left_of_current()
  local current_buf = vim.api.nvim_get_current_buf()
  local bufs = vim.api.nvim_list_bufs()
  local current_index = nil
  local bufs_to_close = {}

  for i, buf in ipairs(bufs) do
    if buf == current_buf then
      current_index = i
      break
    end
  end

  if current_index then
    for i = 1, current_index - 1 do
      table.insert(bufs_to_close, bufs[i])
    end
    remove_buffers(bufs_to_close)
  end
end

local function close_buffers_right_of_current()
  local current_buf = vim.api.nvim_get_current_buf()
  local bufs = vim.api.nvim_list_bufs()
  local current_index = nil
  local bufs_to_close = {}

  for i, buf in ipairs(bufs) do
    if buf == current_buf then
      current_index = i
      break
    end
  end

  if current_index then
    for i = current_index + 1, #bufs do
      table.insert(bufs_to_close, bufs[i])
    end
    remove_buffers(bufs_to_close)
  end
end

vim.api.nvim_create_user_command('BuffersCloseCurrent', close_current_buffer, {})
vim.api.nvim_create_user_command('BuffersCloseOthers', close_all_except_current_buffer, {})
vim.api.nvim_create_user_command('BuffersCloseLeft', close_buffers_left_of_current, {})
vim.api.nvim_create_user_command('BuffersCloseRight', close_buffers_right_of_current, {})

-- local wk = require 'which-key'
require('which-key').add {
  { '<S-h>', '<cmd>bprevious<cr>', desc = 'Previous buffer' },
  { '<S-l>', '<cmd>bnext<cr>', desc = 'Next buffer' },
  { '<leader>cb', '<cmd>BuffersCloseCurrent<cr>', desc = '[C]lose [B]uffer' },
  { '<leader>co', '<cmd>BuffersCloseOthers<cr>', desc = '[C]lose [O]thers' },
  { '<leader>ch', '<cmd>BuffersCloseLeft<cr>', desc = '[C]lose Left' },
  { '<leader>cl', '<cmd>BuffersCloseRight<cr>', desc = '[C]lose Right' },
}

return {}
