-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local opts = { noremap = true, silent = true }

--  Search and center search result
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Multi Line visual indent
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Disable console
vim.keymap.set("n", "Q", "<nop>")

-- Restart nvim and restore session
vim.keymap.set("n", "<leader>qr", function()
  local session = vim.fn.stdpath("state") .. "/restart_session.vim"
  vim.cmd("mksession! " .. vim.fn.fnameescape(session))
  vim.cmd("restart source " .. vim.fn.fnameescape(session))
end, { desc = "Restart Neovim" })

-- Remaped line movement
vim.keymap.set("n", "<A-J>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-K>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
vim.keymap.set("v", "<A-J>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-K>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- opt+backspace: delete back word (stops at punctuation)
vim.keymap.set("i", "<M-BS>", "<C-w>", opts)

-- Paste preserving default register
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste preserving the default register" })

-- Add <number>j/k to Jumplist
vim.keymap.set({ "n", "x" }, "j", function()
  return vim.v.count > 1 and "m'" .. vim.v.count .. "j" or "j"
end, { noremap = true, expr = true })

vim.keymap.set({ "n", "x" }, "k", function()
  return vim.v.count > 1 and "m'" .. vim.v.count .. "k" or "k"
end, { noremap = true, expr = true })
