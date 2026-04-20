return {
  "folke/todo-comments.nvim",
  config = function()
    require("todo-comments").setup({
      keywords = {
        SECTION = {
          icon = "󰚟 ",
          color = "test",
        },
      },
    })
  end,
}
