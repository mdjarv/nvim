require('which-key').add {
  { '<M-e>', "viWy:let @+=system('base64 -w0', @+)<cr>gvP", mode = 'n' },
  { '<M-E>', "v%y:let @+=system('base64 -w0', @+)<cr>gvP", mode = 'n' },
  { '<M-d>', "viWy:let @+=system('base64 -d', @+)<cr>gvP", mode = 'n' },
}

return {}
