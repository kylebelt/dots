return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",
    },
    sources = {
      min_keyword_length = 2,
      providers = {
        snippets = { score_offset = 5 },
        lsp = { score_offset = 3 },
        path = { score_offset = 2 },
        buffer = { score_offset = 1 },
        dadbod = { score_offset = 0 },
      },
    },
    completion = {
      ghost_text = {
        enabled = false,
      },
      menu = {
        auto_show_delay_ms = 150,
      },
    },
  },
}
