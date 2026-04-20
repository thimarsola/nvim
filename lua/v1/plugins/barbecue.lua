-- -----------------------------------------------------------------------------
-- Barbecue
-- https://github.com/utilyre/barbecue.nvim
-- Barbecue is a Neovim plugin that provides a simple way to manage your project
-- structure.
-- -----------------------------------------------------------------------------

return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  opts = function()
    -- Função para obter as cores baseado no background
    local function get_bg_color()
      if vim.o.background == "light" then
        return "#efebd4" -- Modo light (Everforest)
      else
        return "#0f1318" -- Modo dark (Pinnord)
      end
    end

    return {
      kinds = false,
      theme = {
        normal = { bg = get_bg_color() },
      },
    }
  end,
}
