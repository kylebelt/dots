return {
  {
    "nvim-mini/mini.files",
    opts = {
      mappings = {
        go_in = "<CR>",
        go_out = "-",
      },
      windows = {
        preview = true,
        width_preview = 88,
        width_focus = 50,
        width_nofocus = 15,
      },
    },
  },
  {
    "nvim-mini/mini.splitjoin",
    opts = {},
  },
  {
    "nvim-mini/mini.operators",
    opts = {
      sort = { prefix = "gz" },
    },
  },
  {
    "nvim-mini/mini.bracketed",
    event = "VeryLazy",
    opts = {
      buffer = { suffix = "" },
      comment = { suffix = "" },
      file = { suffix = "" },
      quickfix = { suffix = "" },
      window = { suffix = "" },
      yank = { suffix = "" },
    },
    keys = {
      {
        "[zc",
        function()
          require("mini.bracketed").comment("backward")
        end,
        desc = "Prev comment block",
      },
      {
        "]zc",
        function()
          require("mini.bracketed").comment("forward")
        end,
        desc = "Next comment block",
      },
      {
        "[zf",
        function()
          require("mini.bracketed").file("backward")
        end,
        desc = "Prev file on disk",
      },
      {
        "]zf",
        function()
          require("mini.bracketed").file("forward")
        end,
        desc = "Next file on disk",
      },
      {
        "[zq",
        function()
          require("mini.bracketed").quickfix("backward")
        end,
        desc = "Prev Quickfix",
      },
      {
        "]zq",
        function()
          require("mini.bracketed").quickfix("forward")
        end,
        desc = "Next Quickfix",
      },
      {
        "[Q",
        function()
          require("mini.bracketed").quickfix("first")
        end,
        desc = "First Quickfix",
      },
      {
        "]Q",
        function()
          require("mini.bracketed").quickfix("last")
        end,
        desc = "Last Quickfix",
      },
      {
        "[W",
        function()
          require("mini.bracketed").window("first")
        end,
        desc = "First Window",
      },
      {
        "]W",
        function()
          require("mini.bracketed").window("last")
        end,
        desc = "Last Window",
      },
      {
        "[w",
        function()
          require("mini.bracketed").window("backward")
        end,
        desc = "Prev Window",
      },
      {
        "]w",
        function()
          require("mini.bracketed").window("forward")
        end,
        desc = "Next Window",
      },
      {
        "[zw",
        function()
          vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN })
        end,
        desc = "Prev Warning",
      },
      {
        "]zw",
        function()
          vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN })
        end,
        desc = "Next Warning",
      },
      {
        "[zy",
        function()
          require("mini.bracketed").yank("backward")
        end,
        desc = "Prev yank",
      },
      {
        "]zy",
        function()
          require("mini.bracketed").yank("forward")
        end,
        desc = "Next yank",
      },
    },
  },
}
