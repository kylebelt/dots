return {
  "michaelb/sniprun",
  branch = "master",
  enabled = true,

  build = "sh install.sh && ln -sfn ~/Library/Caches/sniprun ~/.cache/sniprun",
  -- do 'sh install.sh 1' if you want to force compile locally
  -- (instead of fetching a binary from the github release). Requires Rust >= 1.65

  opts = {
    selected_interpreters = { "Python3_fifo" },
    repl_enable = { "Python3_fifo" },
    display = { "TempFloatingWindow" },
  },
  keys = {
    { "<leader>RR", "<cmd>%SnipRun<cr>", desc = "SnipRun entire file", silent = true },
    { "<leader>R", "<Plug>SnipRunOperator", desc = "SnipRun (operator)", silent = true },
    { "<leader>R", "<Plug>SnipRun", mode = "v", desc = "SnipRun selection", silent = true },
    { "<leader>Rc", "<Plug>SnipReplMemoryClean", desc = "Clean SnipRun memory", silent = true },
    { "<leader>Rr", "<Plug>SnipReset", desc = "Reset SnipRun", silent = true },
    { "<leader>Rx", "<Plug>SnipClose", desc = "Close SnipRun", silent = true },
  },
}
