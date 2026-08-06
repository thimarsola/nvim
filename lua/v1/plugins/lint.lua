-- ----------------------------------------------------------------------------------------------------------
-- nvim-lint configuration file
-- Plugin URL: https://github.com/mfussenegger/nvim-lint
-- Description: Diagnósticos vindos de linters externos. PHPStan não possui um language server oficial,
--              então ele é executado como linter e o resultado vira diagnóstico nativo do Neovim.
-- ----------------------------------------------------------------------------------------------------------

local uv = vim.uv or vim.loop

local CONFIG_NAMES = { "phpstan.neon", "phpstan.neon.dist", "phpstan.dist.neon" }

local function path_exists(path)
  return path and uv.fs_stat(path) ~= nil
end

local function project_root(bufnr)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  if filename == "" then
    return vim.fn.getcwd()
  end

  local markers = vim.list_extend(vim.deepcopy(CONFIG_NAMES), { "composer.json", ".git" })

  return vim.fs.root(filename, markers) or vim.fn.getcwd()
end

-- PHPStan só roda com um config file: sem ele o binário aborta com
-- "You must configure the `level` parameter".
local function phpstan_config(root)
  for _, name in ipairs(CONFIG_NAMES) do
    local path = root .. "/" .. name
    if path_exists(path) then
      return path
    end
  end

  return nil
end

-- Prefere o binário do projeto: extensões (larastan, phpstan-strict-rules) e
-- autoload das classes só existem no vendor local.
local function phpstan_bin(root)
  local local_bin = root .. "/vendor/bin/phpstan"
  if path_exists(local_bin) then
    return local_bin
  end

  if vim.fn.executable("phpstan") == 1 then
    return "phpstan"
  end

  return nil
end

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      php = { "phpstan" },
    }

    lint.linters.phpstan.args = {
      "analyse",
      "--error-format=json",
      "--no-progress",
      "--memory-limit=1G",
    }

    local function try_lint()
      local bufnr = vim.api.nvim_get_current_buf()
      local root = project_root(bufnr)
      local bin = phpstan_bin(root)

      if not bin or not phpstan_config(root) then
        return
      end

      -- `cmd` e `cwd` precisam ser strings: o nvim-lint repassa `linter.cwd`
      -- direto para uv.spawn sem avaliar funções. Resolvidos por buffer aqui.
      lint.linters.phpstan.cmd = bin
      lint.linters.phpstan.cwd = root

      lint.try_lint("phpstan")
    end

    -- Só no save: PHPStan é lento demais para rodar a cada tecla.
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = vim.api.nvim_create_augroup("v1-lint", { clear = true }),
      pattern = { "*.php" },
      callback = try_lint,
    })

    vim.api.nvim_create_user_command("Lint", try_lint, { desc = "Run linters for the current buffer" })
  end,
}
