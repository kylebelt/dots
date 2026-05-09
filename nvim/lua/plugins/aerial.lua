return {
  "stevearc/aerial.nvim",
  opts = {
    backends = {
      ["_"] = {
        "treesitter",
        "lsp",
        "markdown",
        "asciidoc",
        "man",
      },
      python = { "lsp" },
    },
    layout = {
      resize_to_content = true,
    },
    filter_kind = {
      "Class",
      "Constructor",
      "Constant",
      "Enum",
      "Function",
      "Interface",
      "Module",
      "Method",
      "Struct",
    },
    highlight_on_hover = true,
  },
}
