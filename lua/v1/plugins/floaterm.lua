return {
  "voldikss/vim-floaterm",
  branch = "master",
  config = function()
    vim.keymap.set("n", "<leader>.", "<cmd>FloatermToggle<cr>", { desc = "Toggle terminal", silent = true })
    vim.keymap.set("t", "<C-q>", "<C-\\><C-n>:FloatermHide<CR>")

    -- hunk (modem-dev): TUI diff viewer. Abre em floaterm dedicado, auto-fecha ao sair.
    vim.keymap.set("n", "<leader>hd", "<cmd>FloatermNew --autoclose=2 hunk diff<cr>",
      { desc = "Hunk: diff working tree", silent = true })
    vim.keymap.set("n", "<leader>hs", "<cmd>FloatermNew --autoclose=2 hunk diff --staged<cr>",
      { desc = "Hunk: diff staged", silent = true })
    vim.keymap.set("n", "<leader>hc", "<cmd>FloatermNew --autoclose=2 hunk show<cr>",
      { desc = "Hunk: show last commit", silent = true })

    vim.g.floaterm_gitcommit = "floaterm"
    vim.g.floaterm_autoinsert = 1
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
    vim.g.floaterm_wintitle = 0
    vim.g.floaterm_autoclose = 2
    vim.g.floaterm_title = "$1 / $2"
    vim.g.floaterm_winblend = 20

    -- vim.cmd([[
    --     highlight link Floaterm CursorLine
    --     highlight link FloatermBorder CursorLineBg
    --   ]])
  end,
}
