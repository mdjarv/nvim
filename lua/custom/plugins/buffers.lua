local function close_buffers_others()
  local current_buf = vim.fn.bufnr '%'
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
      vim.cmd('bd ' .. buf)
    end
  end
end

local function close_buffers_left()
  local current_buf = vim.fn.bufnr '%'
  for i = 1, current_buf - 1 do
    if vim.api.nvim_buf_is_loaded(i) then
      vim.cmd('bd ' .. i)
    end
  end
end

local function close_buffers_right()
  local current_buf = vim.fn.bufnr '%'
  local last_buf = vim.fn.bufnr '$'
  for i = current_buf + 1, last_buf do
    if vim.api.nvim_buf_is_loaded(i) then
      vim.cmd('bd ' .. i)
    end
  end
end

local wk = require 'which-key'
wk.add {
  { '<S-h>', '<cmd>bprevious<cr>', desc = 'Previous buffer' },
  { '<S-l>', '<cmd>bnext<cr>', desc = 'Next buffer' },
  { '<M-w>', '<cmd>bd<cr>', desc = 'Destroy buffer' },
  { '<leader>co', close_buffers_others },
  { '<leader>ch', close_buffers_left },
  { '<leader>cl', close_buffers_right },
}

return {}
