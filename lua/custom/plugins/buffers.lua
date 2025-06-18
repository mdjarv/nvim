require('which-key').add {
  { '<S-h>', '<cmd>bprevious<cr>', desc = 'Previous buffer' },
  { '<S-l>', '<cmd>bnext<cr>', desc = 'Next buffer' },
}
--
return {}

-- return {
--   'kazhala/close-buffers.nvim',
--   keys = {
--     {
--       '<leader>co',
--       function()
--         require('close_buffers').wipe { type = 'other' }
--       end,
--       desc = '[C]lose [O]ther',
--     },
--     {
--       '<leader>cb',
--       function()
--         require('close_buffers').delete { type = 'this' }
--       end,
--       desc = '[C]lose [B]uffer',
--     },
--   },
--   config = function()
--     require('close_buffers').setup {}
--   end,
-- }
