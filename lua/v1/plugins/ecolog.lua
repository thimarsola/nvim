return {
  "philosofonusus/ecolog.nvim",
  lazy = false,
  opts = {
    integrations = {
      blink_cmp = true,
    },
    -- Provider customizado para constant() do WordPress/Bedrock
    providers = {
      {
        pattern = "constant%(['\"][%w_]+['\"]?%)?",
        filetype = "php",
        extract_var = function(line, col)
          local before_cursor = line:sub(1, col + 1)
          return before_cursor:match("constant%(['\"]([%w_]+)['\"]?%)$")
            or before_cursor:match("constant%(['\"]([%w_]+)$")
        end,
        get_completion_trigger = function()
          return "constant('"
        end,
      },
    },
  },
  config = function(_, opts)
    require("ecolog").setup(opts)
  end,
  keys = {
    { "<leader>eg", "<cmd>EcologGoto<cr>", desc = "Ir para variável no .env" },
    { "<leader>ep", "<cmd>EcologPeek<cr>", desc = "Visualizar valor da variável" },
    { "<leader>es", "<cmd>EcologSelect<cr>", desc = "Selecionar arquivo .env" },
  },
}
