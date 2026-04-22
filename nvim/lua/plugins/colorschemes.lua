return {
  {
    "xiyaowong/transparent.nvim",
    config = function()
      require("transparent").setup({
        exclude_groups = { "CursorLine", "CursorLineNr" },
      })
    end,
  },

  {
    "ember-theme/nvim",
    name = "ember",
    lazy = false,
    priority = 1000,
  },

  {
    "tiagovla/tokyodark.nvim",
    name = "tokyodark",
    lazy = false,
    priority = 1000,
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
  },

  {
    "Mofiqul/dracula.nvim",
    name = "dracula",
    lazy = false,
    priority = 1000,
  },

  {
    "shaunsingh/nord.nvim",
    name = "nord",
    lazy = true,
    priority = 1000,
  },

  {
    "sainnhe/gruvbox-material",
    name = "gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_statusline_style = "default" -- default/mix/original
      vim.g.gruvbox_material_float_style = "brigit" -- bright/dim/blend
    end,
  },

  {
    "sainnhe/edge",
    name = "edge",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.edge_enable_italic = true
      vim.g.edge_style = "aura" -- default/aura/neon
      vim.g.edge_float_style = "bright" -- brigt/dim/blend
      vim.g.edge_better_performance = 1
    end,
  },

  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_enable_italic = true
      vim.g.everforest_float_style = "bright" --bright/dim/blend
    end,
  },

  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.sonokai_style = "default" -- default/atlantis/andromeda/shusia/maia/espresso
      vim.g.sonokai_float_style = "bright" --bright/dim/blend
      vim.g.sonokai_enable_italic = true
    end,
  },

  {
    "shatur/neovim-ayu",
    name = "ayu",
    lazy = false,
    priority = 1000,
  },

  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
            variables = "bold",
            constants = "bold",
            functions = "italic",
            operators = "bold",
            strings = "italic",
          },
        },
      })
    end,
  },
  {
    "savq/melange-nvim",
  },

  {
    "wtfox/jellybeans.nvim",
    lazy = false,
    priority = 1000,
  },

  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
  },

  {
    "dgox16/oldworld.nvim",
    lazy = false,
    priority = 1000,
  },

  {
    "uloco/bluloco.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
      require("bluloco").setup({
        style = "dark",
        italics = true,
      })
    end,
  },

  {
    "miikanissi/modus-themes.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("modus-themes").setup({
        style = "modus_operandi",
        dim_inactive = true,
        hide_inactive_statusline = false,
      })
    end,
  },

  {
    "https://gitlab.com/shmerl/neogotham",
    lazy = false, -- to make sure it's loaded on startup
    priority = 1000, -- to load before other plugins
    config = function()
      require("neogotham").setup({})
    end,
  },

  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.moonflyUnderlineMatchParen = true
    end,
  },

  {
    "ptdewey/darkearth-nvim",
    lazy = false,
    priority = 1000,
  },

  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        theme = "dark", -- auto/dark/light
        italic_comments = true,
      })
    end,
  },

  {
    "olivercederborg/poimandres.nvim",
    lazy = false,
    priority = 1000,
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        theme = "wave", -- wave/lotus/dragon
        undercurl = true,
        dimInactive = true,
      })
    end,
  },

  {
    "olimorris/onedarkpro.nvim",
    name = "onedarkpro",
    lazy = false,
    priority = 1000, -- Ensure it loads first
  },

  {
    "vague-theme/vague.nvim",
    name = "vague",
    lazy = false,
    priority = 1000,
  },

  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
  },

  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
  },

  {
    "marko-cerovac/material.nvim",
    lazy = false,
    priority = 1000,
  },

  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
  },

  {
    "akinsho/horizon.nvim",
    version = "*",
  },

  {
    "NTBBloodbath/doom-one.nvim",
  },
}
