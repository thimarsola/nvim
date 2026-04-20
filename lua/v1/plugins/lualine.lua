return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local lsp_status = {
        function()
          local msg = "No LSP"
          local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
          local clients = vim.lsp.get_clients({ bufnr = 0 })

          if next(clients) == nil then
            return msg
          end

          local lsps = {}
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.tbl_contains(filetypes, buf_ft) then
              table.insert(lsps, client.name)
            end
          end

          if #lsps == 0 then
            return msg
          else
            return "  " .. table.concat(lsps, " | ")
          end
        end,
        color = {},
      }

      -- Função para obter o tema baseado no background
      local function get_theme()
        if vim.o.background == "light" then
          -- Cores para modo light (Everforest)
          return {
            normal = {
              a = { bg = "#efebd4", fg = "#5c6a72" },
              b = { bg = "#efebd4", fg = "#5c6a72" },
              c = { bg = "#efebd4", fg = "#5c6a72" },
            },
            insert = {
              a = { bg = "#efebd4", fg = "#83b370" },
              b = { bg = "#efebd4", fg = "#5c6a72" },
              c = { bg = "#efebd4", fg = "#5c6a72" },
            },
            visual = {
              a = { bg = "#efebd4", fg = "#d99a5e" },
              b = { bg = "#efebd4", fg = "#5c6a72" },
              c = { bg = "#efebd4", fg = "#5c6a72" },
            },
            replace = {
              a = { bg = "#efebd4", fg = "#f57d75" },
              b = { bg = "#efebd4", fg = "#5c6a72" },
              c = { bg = "#efebd4", fg = "#5c6a72" },
            },
            command = {
              a = { bg = "#efebd4", fg = "#35a77c" },
              b = { bg = "#efebd4", fg = "#5c6a72" },
              c = { bg = "#efebd4", fg = "#5c6a72" },
            },
            inactive = {
              a = { bg = "#efebd4", fg = "#939f91" },
              b = { bg = "#efebd4", fg = "#939f91" },
              c = { bg = "#efebd4", fg = "#939f91" },
            },
          }
        else
          -- Cores para modo dark (Pinnord)
          return {
            normal = {
              a = { bg = "#0f1318", fg = "#d8dee9" },
              b = { bg = "#0f1318", fg = "#d8dee9" },
              c = { bg = "#0f1318", fg = "#d8dee9" },
            },
            insert = {
              a = { bg = "#0f1318", fg = "#a3be8c" },
              b = { bg = "#0f1318", fg = "#d8dee9" },
              c = { bg = "#0f1318", fg = "#d8dee9" },
            },
            visual = {
              a = { bg = "#0f1318", fg = "#ebcb8b" },
              b = { bg = "#0f1318", fg = "#d8dee9" },
              c = { bg = "#0f1318", fg = "#d8dee9" },
            },
            replace = {
              a = { bg = "#0f1318", fg = "#bf616a" },
              b = { bg = "#0f1318", fg = "#d8dee9" },
              c = { bg = "#0f1318", fg = "#d8dee9" },
            },
            command = {
              a = { bg = "#0f1318", fg = "#88c0d0" },
              b = { bg = "#0f1318", fg = "#d8dee9" },
              c = { bg = "#0f1318", fg = "#d8dee9" },
            },
            inactive = {
              a = { bg = "#0f1318", fg = "#8d929c" },
              b = { bg = "#0f1318", fg = "#8d929c" },
              c = { bg = "#0f1318", fg = "#8d929c" },
            },
          }
        end
      end

      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = get_theme(),
          component_separators = "|",
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          -- lualine_a = { { "mode", fmt = formatMode } },
          lualine_a = { "" },
          lualine_b = { "" },
          lualine_c = { "" },
          -- lualine_c = { require("auto-session.lib").current_session_name, "filename" },
          -- lualine_c = { { "filename", path = 1 } },
          -- lualine_c = { "" },
          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = { error = " ", warn = " ", info = " " },
              -- diagnostics_color = {
              --   color_error = { fg = colors.red },
              --   color_warn = { fg = colors.yellow },
              --   color_info = { fg = colors.cyan },
              -- },
            },
            {
              "diff",
              symbols = { added = " ", modified = " ", removed = " " },
              -- diff_color = {
              --   added = { fg = colors.green },
              --   modified = { fg = colors.orange },
              --   removed = { fg = colors.red },
              -- },
            },
            "encoding",
            "fileformat",
            "filetype",
            lsp_status,
            "location",
          },
          lualine_y = { "" },
          lualine_z = { "" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      })

      -- Atualizar lualine quando o background mudar
      vim.api.nvim_create_autocmd("OptionSet", {
        pattern = "background",
        callback = function()
          require("lualine").setup({
            options = {
              theme = get_theme(),
            },
          })
        end,
      })
    end,
  },
}
