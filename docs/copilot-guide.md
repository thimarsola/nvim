# GitHub Copilot & CopilotChat - Guia de Uso

## 🚀 Instalação

Os plugins já estão configurados em `lua/v1/plugins/copilot.lua`:

- **copilot.lua** - Sugestões inline de código
- **CopilotChat.nvim** - Interface de chat com AI

## 🔑 Autenticação

Na primeira vez que usar o Copilot, você precisará fazer login:

```
:Copilot auth
```

Siga as instruções para autenticar com sua conta do GitHub.

## 💡 Sugestões de Código (Copilot.lua)

### Atalhos de Sugestão Inline

- **`Alt+l`** - Aceitar sugestão
- **`Alt+]`** - Próxima sugestão
- **`Alt+[`** - Sugestão anterior
- **`Ctrl+]`** - Descartar sugestão

### Comandos

- `:Copilot status` - Ver status do Copilot
- `:Copilot enable` - Ativar Copilot
- `:Copilot disable` - Desativar Copilot

## 💬 CopilotChat - Chat com AI

### Atalhos Principais

| Atalho | Modo | Descrição |
|--------|------|-----------|
| `<leader>aa` | Normal/Visual | Toggle Copilot Chat |
| `<leader>ax` | Normal/Visual | Limpar chat |
| `<leader>as` | Normal/Visual | Parar resposta |
| `<leader>aq` | Normal/Visual | Quick chat (input rápido) |
| `<leader>ap` | Normal/Visual | Mostrar ações do Copilot |

### Prompts Predefinidos

| Atalho | Descrição |
|--------|-----------|
| `<leader>ae` | Explicar código selecionado |
| `<leader>at` | Gerar testes |
| `<leader>ar` | Revisar código |
| `<leader>aR` | Refatorar código |
| `<leader>an` | Sugerir nomes melhores |
| `<leader>ad` | Gerar documentação |
| `<leader>af` | Corrigir diagnóstico |
| `<leader>ac` | Gerar mensagem de commit |
| `<leader>aS` | Gerar commit para staged files |

### Dentro do Chat

Quando o chat estiver aberto:

- **`Tab`** - Autocompletar @ ou / para opções
- **`Enter`** - Enviar prompt (modo normal)
- **`Ctrl+s`** - Enviar prompt (modo insert)
- **`q`** - Fechar chat (modo normal)
- **`Ctrl+c`** - Fechar chat (modo insert)
- **`Ctrl+l`** - Limpar chat
- **`Ctrl+y`** - Aceitar diff
- **`gy`** - Copiar diff
- **`gd`** - Mostrar diff
- **`gp`** - Mostrar system prompt
- **`gs`** - Mostrar seleção do usuário

## 📝 Exemplos de Uso

### 1. Explicar código complexo

1. Selecione o código no modo visual (`v`)
2. Pressione `<leader>ae`
3. O Copilot explicará o código

### 2. Gerar testes

1. Selecione a função/classe
2. Pressione `<leader>at`
3. O Copilot gerará testes apropriados

### 3. Chat rápido

1. Pressione `<leader>aq`
2. Digite sua pergunta
3. Enter para enviar

### 4. Refatoração

1. Selecione o código
2. Pressione `<leader>aR`
3. O Copilot sugerirá melhorias

### 5. Commit inteligente

1. Faça suas alterações no git
2. Pressione `<leader>ac`
3. O Copilot gerará uma mensagem de commit baseada nas mudanças

## 🎯 Dicas

- Use seleção visual para contexto específico
- O chat mantém histórico da conversa
- Você pode fazer perguntas de follow-up
- Use `@<Tab>` no chat para ver opções de contexto
- Use `/<Tab>` para ver comandos especiais

## ⚙️ Configuração

Arquivos de configuração:
- Principal: `~/.config/nvim/lua/v1/plugins/copilot.lua`
- Histórico: `~/.local/share/nvim/copilotchat_history/`

## 🔧 Troubleshooting

### Copilot não está funcionando

```vim
:Copilot status
:Copilot setup
```

### Chat não abre

Verifique se você tem Node.js instalado:
```bash
node --version
```

### Reinstalar plugins

```vim
:Lazy sync
```

## 📚 Recursos Adicionais

- [Copilot.lua GitHub](https://github.com/zbirenbaum/copilot.lua)
- [CopilotChat.nvim GitHub](https://github.com/CopilotC-Nvim/CopilotChat.nvim)
- [GitHub Copilot Docs](https://docs.github.com/en/copilot)
