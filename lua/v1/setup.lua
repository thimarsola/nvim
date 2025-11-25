-- Map the leader key as it is needed by lazy
vim.g.mapleader = ","

-- Disable backup files BEFORE loading plugins to prevent E13 error
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Loading additional configs
require("v1.config.options")
require("v1.lazy")
require("v1.config.commands")
require("v1.config.keymaps")
require("v1.config.lsp")
require("v1.snippets")
require("v1.config.autocmds")
