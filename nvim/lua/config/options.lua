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
vim.opt.scrolloff = 15
vim.opt.sidescrolloff = 15

-- Save options when restarting
vim.opt.sessionoptions = "options"

-- Shared opacity value for neovide transparency toggle
vim.g.neovide_transparent_opacity = 0.7

-- Auto change cwd to file path
vim.opt.autochdir = true

-- Fix esc sending alt by mistake
vim.opt.ttimeoutlen = 0

-- Fix split behavior
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Disable horizontal mouse scroll
vim.opt.mousescroll = "ver:3,hor:0"

-- Improve window separators
vim.opt.fillchars = {
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
}

-- Set to "basedpyright" to use basedpyright instead of pyright.
vim.g.lazyvim_python_lsp = "ty"
-- Set to "ruff_lsp" to use the old LSP implementation version.
vim.g.lazyvim_python_ruff = "ruff"

-- Whitespace rendering
vim.opt.list = true
vim.opt.listchars = {
  tab = " ",
  leadtab = " ",
  nbsp = "␣",
  trail = "◦",
  lead = "•",
  extends = "…",
  precedes = "…",
}
