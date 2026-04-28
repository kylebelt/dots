return {
  "mikavilpas/yazi.nvim",
  dependencies = { "folke/snacks.nvim" },
  event = "VeryLazy",
  keys = {
    { "<leader>e", mode = { "n" }, "<cmd>Yazi cwd<cr>", desc = "File Explorer (yazi)" },
    { "<leader>E", mode = { "n" }, "<cmd>Yazi<cr>", desc = "Yazi at file" },
  },
  init = function()
    vim.g.loaded_netrwPlugin = 1
  end,
  opts = {
    open_for_directories = true,
    keymaps = {
      show_help = "<C-?>",
    },
    integrations = {
      grep_in_directory = function(directory)
        Snacks.picker.grep({ dirs = { directory } })
      end,
      grep_in_selected_files = function(selected_files)
        Snacks.picker.grep({ dirs = selected_files })
      end,
      bufdelete_implementation = "bundled-snacks",
    },
  },
}
