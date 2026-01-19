return {
  "saghen/blink.cmp",
  -- use a release tag to download pre-built binaries
  version = "*",
  build = "cargo +nightly build --release",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    snippets = { preset = "luasnip" },
    fuzzy = {
      implementation = "prefer_rust_with_warning",
    },
    keymap = {
      preset = "default",
      ["<C-k>"] = { "select_and_accept" },
      ["<C-l>"] = { "select_and_accept" },
      ["<C-y>"] = {}, -- desabilita o atalho antigo
      -- Map C-Z in conjunction with C-Y for completion, as we are on a QWRTZ
      -- keyboard.
      -- ["<C-Z>"] = { "accept", "fallback" },
      ["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    completion = {
      menu = {
        border = "rounded",
      },
      ghost_text = {
        enabled = false,
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        -- update_delay_ms = 0,

        window = {
          border = "rounded",
          desired_min_width = 30,
          -- direction_priority = {
          --   menu_north = { "s", "n", "e", "w" },
          --   menu_south = { "n", "s", "e", "w" },
          -- },
        },
      },
    },

    signature = {
      enabled = true,
      window = {
        border = "rounded",
      },
    },

    sources = {
      default = { "ecolog", "lsp", "snippets", "buffer", "path" },
      per_filetype = {
        blade = { "blade-nav", "ecolog", "lsp", "snippets", "buffer", "path" },
        php = { "blade-nav", "ecolog", "lsp", "snippets", "buffer", "path" },
      },
      providers = {
        ecolog = {
          name = "ecolog",
          module = "ecolog.integrations.cmp.blink_cmp",
        },
        path = {
          name = "Path",
          module = "blink.cmp.sources.path",
          score_offset = 3,
        },
        ["blade-nav"] = {
          name = "blade-nav",
          module = "blade-nav.blink",
          score_offset = 10,
          opts = {
            close_tag_on_complete = false, -- desativa pois você usa autopairs
          },
        },
      },
    },
  },

  config = function(_, opts)
    local U = require("v1.util")
    U.newColorWithBase("CmpGhostText", "NonText")
    require("blink.cmp").setup(opts)
  end,
}
