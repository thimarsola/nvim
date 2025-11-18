# Neovim Configuration

Uma configuração moderna e completa do Neovim focada em desenvolvimento web (PHP, JavaScript/TypeScript, Vue, React) com suporte robusto para LSP, autocompletion, Git e banco de dados.

## Características

- **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim) para gerenciamento rápido e eficiente de plugins
- **LSP**: Configuração completa com múltiplos Language Servers
- **Autocompletion**: [blink.cmp](https://github.com/saghen/blink.cmp) com suporte a snippets
- **Fuzzy Finding**: FZF e Telescope com frecency
- **Git Integration**: Lazygit, Gitsigns, Fugitive e Diffview
- **Database**: Suporte completo com vim-dadbod e nvim-dbee
- **Testing**: Neotest com suporte para PHPUnit e Pest
- **AI Assistant**: GitHub Copilot integrado
- **Markdown**: Renderização e suporte para Obsidian

## Requisitos

- Neovim >= 0.9.0
- Git
- Node.js (para alguns LSP servers)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (para busca)
- [fd](https://github.com/sharkdp/fd) (opcional, para melhor performance de busca)
- [lazygit](https://github.com/jesseduffield/lazygit) (para integração Git)
- Uma [Nerd Font](https://www.nerdfonts.com/) instalada e configurada no terminal

## Instalação

1. Faça backup da sua configuração atual:
```bash
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
```

2. Clone este repositório:
```bash
git clone <seu-repo-url> ~/.config/nvim
```

3. Inicie o Neovim:
```bash
nvim
```

4. Os plugins serão instalados automaticamente pelo lazy.nvim na primeira execução.

## Estrutura do Projeto

```
~/.config/nvim/
├── init.lua                  # Ponto de entrada
├── lua/v1/
│   ├── setup.lua            # Configuração do lazy.nvim e bootstrap
│   ├── config/
│   │   ├── options.lua      # Opções do Neovim
│   │   ├── keymaps.lua      # Atalhos de teclado
│   │   ├── commands.lua     # Comandos customizados
│   │   ├── lsp.lua          # Configuração LSP
│   │   ├── autocmds/        # Autocommands
│   │   └── helpers/         # Funções auxiliares
│   ├── plugins/             # Configuração dos plugins
│   └── snippets/            # Snippets customizados
├── lsp/                     # Configurações específicas dos LSP servers
└── after/                   # Configurações que carregam por último
```

## Plugins Principais

### Edição e Navegação
- **[flash.nvim](https://github.com/folke/flash.nvim)** - Navegação rápida com labels
- **[nvim-surround](https://github.com/kylechui/nvim-surround)** - Manipulação de surroundings
- **[vim-visual-multi](https://github.com/mg979/vim-visual-multi)** - Múltiplos cursores
- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)** - Auto-fechamento de pares
- **[Comment.nvim](https://github.com/numToStr/Comment.nvim)** - Comentários inteligentes
- **[undotree](https://github.com/mbbill/undotree)** - Visualizador de histórico de undos

### Interface e UI
- **[snacks.nvim](https://github.com/folke/snacks.nvim)** - Componentes UI úteis
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** - Statusline elegante
- **[alpha-nvim](https://github.com/goolord/alpha-nvim)** - Dashboard inicial
- **[which-key.nvim](https://github.com/folke/which-key.nvim)** - Ajuda de keybindings
- **[nvim-notify](https://github.com/rcarriga/nvim-notify)** - Notificações elegantes
- **[dressing.nvim](https://github.com/stevearc/dressing.nvim)** - UI melhorada para inputs
- **[barbecue](https://github.com/utilyre/barbecue.nvim)** - Breadcrumbs VSCode-like
- **[zen-mode.nvim](https://github.com/folke/zen-mode.nvim)** - Modo de foco
- **[twilight.nvim](https://github.com/folke/twilight.nvim)** - Dimming de código

### Busca e Navegação de Arquivos
- **[fzf-lua](https://github.com/ibhagwan/fzf-lua)** - Fuzzy finder
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - Fuzzy finder com preview
- **[neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)** - File explorer
- **[oil.nvim](https://github.com/stevearc/oil.nvim)** - Edição de diretórios como buffer
- **[harpoon](https://github.com/ThePrimeagen/harpoon)** - Marcação rápida de arquivos

### LSP e Autocompletion
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - Configurações LSP
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** - Gerenciador de LSP/DAP/Linters
- **[blink.cmp](https://github.com/saghen/blink.cmp)** - Autocompletion rápido
- **[LuaSnip](https://github.com/L3MON4D3/LuaSnip)** - Engine de snippets
- **[lazydev.nvim](https://github.com/folke/lazydev.nvim)** - Configuração LSP para Lua/Neovim

### Syntax e Treesitter
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Syntax highlighting avançado
- **[nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)** - Auto-fechamento de tags HTML
- **[nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)** - Text objects baseados em treesitter

### Git
- **[lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)** - Integração com Lazygit
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** - Indicadores Git na gutter
- **[vim-fugitive](https://github.com/tpope/vim-fugitive)** - Comandos Git
- **[diffview.nvim](https://github.com/sindrets/diffview.nvim)** - Visualizador de diffs

### Formatação e Linting
- **[conform.nvim](https://github.com/stevearc/conform.nvim)** - Formatação de código

### Testing
- **[neotest](https://github.com/nvim-neotest/neotest)** - Framework de testes
- **[neotest-phpunit](https://github.com/olimorris/neotest-phpunit)** - Adapter PHPUnit
- **[neotest-pest](https://github.com/theutz/neotest-pest)** - Adapter Pest

### Database
- **[vim-dadbod](https://github.com/tpope/vim-dadbod)** - Interface de banco de dados
- **[vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui)** - UI para vim-dadbod
- **[nvim-dbee](https://github.com/kndndrj/nvim-dbee)** - Cliente de banco de dados moderno
- **[lazysql.nvim](https://github.com/jasontheiler/lazysql.nvim)** - Gerenciador SQL

### Desenvolvimento Web
- **[emmet-vim](https://github.com/mattn/emmet-vim)** - Expansão Emmet
- **[phptools.nvim](https://github.com/ccaglak/phptools.nvim)** - Ferramentas PHP
- **[laravel.nvim](https://github.com/adalessa/laravel.nvim)** - Ferramentas Laravel
- **[nvim-highlight-colors](https://github.com/brenoprata10/nvim-highlight-colors)** - Preview de cores

### AI e Produtividade
- **[copilot.lua](https://github.com/zbirenbaum/copilot.lua)** - GitHub Copilot
- **[CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim)** - Chat com Copilot

### Markdown e Notas
- **[obsidian.nvim](https://github.com/epwalsh/obsidian.nvim)** - Integração com Obsidian
- **[render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)** - Renderização de markdown
- **[glow.nvim](https://github.com/ellisonleao/glow.nvim)** - Preview de markdown
- **[bullets.vim](https://github.com/dkarter/bullets.vim)** - Formatação de listas

### Utilitários
- **[vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)** - Navegação entre Vim e Tmux
- **[vim-sleuth](https://github.com/tpope/vim-sleuth)** - Detecção automática de indentação
- **[persistence.nvim](https://github.com/folke/persistence.nvim)** - Gerenciamento de sessões
- **[trouble.nvim](https://github.com/folke/trouble.nvim)** - Lista de diagnósticos
- **[todo-comments.nvim](https://github.com/folke/todo-comments.nvim)** - Highlight de comentários TODO
- **[garbage-day.nvim](https://github.com/Zeioth/garbage-day.nvim)** - Gerenciamento de LSP servers inativos
- **[refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim)** - Refatoração de código

### Temas
- **[catppuccin](https://github.com/catppuccin/nvim)** - Tema Catppuccin
- **[vesper.nvim](https://github.com/datsfilipe/vesper.nvim)** - Tema Vesper
- **[ashen.nvim](https://github.com/ficcdaf/ashen.nvim)** - Tema Ashen

### Efeitos Visuais
- **[smear-cursor.nvim](https://github.com/sphamba/smear-cursor.nvim)** - Cursor animado

## LSP Servers Configurados

Os seguintes Language Servers estão configurados em `lsp/`:

- **Lua** - `lua_ls` com configuração específica para Neovim
- **PHP** - `intelephense` com suporte completo
- **JavaScript/TypeScript** - `ts_ls` (tsserver)
- **Vue** - `volar` com suporte TypeScript
- **HTML** - `html-ls`
- **CSS** - `css-ls`
- **TailwindCSS** - com suporte para múltiplas linguagens
- **Zig** - `zls`

## Atalhos Principais

**Leader key**: `,` (vírgula)

### Gerais
- `<C-d>` - Duplicar linha
- `:W` - Salvar com sudo (se necessário)

### Navegação
- `<C-h/j/k/l>` - Navegar entre splits (integrado com Tmux)
- `<leader>e` - Toggle Neo-tree
- `-` - Abrir Oil.nvim (edição de diretório)

### Busca
- `<leader>ff` - Buscar arquivos
- `<leader>fg` - Buscar em conteúdo (grep)
- `<leader>fb` - Buscar buffers
- `<leader>fh` - Buscar histórico

### Git
- `<leader>gg` - Abrir Lazygit
- `<leader>gd` - Git diff
- `<leader>gb` - Git blame

### LSP
- `gd` - Ir para definição
- `gr` - Referências
- `K` - Hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename

### Testing
- `<leader>tt` - Executar teste mais próximo
- `<leader>tf` - Executar testes do arquivo
- `<leader>ts` - Sumário de testes

### Terminal
- `<leader>tf` - Toggle terminal flutuante

### Database
- `<leader>db` - Abrir Dadbod UI

Consulte `lua/v1/config/keymaps.lua` e as configurações dos plugins para todos os atalhos disponíveis.

## Configurações Personalizadas

### Opções do Editor

- **Indentação**: 4 espaços (configurável por projeto via EditorConfig)
- **Line numbers**: Relativos
- **Clipboard**: Sincronizado com sistema operacional
- **Undo**: Persistente entre sessões
- **Scroll offset**: 10 linhas
- **Fold**: Baseado em Treesitter

### Autocommands

- **Auto-save**: Salva automaticamente ao sair do insert mode
- **Auto-format**: Formata ao salvar (configurável por filetype)
- **Highlight on yank**: Destaca texto copiado
- **Trim whitespace**: Remove espaços em branco ao salvar
- **Last position**: Retorna à última posição ao abrir arquivo
- **Don't auto comment**: Não continua comentários em novas linhas

## Customização

Para customizar a configuração:

1. **Opções do editor**: Edite `lua/v1/config/options.lua`
2. **Keymaps**: Edite `lua/v1/config/keymaps.lua`
3. **Plugins**: Adicione/modifique arquivos em `lua/v1/plugins/`
4. **LSP**: Configure servers em `lsp/` ou `lua/v1/config/lsp.lua`

## Comandos Úteis

- `:Lazy` - Gerenciar plugins
- `:Mason` - Gerenciar LSP servers, linters e formatters
- `:checkhealth` - Verificar status da configuração
- `:LspInfo` - Informações sobre LSP servers ativos
- `:ConformInfo` - Informações sobre formatters

## Estrutura de Dados

O projeto utiliza `lazy-lock.json` para garantir versões consistentes dos plugins entre instalações.

## Créditos

Esta configuração foi inspirada por várias configurações da comunidade Neovim e adaptada para desenvolvimento web moderno com foco em PHP e JavaScript/TypeScript.

### Recursos Úteis

- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [LSP Config](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)

## Licença

Este projeto é de uso pessoal, mas sinta-se livre para usar e adaptar conforme necessário.
