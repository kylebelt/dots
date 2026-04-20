-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- Spelling
vim.opt.spell = false
vim.opt.spelllang = { "en", "pt_br" }

-- Disable delete to clipboard
---@diagnostic disable-next-line: undefined-field
vim.opt.clipboard:append("unnamed")

-- Scrolloff config
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Save options when restarting
vim.opt.sessionoptions = "options"

-- Shared opacity value for neovide transparency toggle
vim.g.neovide_transparent_opacity = 0.7

-- Filled colored column
-- vim.opt.colorcolumn = "88"
