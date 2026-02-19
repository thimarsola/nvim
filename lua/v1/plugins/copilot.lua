return {
  -- GitHub Copilot (versão Lua nativa)
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = { "InsertEnter", "BufReadPost" }, -- Carrega mais cedo para estabilidade
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-j>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = {
          enabled = false, -- Desabilita o panel para evitar conflitos
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        -- Usar path absoluto do node para evitar problemas de PATH
        copilot_node_command = vim.fn.exepath("node") ~= "" and vim.fn.exepath("node") or "node",
        server_opts_overrides = {
          -- Aumenta timeouts para conexões mais estáveis
          trace = "off",
          settings = {
            advanced = {
              listCount = 10,
              inlineSuggestCount = 3,
            },
          },
        },
      })

      -- Comando para reiniciar o Copilot sem reiniciar o Neovim
      vim.api.nvim_create_user_command("CopilotRestart", function()
        vim.cmd("Copilot disable")
        vim.defer_fn(function()
          vim.cmd("Copilot enable")
          vim.notify("Copilot reiniciado!", vim.log.levels.INFO)
        end, 500)
      end, { desc = "Reinicia o Copilot" })

      -- Auto-restart quando detectar desconexão (opcional)
      vim.api.nvim_create_autocmd("User", {
        pattern = "CopilotError",
        callback = function()
          vim.notify("Copilot desconectou, tentando reconectar...", vim.log.levels.WARN)
          vim.defer_fn(function()
            vim.cmd("Copilot enable")
          end, 1000)
        end,
      })
    end,
  },
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
  },
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Recommended for `ask()` and `select()`.
      -- Required for `snacks` provider.
      ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
      "folke/snacks.nvim",
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
      }

      -- Required for `opts.events.reload`.
      vim.o.autoread = true

      -- All the keymaps are configured on the keymaps.lua file
    end,
  },
}
