-- ----------------------------------------------------------------------------------------------------------
-- Conform.nvim configuration file
-- Plugin URL: https://github.com/stevearc/conform.nvim
-- Description: A Neovim plugin for formatting code using external formatters.
-- ----------------------------------------------------------------------------------------------------------

local uv = vim.uv or vim.loop

local function path_exists(path)
  return path and uv.fs_stat(path) ~= nil
end

local function find_project_root(filename)
  if not filename or filename == "" then
    return vim.fn.getcwd()
  end

  return vim.fs.root(filename, { "composer.json", "artisan", ".git" }) or vim.fn.getcwd()
end

local function read_file(path)
  local file = io.open(path, "rb")
  if not file then
    return nil
  end

  local content = file:read("*a")
  file:close()

  return content
end

local function is_bedrock_project(root)
  local composer_json = read_file(root .. "/composer.json")

  return (composer_json and composer_json:find('"roots/bedrock"', 1, true) ~= nil)
    or path_exists(root .. "/config/application.php")
    or path_exists(root .. "/web/app")
end

local function is_laravel_project(root)
  local composer_json = read_file(root .. "/composer.json")

  return not is_bedrock_project(root)
    and (
      path_exists(root .. "/artisan")
      or (composer_json and composer_json:find('"laravel/framework"', 1, true) ~= nil)
      or (composer_json and composer_json:find('"laravel/laravel"', 1, true) ~= nil)
    )
end

local function has_local_pint(root)
  return path_exists(root .. "/vendor/bin/pint")
end

local function should_use_pint(bufnr)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local root = find_project_root(filename)

  return root and has_local_pint(root) and is_laravel_project(root)
end

local function php_formatters(bufnr)
  if should_use_pint(bufnr) then
    return { "pint" }
  end

  -- No external formatter here lets Conform fall back to Intelephense,
  -- which handles mixed PHP/HTML better for WordPress templates.
  return {}
end

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true }, function(err, did_edit)
          if not err and did_edit then
            vim.notify("Code formatted", vim.log.levels.INFO, { title = "Conform" })
          end

          if err then
            vim.notify("Error formatting code: " .. err, vim.log.levels.ERROR, { title = "Conform" })
          end
        end)
      end,
      mode = { "n", "v" },
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    -- log_level = vim.log.levels.DEBUG,
    notify_on_error = false,

    formatters = {
      pint = {
        -- Sempre usar PHP local ao invés do Docker
        command = "php",
        args = { "vendor/bin/pint", "--quiet", "$FILENAME" },
        cwd = function(_, ctx)
          return find_project_root(ctx.filename)
        end,
        condition = function(_, ctx)
          local root = find_project_root(ctx.filename)
          return root and has_local_pint(root) and is_laravel_project(root)
        end,
        stdin = false,
      },
    },

    formatters_by_ft = {
      -- XML
      xml = { "xlmformat" },

      -- Go
      go = { "goimports", "gofmt" },

      -- Lua
      lua = { "stylua" },

      -- Web technologies
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      jsonc = { "prettierd", "prettier", stop_after_first = true },
      yaml = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      blade = { "prettier" },
      css = { "prettierd", "prettier", stop_after_first = true },
      scss = { "prettierd", "prettier", stop_after_first = true },

      -- Python
      -- python = { "isort", "black" },

      -- PHP/Laravel uses Pint only when the current project is Laravel.
      -- WordPress/Bedrock falls back to Intelephense for mixed PHP/HTML.
      php = php_formatters,

      -- Shell
      sh = { "shfmt" },
      bash = { "shfmt" },

      -- Other (system tools)
      -- rust = { "rustfmt" }, -- comes with Rust installation
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = {
      timeout_ms = 1000,
      lsp_format = "fallback",
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
