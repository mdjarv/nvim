-- local function remove_buffers(buf_list)
--   for _, buf in ipairs(buf_list) do
--     require('mini.bufremove').delete(buf)
--   end
-- end
--
-- local function close_current_buffer()
--   remove_buffers { 0 } -- 0 represents the current buffer
-- end
--
-- local function close_all_except_current_buffer()
--   local current_buf = vim.api.nvim_get_current_buf()
--   local bufs = vim.api.nvim_list_bufs()
--   local bufs_to_close = {}
--
--   for _, buf in ipairs(bufs) do
--     if buf ~= current_buf then
--       table.insert(bufs_to_close, buf)
--     end
--   end
--
--   remove_buffers(bufs_to_close)
-- end
--
-- local function close_buffers_left_of_current()
--   local current_buf = vim.api.nvim_get_current_buf()
--   local bufs = vim.api.nvim_list_bufs()
--   local current_index = nil
--   local bufs_to_close = {}
--
--   for i, buf in ipairs(bufs) do
--     if buf == current_buf then
--       current_index = i
--       break
--     end
--   end
--
--   if current_index then
--     for i = 1, current_index - 1 do
--       table.insert(bufs_to_close, bufs[i])
--     end
--     remove_buffers(bufs_to_close)
--   end
-- end
--
-- local function close_buffers_right_of_current()
--   local current_buf = vim.api.nvim_get_current_buf()
--   local bufs = vim.api.nvim_list_bufs()
--   local current_index = nil
--   local bufs_to_close = {}
--
--   for i, buf in ipairs(bufs) do
--     if buf == current_buf then
--       current_index = i
--       break
--     end
--   end
--
--   if current_index then
--     for i = current_index + 1, #bufs do
--       table.insert(bufs_to_close, bufs[i])
--     end
--     remove_buffers(bufs_to_close)
--   end
-- end
--
-- vim.api.nvim_create_user_command('BuffersCloseCurrent', close_current_buffer, {})
-- vim.api.nvim_create_user_command('BuffersCloseOthers', close_all_except_current_buffer, {})
-- vim.api.nvim_create_user_command('BuffersCloseLeft', close_buffers_left_of_current, {})
-- vim.api.nvim_create_user_command('BuffersCloseRight', close_buffers_right_of_current, {})
--
-- local wk = require 'which-key'
require('which-key').add {
  { '<S-h>', '<cmd>bprevious<cr>', desc = 'Previous buffer' },
  { '<S-l>', '<cmd>bnext<cr>', desc = 'Next buffer' },
  -- { '<leader>cb', '<cmd>BuffersCloseCurrent<cr>', desc = '[C]lose [B]uffer' },
  -- { '<leader>co', '<cmd>BuffersCloseOthers<cr>', desc = '[C]lose [O]thers' },
  -- { '<leader>ch', '<cmd>BuffersCloseLeft<cr>', desc = '[C]lose Left' },
  -- { '<leader>cl', '<cmd>BuffersCloseRight<cr>', desc = '[C]lose Right' },
}
--
-- return {}

return {
  'kazhala/close-buffers.nvim',
  keys = {
    {
      '<leader>co',
      function()
        require('close_buffers').wipe { type = 'other' }
      end,
      desc = '[C]lose [O]ther',
    },
    {
      '<leader>cb',
      function()
        require('close_buffers').delete { type = 'this' }
      end,
      desc = '[C]lose [B]uffer',
    },
  },
  config = function()
    require('close_buffers').setup {}
  end,
}
