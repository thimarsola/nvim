return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble",
  opts = {
    focus = true,
  },
  keys = {
    -- Diagnostics
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    -- Symbols (like Structure in PHPStorm)
    {
      "<leader>xs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    -- LSP references/definitions (like Find Usages in PHPStorm)
    {
      "<leader>xr",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / References / ... (Trouble)",
    },
    -- Location list
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    -- Quickfix list
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
    -- Jump to next/previous trouble item
    {
      "[t",
      function()
        require("trouble").prev({ skip_groups = true, jump = true })
      end,
      desc = "Previous Trouble",
    },
    {
      "]t",
      function()
        require("trouble").next({ skip_groups = true, jump = true })
      end,
      desc = "Next Trouble",
    },
  },
}
