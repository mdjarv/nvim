return {
  'ggml-org/llama.vim',
  init = function()
    vim.g.llama_config = {
      -- Sampling — for FIM, lower temp = more deterministic completions
      n_predict = 128, -- max tokens per suggestion (default 128)
      temperature = 0.2, -- ↓ from default 0.8 — usually better for code
      top_k = 40,
      top_p = 0.99,

      -- Triggering
      auto_fim = true, -- complete as you type
      max_line_suffix = 8, -- skip auto-FIM if too much text after cursor
      show_info = 0, -- 0=off, 1=brief, 2=full stats line

      -- Context
      ring_n_chunks = 16, -- ring buffer size
      ring_chunk_size = 64, -- tokens per chunk
      ring_scope = 1024, -- lines around cursor sampled into ring
      ring_update_ms = 1000, -- ring buffer refresh cadence

      -- Keymaps (defaults shown — change if you want)
      keymap_fim_trigger = '<C-F>', -- manual FIM trigger in insert mode
      keymap_fim_accept_full = '<Tab>',
      keymap_fim_accept_line = '<S-Tab>',
      keymap_fim_accept_word = '<C-B>',
    }
  end,
}
