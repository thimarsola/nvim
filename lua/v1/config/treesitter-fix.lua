-- -----------------------------------------------------------------------------
-- Treesitter Error Protection
-- Proteção contra erros de conceal com nós inválidos do treesitter
-- Este arquivo previne o erro:
-- "attempt to call method 'range' (a nil value)"
-- -----------------------------------------------------------------------------

-- Adiciona proteção para evitar erros quando decoration providers
-- tentam acessar nós inválidos do treesitter
local ok, ts = pcall(require, "vim.treesitter")
if ok then
  -- Wrapper seguro para get_node_text que valida o nó antes de processar
  local original_get_node_text = ts.get_node_text
  ts.get_node_text = function(node, ...)
    -- Verifica se o nó é válido antes de processar
    if not node or type(node) ~= "userdata" then
      return ""
    end

    -- Verifica se o nó tem o método range
    local has_range = pcall(function()
      return node:range()
    end)

    if not has_range then
      return ""
    end

    -- Se tudo estiver ok, chama a função original
    return original_get_node_text(node, ...)
  end
end

-- Configuração adicional para evitar erros de conceal
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown" },
  callback = function()
    -- Desabilita temporariamente conceal em modo de inserção
    -- para evitar erros durante a digitação
    vim.opt_local.concealcursor = "nc"
  end,
})
