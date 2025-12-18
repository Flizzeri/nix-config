-- ╭──────────────────────────────────────────────────────────╮
-- │                    LSP CONFIG                            │
-- ╰──────────────────────────────────────────────────────────╯

return {
  -- ── nvim-lspconfig ──────────────────────────────────────────
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      local lspconfig = require("lspconfig")
      
      -- ── Diagnostic Configuration ────────────────────────────
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        virtual_text = {
          prefix = "",
          spacing = 2,
          source = "if_many",
          format = function(diagnostic)
            local icons = {
              [vim.diagnostic.severity.ERROR] = " ",
              [vim.diagnostic.severity.WARN] = " ",
              [vim.diagnostic.severity.INFO] = " ",
              [vim.diagnostic.severity.HINT] = " ",
            }
            return string.format("%s %s", icons[diagnostic.severity], diagnostic.message)
          end,
        },
        float = {
          border = "rounded",
          source = "if_many",
          header = "",
          prefix = function(diagnostic)
            local icons = {
              [vim.diagnostic.severity.ERROR] = "  ",
              [vim.diagnostic.severity.WARN] = "  ",
              [vim.diagnostic.severity.INFO] = "  ",
              [vim.diagnostic.severity.HINT] = "  ",
            }
            return icons[diagnostic.severity], "Diagnostic" .. vim.diagnostic.severity[diagnostic.severity]
          end,
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
        },
      })
      
      -- ── LSP Handlers (borders, etc.) ────────────────────────
      local border = "rounded"
      
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = border,
          max_width = 80,
          max_height = 20,
        }
      )
      
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
          border = border,
          max_width = 80,
          max_height = 20,
        }
      )
      
      -- ── Capabilities ────────────────────────────────────────
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )
      
      -- Enable folding capabilities
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      
      -- ── On Attach ───────────────────────────────────────────
      local on_attach = function(client, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        
        -- Navigation
        map("n", "gd", function() require("telescope.builtin").lsp_definitions() end, "Go to definition")
        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "gr", function() require("telescope.builtin").lsp_references() end, "Go to references")
        map("n", "gi", function() require("telescope.builtin").lsp_implementations() end, "Go to implementation")
        map("n", "gy", function() require("telescope.builtin").lsp_type_definitions() end, "Go to type definition")
        
        -- Hover & Signature
        map("n", "K", vim.lsp.buf.hover, "Hover documentation")
        map({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, "Signature help")
        
        -- Actions
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("v", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")
        map("n", "<leader>cl", vim.lsp.codelens.run, "Run codelens")
        
        -- Search
        map("n", "<leader>ss", function() require("telescope.builtin").lsp_document_symbols() end, "Document symbols")
        map("n", "<leader>sS", function() require("telescope.builtin").lsp_workspace_symbols() end, "Workspace symbols")
        
        -- Inlay hints toggle
        if client.supports_method("textDocument/inlayHint") then
          map("n", "<leader>uh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
          end, "Toggle inlay hints")
        end
        
        -- Format on demand
        if client.supports_method("textDocument/formatting") then
          map("n", "<leader>cf", function()
            vim.lsp.buf.format({ async = true })
          end, "Format document")
        end
        
        -- Codelens
        if client.supports_method("textDocument/codeLens") then
          vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            buffer = bufnr,
            callback = vim.lsp.codelens.refresh,
          })
        end
      end
      
      -- ── Default Server Config ───────────────────────────────
      local default_config = {
        capabilities = capabilities,
        on_attach = on_attach,
      }
      
      -- Store for use by other plugins
      vim.g.lsp_capabilities = capabilities
      vim.g.lsp_on_attach = on_attach
      
      -- ── Lua ─────────────────────────────────────────────────
      lspconfig.lua_ls.setup(vim.tbl_extend("force", default_config, {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            completion = { callSnippet = "Replace" },
            telemetry = { enable = false },
            hint = { enable = true },
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      }))
      
      -- ── Go ──────────────────────────────────────────────────
      lspconfig.gopls.setup(vim.tbl_extend("force", default_config, {
        settings = {
          gopls = {
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              fieldalignment = true,
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
            semanticTokens = true,
          },
        },
      }))
      
      -- ── Python ──────────────────────────────────────────────
      lspconfig.pyright.setup(vim.tbl_extend("force", default_config, {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
              typeCheckingMode = "basic",
            },
          },
        },
      }))
      
      -- ── Nix ─────────────────────────────────────────────────
      lspconfig.nil_ls.setup(vim.tbl_extend("force", default_config, {
        settings = {
          ["nil"] = {
            formatting = {
              command = { "nixfmt" },
            },
          },
        },
      }))
      
      -- ── JSON ────────────────────────────────────────────────
      lspconfig.jsonls.setup(vim.tbl_extend("force", default_config, {
        settings = {
          json = {
            validate = { enable = true },
          },
        },
      }))
      
      -- ── YAML ────────────────────────────────────────────────
      lspconfig.yamlls.setup(vim.tbl_extend("force", default_config, {
        settings = {
          yaml = {
            keyOrdering = false,
          },
        },
      }))
      
      -- ── TOML ────────────────────────────────────────────────
      lspconfig.taplo.setup(default_config)
      
      -- ── Bash ────────────────────────────────────────────────
      lspconfig.bashls.setup(default_config)
      
      -- ── CSS ─────────────────────────────────────────────────
      lspconfig.cssls.setup(default_config)
      
      -- ── HTML ────────────────────────────────────────────────
      lspconfig.html.setup(default_config)
      
      -- ── Tailwind ────────────────────────────────────────────
      lspconfig.tailwindcss.setup(default_config)
    end,
  },
  
  -- ── Rustaceanvim ────────────────────────────────────────────
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    lazy = false,
    config = function()
      vim.g.rustaceanvim = {
        tools = {
          float_win_config = {
            border = "rounded",
          },
        },
        server = {
          on_attach = function(client, bufnr)
            -- Call global on_attach if available
            if vim.g.lsp_on_attach then
              vim.g.lsp_on_attach(client, bufnr)
            end
            
            -- Rust-specific keymaps
            local map = function(mode, lhs, rhs, desc)
              vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
            end
            
            map("n", "<leader>cR", function()
              vim.cmd.RustLsp("runnables")
            end, "Rust runnables")
            map("n", "<leader>cD", function()
              vim.cmd.RustLsp("debuggables")
            end, "Rust debuggables")
            map("n", "<leader>cT", function()
              vim.cmd.RustLsp("testables")
            end, "Rust testables")
            map("n", "<leader>ce", function()
              vim.cmd.RustLsp("explainError")
            end, "Explain error")
            map("n", "<leader>cE", function()
              vim.cmd.RustLsp("renderDiagnostic")
            end, "Render diagnostic")
            map("n", "<leader>cm", function()
              vim.cmd.RustLsp("expandMacro")
            end, "Expand macro")
            map("n", "<leader>cp", function()
              vim.cmd.RustLsp("parentModule")
            end, "Parent module")
            map("n", "<leader>cC", function()
              vim.cmd.RustLsp("openCargo")
            end, "Open Cargo.toml")
            map("n", "J", function()
              vim.cmd.RustLsp("joinLines")
            end, "Join lines")
          end,
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
                closureReturnTypeHints = { enable = "never" },
                lifetimeElisionHints = { enable = "never", useParameterNames = false },
                maxLength = 25,
                parameterHints = { enable = false },
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
    end,
  },
  
  -- ── TypeScript Tools ────────────────────────────────────────
  {
    "pmizio/typescript-tools.nvim",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("typescript-tools").setup({
        on_attach = function(client, bufnr)
          -- Call global on_attach if available
          if vim.g.lsp_on_attach then
            vim.g.lsp_on_attach(client, bufnr)
          end
          
          -- TypeScript-specific keymaps
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end
          
          map("n", "<leader>co", "<cmd>TSToolsOrganizeImports<CR>", "Organize imports")
          map("n", "<leader>cO", "<cmd>TSToolsSortImports<CR>", "Sort imports")
          map("n", "<leader>cu", "<cmd>TSToolsRemoveUnused<CR>", "Remove unused")
          map("n", "<leader>cz", "<cmd>TSToolsGoToSourceDefinition<CR>", "Go to source definition")
          map("n", "<leader>cR", "<cmd>TSToolsRenameFile<CR>", "Rename file")
          map("n", "<leader>cF", "<cmd>TSToolsFileReferences<CR>", "File references")
          map("n", "<leader>cM", "<cmd>TSToolsAddMissingImports<CR>", "Add missing imports")
        end,
        settings = {
          separate_diagnostic_server = true,
          publish_diagnostic_on = "insert_leave",
          expose_as_code_action = "all",
          tsserver_path = nil,
          tsserver_plugins = {},
          tsserver_max_memory = "auto",
          tsserver_format_options = {},
          tsserver_file_preferences = {
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
          tsserver_locale = "en",
          complete_function_calls = false,
          include_completions_with_insert_text = true,
          code_lens = "off",
          disable_member_code_lens = true,
          jsx_close_tag = {
            enable = true,
            filetypes = { "javascriptreact", "typescriptreact" },
          },
        },
      })
    end,
  },
}
