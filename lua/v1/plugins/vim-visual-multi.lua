return {
  "mg979/vim-visual-multi",
  event = "VeryLazy",
  init = function()
    vim.g.VM_maps = {
      ["Find Under"] = "<C-d>",
      ["Find Subword Under"] = "<C-d>",
      ["Add Cursor Down"] = "<C-Down>",
      ["Add Cursor Up"] = "<C-Up>",
    }
  end,
}
