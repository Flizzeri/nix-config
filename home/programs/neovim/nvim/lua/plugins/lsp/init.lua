-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │                                 LSP                                      │
-- ╰──────────────────────────────────────────────────────────────────────────╯

return {
  -- ── Core LSP Config (Neovim 0.11+ vim.lsp.config / vim.lsp.enable) ─────────
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Diagnostic configuration
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        virtual_text = {
          spacing = 4,
          prefix = "●",
          source = "if_many",
        },
        float = {
          border = "rounded",
          source = "if_many",
          header = "",
          prefix = function(diagnostic)
            local icons = {
              [vim.diagnostic.severity.ERROR] = " ",
              [vim.diagnostic.severity.WARN] = " ",
              [vim.diagnostic.severity.INFO] = " ",
              [vim.diagnostic.severity.HINT] = " ",
            }
            return icons[diagnostic.severity] or "● "
          end,
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = " ",
          },
        },
      })

      -- LSP handlers with rounded borders
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

      -- Default capabilities (nvim-cmp)
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      -- Helper to register config overrides
      local function lsp(name, opts)
        opts = opts or {}
        opts.capabilities = capabilities
        vim.lsp.config(name, opts)
      end

      -- Lua (for neovim config)
      lsp("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
            completion = { callSnippet = "Replace" },
            telemetry = { enable = false },
            hint = { enable = true },
          },
        },
      })

      -- Nix
      lsp("nil_ls", {
        settings = {
          ["nil"] = {
            formatting = { command = { "nixfmt" } },
          },
        },
      })

      -- Go
      lsp("gopls", {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      })

      -- Python
      lsp("pyright", {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })

      -- TypeScript / JavaScript (ts_ls via typescript-language-server)
      -- Note: these are the closest equivalents to your previous tsserver_* preferences.
      lsp("ts_ls", {
        init_options = {
          hostInfo = "neovim",
          preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
            includeCompletionsForModuleExports = true,
            quotePreference = "auto",
          },
        },
      })

      -- JSON
      lsp("jsonls", {
        settings = {
          json = {
            validate = { enable = true },
          },
        },
      })

      -- YAML
      lsp("yamlls", {
        settings = {
          yaml = {
            keyOrdering = false,
          },
        },
      })

      -- TOML
      lsp("taplo", {})

      -- CSS/SCSS
      lsp("cssls", {})

      -- HTML
      lsp("html", {})

      -- Docker
      lsp("dockerls", {})

      -- Bash
      lsp("bashls", {})

      -- Enable configs (activates on matching filetypes)
      -- Rust is handled by rustaceanvim below, so we do NOT enable rust_analyzer here.
      for _, name in ipairs({
        "lua_ls",
        "nil_ls",
        "gopls",
        "pyright",
        "ts_ls",
        "jsonls",
        "yamlls",
        "taplo",
        "cssls",
        "html",
        "dockerls",
        "bashls",
      }) do
        vim.lsp.enable(name)
      end
    end,
  },

  -- ── Rust ──────────────────────────────────────────────────────────────────
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    init = function()
      vim.g.rustaceanvim = function()
        return {
          server = {
            default_settings = {
              ["rust-analyzer"] = {
                cargo = {
                  allFeatures = true,
                  loadOutDirsFromCheck = true,
                  buildScripts = { enable = true },
                },
                checkOnSave = true,
                check = {
                  command = "clippy",
                  extraArgs = { "--no-deps" },
                },
                procMacro = {
                  enable = true,
                  ignored = {
                    ["async-trait"] = { "async_trait" },
                    ["napi-derive"] = { "napi" },
                    ["async-recursion"] = { "async_recursion" },
                  },
                },
                inlayHints = {
                  bindingModeHints = { enable = false },
                  chainingHints = { enable = true },
                  closingBraceHints = { enable = true, minLines = 25 },
                  closureReturnTypeHints = { enable = "with_block" },
                  lifetimeElisionHints = { enable = "never" },
                  maxLength = 25,
                  parameterHints = { enable = true },
                  reborrowHints = { enable = "never" },
                  renderColons = true,
                  typeHints = {
                    enable = true,
                    hideClosureInitialization = false,
                    hideNamedConstructor = false,
                  },
                },
              },
            },
          },
        }
      end
    end,
  },

  -- ── Signature Help ────────────────────────────────────────────────────────
  {
    "ray-x/lsp_signature.nvim",
    event = "LspAttach",
    opts = {
      bind = true,
      handler_opts = { border = "rounded" },
      floating_window = true,
      floating_window_above_cur_line = true,
      hint_enable = false, -- Virtual text hint
      hint_prefix = " ",
      hi_parameter = "LspSignatureActiveParameter",
      max_height = 12,
      max_width = 80,
      wrap = true,
      close_timeout = 4000,
      fix_pos = false,
      padding = " ",
      transparency = 10,
      shadow_blend = 36,
      shadow_guibg = "Black",
      timer_interval = 200,
      toggle_key = "<M-x>",
      select_signature_key = "<M-n>",
      move_cursor_key = nil,
    },
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
}

