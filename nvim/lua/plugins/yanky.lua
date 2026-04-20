return {
  "gbprod/yanky.nvim",
  opts = {
    system_clipboard = {
      sync_with_ring = true,
      clipboard_register = "+",
    },
  },
  keys = {
    { "y", '"+<Plug>(YankyYank)', mode = { "n", "x" }, desc = "Yank Text to Clipboard" },
    { "<c-p>", "<Plug>(YankyPreviousEntry)", mode = { "n" }, desc = "Select previous entry through yank history" },
    { "<c-n>", "<Plug>(YankyNextEntry)", mode = { "n" }, desc = "Select next entry through yank history" },
  },
}
