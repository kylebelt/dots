return {
  "neovim/nvim-lspconfig",
  opts = {
    folds = { enabled = false },
    diagnostics = {
      virtual_text = false,
      virtual_lines = { current_line = true },
    },
    inlay_hints = {
      enabled = true,
    },
  },
}
