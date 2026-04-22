return {
  "folke/todo-comments.nvim",
  config = function()
    require("todo-comments").setup({
      keywords = {
        SECTION = {
          icon = "󰚟 ",
          color = "#ff75a0",
        },
        colors = {
          section = { "#ff75a0" },
        },
      },
    })
  end,
}
