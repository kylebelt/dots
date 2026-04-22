-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- Spelling
vim.opt.spell = false
vim.opt.spelllang = { "en", "pt_br" }

-- Disable delete to clipboard
vim.opt.clipboard = ""

-- Scrolloff config
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Save options when restarting
vim.opt.sessionoptions = "options"

-- Shared opacity value for neovide transparency toggle
vim.g.neovide_transparent_opacity = 0.7

-- Auto change cwd to file path
vim.opt.autochdir = true

-- Fix esc sending alt by mistake
vim.o.ttimeoutlen = 0

-- Fix split behavior
vim.o.splitbelow = true
vim.o.splitright = true
