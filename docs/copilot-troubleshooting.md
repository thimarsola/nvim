# Copilot Troubleshooting - Guia de Diagnóstico

## 🔍 Como Diagnosticar Erros

### 1. Verificar Status do Copilot

Abra o Neovim e execute:
```vim
:Copilot status
```

**Possíveis resultados:**
- ✅ "Copilot: Ready" - Tudo funcionando
- ❌ "Copilot: Not authenticated" - Precisa autenticar
- ❌ "Copilot: Error" - Há um problema

### 2. Verificar Mensagens de Erro

Abra o Neovim e execute:
```vim
:messages
```

Procure por erros relacionados a "CopilotChat" ou "Copilot".

### 3. Verificar Health Check

```vim
:checkhealth copilot
:checkhealth CopilotChat
```

### 4. Ver Logs do Lazy

```vim
:Lazy log CopilotChat.nvim
:Lazy log copilot.lua
```

## 🛠️ Soluções para Problemas Comuns

### Problema: "CopilotChat not loaded"

**Causa:** O plugin não foi carregado corretamente.

**Solução:**
```vim
:Lazy sync
:Lazy load CopilotChat.nvim
```

Reinicie o Neovim.

### Problema: "Not authenticated" ou "401 Unauthorized"

**Causa:** Você não está autenticado no GitHub.

**Solução:**
```vim
:Copilot auth
```

Siga o processo:
1. Um código aparecerá
2. Pressione Enter para abrir o navegador
3. Cole o código no site do GitHub
4. Autorize o Copilot

### Problema: Erro ao abrir o chat (,aa)

**Possíveis causas e soluções:**

#### Causa 1: Node.js não encontrado

Verifique se o Node.js está instalado:
```bash
node --version
```

Se não estiver instalado, instale:
```bash
# macOS com Homebrew
brew install node

# ou use o Herd que você já tem
# O node já deve estar em: ~/Library/Application Support/Herd/config/nvm/versions/node/
```

#### Causa 2: Conflito com outras configurações

Teste com configuração mínima:
```bash
nvim --clean -u ~/.config/nvim/test-copilot.lua
```

Crie o arquivo `test-copilot.lua`:
```lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = true },
      })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      require("CopilotChat").setup()
    end,
  },
})

vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChatToggle<cr>")
```

### Problema: Copilot.lua funciona, mas CopilotChat não

**Solução 1: Reinstalar CopilotChat**
```vim
:Lazy clean
:Lazy sync
```

**Solução 2: Verificar versão do Neovim**
```bash
nvim --version
```

CopilotChat requer Neovim >= 0.10.0

**Solução 3: Limpar cache**
```bash
rm -rf ~/.local/share/nvim/lazy/CopilotChat.nvim
rm -rf ~/.local/share/nvim/copilotchat_history
```

Depois:
```vim
:Lazy sync
```

### Problema: "curl" ou "connection" error

**Causa:** Problemas de rede ou proxy.

**Solução:**

1. Verifique sua conexão com a internet
2. Verifique se você tem acesso ao GitHub
3. Se usar proxy, configure:

```bash
export https_proxy=http://seu-proxy:porta
export http_proxy=http://seu-proxy:porta
```

### Problema: Comandos não são reconhecidos

**Exemplos:**
- `:CopilotChatToggle` - comando não encontrado
- `:CopilotChatExplain` - comando não encontrado

**Causa:** Plugin não foi carregado.

**Solução:**

1. Força o carregamento:
```vim
:Lazy load CopilotChat.nvim
```

2. Verifica se está instalado:
```vim
:Lazy
```

Procure por "CopilotChat.nvim" na lista.

### Problema: Erro específico com "model" ou "gpt-4"

**Causa:** Sua conta pode não ter acesso ao modelo especificado.

**Solução:** Edite `lua/v1/plugins/copilot.lua` e mude:

```lua
model = "gpt-4",
```

Para:
```lua
model = "gpt-3.5-turbo",
```

## 🧪 Testes Manuais

### Teste 1: Carregar Plugin Manualmente

```vim
:lua require('CopilotChat').setup()
```

Se houver erro, copie a mensagem completa.

### Teste 2: Ver Configuração Atual

```vim
:lua print(vim.inspect(require('lazy').plugins()['CopilotChat.nvim']))
```

### Teste 3: Testar Função Ask

```vim
:lua require('CopilotChat').ask("Hello, can you hear me?")
```

### Teste 4: Verificar Dependências

```vim
:lua print(vim.fn.executable('node'))
:lua print(vim.fn.executable('curl'))
```

Ambos devem retornar 1.

## 📋 Coleta de Informações para Debug

Se o problema persistir, colete estas informações:

```bash
# Versão do Neovim
nvim --version

# Versão do Node
node --version

# Sistema operacional
uname -a

# Plugins instalados
ls -la ~/.local/share/nvim/lazy/ | grep -i copilot

# Verificar erro específico no Neovim
nvim +":messages" +q
```

## 🔄 Reset Completo

Se nada funcionar, faça um reset completo:

```bash
# 1. Backup da configuração
cp -r ~/.config/nvim ~/.config/nvim.backup

# 2. Limpar cache e plugins
rm -rf ~/.local/share/nvim/lazy/copilot.lua
rm -rf ~/.local/share/nvim/lazy/CopilotChat.nvim
rm -rf ~/.local/share/nvim/copilotchat_history

# 3. Reabrir Neovim
nvim

# 4. Reinstalar
:Lazy sync

# 5. Autenticar
:Copilot auth
```

## 📞 Onde Obter Ajuda

- GitHub Copilot.lua: https://github.com/zbirenbaum/copilot.lua/issues
- GitHub CopilotChat: https://github.com/CopilotC-Nvim/CopilotChat.nvim/issues
- Documentação oficial: `:help CopilotChat`

## 💡 Dica Final

**Execute este comando para ver o erro específico:**

```vim
:lua vim.notify = print
:CopilotChatToggle
:messages
```

Isso mostrará exatamente qual é o erro para que possamos corrigi-lo!
