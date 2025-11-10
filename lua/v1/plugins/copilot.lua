return {
  -- GitHub Copilot (versão Lua nativa)
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
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
        copilot_node_command = "node",
        server_opts_overrides = {},
      })
    end,
  },

  -- GitHub Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    cmd = {
      "CopilotChat",
      "CopilotChatOpen",
      "CopilotChatClose",
      "CopilotChatToggle",
      "CopilotChatStop",
      "CopilotChatReset",
      "CopilotChatSave",
      "CopilotChatLoad",
      "CopilotChatDebugInfo",
      "CopilotChatExplain",
      "CopilotChatReview",
      "CopilotChatFix",
      "CopilotChatOptimize",
      "CopilotChatDocs",
      "CopilotChatTests",
      "CopilotChatFixDiagnostic",
      "CopilotChatCommit",
      "CopilotChatCommitStaged",
    },
    opts = {
      debug = false,
      model = "gpt-4o",  -- Modelo mais recente e disponível
      temperature = 0.1,
      question_header = "## User ",
      answer_header = "## Copilot ",
      error_header = "## Error ",
      separator = "───",
      show_folds = true,
      show_help = true,
      auto_follow_cursor = true,
      auto_insert_mode = false,
      clear_chat_on_new_prompt = false,
      context = nil,
      history_path = vim.fn.stdpath("data") .. "/copilotchat_history",
      callback = nil,
      mappings = {
        complete = {
          detail = "Use @<Tab> or /<Tab> for options.",
          insert = "<Tab>",
        },
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        reset = {
          normal = "<C-l>",
          insert = "<C-l>",
        },
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        accept_diff = {
          normal = "<C-y>",
          insert = "<C-y>",
        },
        yank_diff = {
          normal = "gy",
        },
        show_diff = {
          normal = "gd",
        },
        show_system_prompt = {
          normal = "gp",
        },
        show_user_selection = {
          normal = "gs",
        },
      },
    },
    config = function(_, opts)
      local chat_ok, chat = pcall(require, "CopilotChat")
      if not chat_ok then
        vim.notify("CopilotChat não pôde ser carregado: " .. tostring(chat), vim.log.levels.ERROR)
        return
      end

      -- Tenta carregar o módulo de seleção
      local select_ok, select = pcall(require, "CopilotChat.select")
      if select_ok then
        opts.selection = select.unnamed
      else
        vim.notify("CopilotChat.select não disponível, usando configuração padrão", vim.log.levels.WARN)
      end

      -- Setup com tratamento de erros detalhado
      local setup_ok, err = pcall(chat.setup, opts)
      if not setup_ok then
        vim.notify("Erro ao configurar CopilotChat: " .. tostring(err), vim.log.levels.ERROR)
        return
      end

      -- Keymaps
      vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CopilotChatToggle<cr>", { desc = "Toggle Copilot Chat" })
      vim.keymap.set({ "n", "v" }, "<leader>ax", "<cmd>CopilotChatReset<cr>", { desc = "Clear Copilot Chat" })
      vim.keymap.set({ "n", "v" }, "<leader>as", "<cmd>CopilotChatStop<cr>", { desc = "Stop Copilot Chat" })
      
      -- Quick chat
      vim.keymap.set({ "n", "v" }, "<leader>aq", function()
        local input = vim.fn.input("Quick Chat: ")
        if input ~= "" then
          local select_ok, select = pcall(require, "CopilotChat.select")
          local selection_opts = select_ok and { selection = select.buffer } or {}

          local ok, err = pcall(function()
            chat.ask(input, selection_opts)
          end)

          if not ok then
            vim.notify("Erro ao enviar mensagem: " .. tostring(err), vim.log.levels.ERROR)
          end
        end
      end, { desc = "Quick Chat" })

      -- Prompt actions
      vim.keymap.set({ "n", "v" }, "<leader>ap", function()
        local actions_ok, actions = pcall(require, "CopilotChat.actions")
        if not actions_ok then
          vim.notify("CopilotChat.actions não disponível", vim.log.levels.ERROR)
          return
        end

        local prompt_actions = actions.prompt_actions()
        if not prompt_actions or vim.tbl_isempty(prompt_actions) then
          vim.notify("Nenhuma ação disponível", vim.log.levels.WARN)
          return
        end

        local has_telescope, telescope = pcall(require, "telescope")
        if has_telescope then
          local ok, integration = pcall(require, "CopilotChat.integrations.telescope")
          if ok then
            integration.pick(prompt_actions)
          else
            -- Fallback para vim.ui.select
            vim.ui.select(vim.tbl_keys(prompt_actions), {
              prompt = "Copilot Chat Actions:",
            }, function(choice)
              if choice and prompt_actions[choice] then
                prompt_actions[choice]()
              end
            end)
          end
        else
          vim.ui.select(vim.tbl_keys(prompt_actions), {
            prompt = "Copilot Chat Actions:",
          }, function(choice)
            if choice and prompt_actions[choice] then
              prompt_actions[choice]()
            end
          end)
        end
      end, { desc = "Copilot Chat Actions" })
      
      -- Predefined prompts
      vim.keymap.set({ "n", "v" }, "<leader>ae", "<cmd>CopilotChatExplain<cr>", { desc = "Explain Code" })
      vim.keymap.set({ "n", "v" }, "<leader>at", "<cmd>CopilotChatTests<cr>", { desc = "Generate Tests" })
      vim.keymap.set({ "n", "v" }, "<leader>ar", "<cmd>CopilotChatReview<cr>", { desc = "Review Code" })
      vim.keymap.set({ "n", "v" }, "<leader>aR", "<cmd>CopilotChatRefactor<cr>", { desc = "Refactor Code" })
      vim.keymap.set({ "n", "v" }, "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", { desc = "Better Naming" })
      vim.keymap.set({ "n", "v" }, "<leader>ad", "<cmd>CopilotChatDocs<cr>", { desc = "Generate Docs" })
      vim.keymap.set({ "n", "v" }, "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", { desc = "Fix Diagnostic" })
      vim.keymap.set({ "n", "v" }, "<leader>ac", "<cmd>CopilotChatCommit<cr>", { desc = "Generate Commit Message" })
      vim.keymap.set({ "n", "v" }, "<leader>aS", "<cmd>CopilotChatCommitStaged<cr>", { desc = "Generate Commit (Staged)" })
    end,
    keys = {
      { "<leader>aa", mode = { "n", "v" }, desc = "Toggle Copilot Chat" },
      { "<leader>ax", mode = { "n", "v" }, desc = "Clear Copilot Chat" },
      { "<leader>aq", mode = { "n", "v" }, desc = "Quick Chat" },
    },
  },
}
