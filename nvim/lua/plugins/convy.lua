return {
  "necrom4/convy.nvim",
  cmd = { "Convy", "ConvySeparator" },
  opts = {},
  keys = {
    {
      "<leader>Cx",
      ":Convy<CR>",
      desc = "Convert (interactive selection)",
      mode = { "n", "v" },
      silent = true,
    },
    {
      "<leader>Cd",
      ":Convy auto dec<CR>",
      desc = "Convert to decimal",
      mode = { "n", "v" },
      silent = true,
    },
    {
      "<leader>Cs",
      ":ConvySeparator<CR>",
      desc = "Set conversion separator (visual selection)",
      mode = { "v" },
      silent = true,
    },
  },
}
