return {
  {
    "r2luna/pinnord.nvim",
    enabled = true,
    priority = 1000,
  },
  {
    -- "maxmx03/solarized.nvim",
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = {
        enabled = false,
      },
    },
  },
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.o.background = "dark"
        vim.cmd("colorscheme pinnord")
        -- Re-apply transparent background in dark mode
        vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
        -- Customizar WinBar para modo dark
        vim.api.nvim_set_hl(0, "WinBar", { fg = "#d8dee9", bg = "#0f1318" })
        vim.api.nvim_set_hl(0, "WinBarNC", { fg = "#8d929c", bg = "#0f1318" })
        -- Customizar Barbecue para modo dark
        vim.api.nvim_set_hl(0, "barbecue_normal", { bg = "#0f1318" })
      end,
      set_light_mode = function()
        vim.o.background = "light"
        vim.cmd("colorscheme everforest")
        -- Customizar WinBar para modo light
        vim.api.nvim_set_hl(0, "WinBar", { fg = "#5c6a72", bg = "#efebd4" })
        vim.api.nvim_set_hl(0, "WinBarNC", { fg = "#939f91", bg = "#efebd4" })
        -- Customizar Barbecue para modo light
        vim.api.nvim_set_hl(0, "barbecue_normal", { bg = "#efebd4" })
      end,
    },
  },
  {
    "r2luna/pinguim.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("pinguim").setup({
        transparent = false,
        italic_comments = true,
      })
      vim.cmd.colorscheme("pinguim")
    end,
  },
}
