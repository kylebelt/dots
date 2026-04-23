return {
  "gbprod/yanky.nvim",
  opts = {
    system_clipboard = {
      sync_with_ring = true,
      clipboard_register = "+",
    },
  },
  keys = {
    -- { "y", '"+<Plug>(YankyYank)', mode = { "n", "x" }, desc = "Yank Text to Clipboard" },
    -- { "Y", '"+<Plug>(YankyYank)$', mode = { "n" }, desc = "Yank to End of Line to Clipboard" },
    -- { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put After Cursor" },
    -- { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Before Cursor" },
    { "<c-p>", "<Plug>(YankyPreviousEntry)", mode = { "n" }, desc = "Select previous entry through yank history" },
    { "<c-n>", "<Plug>(YankyNextEntry)", mode = { "n" }, desc = "Select next entry through yank history" },
  },
}
