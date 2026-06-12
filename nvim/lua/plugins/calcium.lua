return {
  "necrom4/calcium.nvim",
  cmd = { "Calcium" },
  opts = {},
  keys = {
    {
      "<leader>CC",
      ":Calcium<CR>",
      desc = "Calculate",
      mode = { "n", "v" },
      silent = true,
    },
  },
}
