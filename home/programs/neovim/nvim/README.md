# Neovim Configuration — Obsidian Theme

A polished, cohesive Neovim configuration with a pitch-black background, refined accents, rounded borders, and segmented statusline styling.

## Design Philosophy

- **Pitch Black Background** — Pure `#000000` base with subtle elevation for UI elements
- **Consistent Borders** — Rounded corners throughout (popups, floats, Telescope, etc.)
- **Segmented Statusline** — Lualine with outlined/filled segments using powerline-style separators
- **Muted, Cohesive Palette** — Tokyo Night-inspired colors that don't compete for attention
- **Minimal Visual Noise** — No unnecessary decorations, every element earns its place

## Structure

```
nvim/
├── init.lua                    # Entry point, lazy.nvim bootstrap
├── colors/
│   └── obsidian.lua            # Colorscheme loader
└── lua/
    ├── core/
    │   ├── options.lua         # Editor options
    │   ├── keymaps.lua         # Global keybindings
    │   ├── autocmds.lua        # Autocommands
    │   └── colorscheme.lua     # Obsidian theme definition
    └── plugins/
        ├── lsp.lua             # nvim-lspconfig, rustaceanvim, typescript-tools
        ├── completion.lua      # nvim-cmp, LuaSnip, lsp_signature
        ├── format.lua          # conform.nvim, nvim-lint
        ├── ui.lua              # dressing, noice, lualine
        ├── telescope.lua       # Telescope + fzf-native
        ├── git.lua             # gitsigns
        ├── treesitter.lua      # Treesitter + textobjects + context
        └── editor.lua          # which-key, autopairs, comment, surround, etc.
```

## Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Copy this config
cp -r nvim-config ~/.config/nvim

# Launch neovim (plugins will auto-install)
nvim
```

## Key Features

### LSP
- **Rust** via rustaceanvim (full rust-analyzer integration)
- **TypeScript/JavaScript** via typescript-tools.nvim
- **Go, Python, Lua, Nix, YAML, JSON, TOML, Bash, CSS, HTML, Tailwind** via nvim-lspconfig

LSPs are expected to come from direnv/nix shells — no Mason.

### Completion
- Ghost text preview
- Bordered, transparent completion menu
- Smart Tab/S-Tab for navigation and snippet expansion
- lsp_signature.nvim for floating signature help

### Formatting & Linting
- Format-on-save via conform.nvim (toggle with `:FormatToggle`)
- Async linting via nvim-lint

### UI
- **noice.nvim** — Cmdline popup, better messages, LSP progress
- **lualine** — Segmented sections with mode-based colors
- **dressing.nvim** — Better vim.ui.select and vim.ui.input

### Keybindings

Leader is `<Space>`. Key groups:

| Prefix | Category |
|--------|----------|
| `<leader>f` | Find/Files |
| `<leader>s` | Search |
| `<leader>c` | Code actions |
| `<leader>g` | Git |
| `<leader>b` | Buffers |
| `<leader>u` | UI toggles |
| `<leader>x` | Diagnostics/Quickfix |

Press `<leader>?` to see buffer-local keymaps via which-key.

### LSP Keybindings

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<C-s>` | Signature help |
| `<leader>ca` | Code action |
| `<leader>cr` | Rename symbol |
| `<leader>cf` | Format document |

### Rust-specific (`<leader>c`)

| Key | Action |
|-----|--------|
| `<leader>cR` | Runnables |
| `<leader>cD` | Debuggables |
| `<leader>cT` | Testables |
| `<leader>ce` | Explain error |
| `<leader>cm` | Expand macro |
| `<leader>cC` | Open Cargo.toml |

### TypeScript-specific (`<leader>c`)

| Key | Action |
|-----|--------|
| `<leader>co` | Organize imports |
| `<leader>cu` | Remove unused |
| `<leader>cM` | Add missing imports |
| `<leader>cR` | Rename file |

## Color Palette (Obsidian)

| Name | Hex | Usage |
|------|-----|-------|
| bg | `#000000` | Background |
| fg | `#c8c8d0` | Primary text |
| blue | `#7aa2f7` | Keywords, functions |
| cyan | `#7dcfff` | Types |
| teal | `#73daca` | Strings |
| green | `#9ece6a` | Success, added |
| yellow | `#e0af68` | Warnings |
| orange | `#ff9e64` | Numbers, parameters |
| red | `#f7768e` | Errors |
| magenta | `#bb9af7` | Operators, special |
| purple | `#9d7cd8` | Preprocessor |

## Font

Designed for **JetBrainsMono Nerd Font**. Set this in your terminal emulator:

```toml
# Alacritty example
[font]
normal = { family = "JetBrainsMono Nerd Font", style = "Regular" }
size = 13.0
```

## Dependencies

These should be available in your environment (via nix/direnv or system):

- `fd` — File finder
- `rg` (ripgrep) — Grep
- `git` — Version control
- Language servers as needed (rust-analyzer, typescript-language-server, etc.)
- Formatters as needed (stylua, prettier, rustfmt, etc.)
- Linters as needed (eslint_d, shellcheck, etc.)

## Customization

### Adding Language Servers

Edit `lua/plugins/lsp.lua` and add to the bottom:

```lua
lspconfig.YOUR_SERVER.setup(vim.tbl_extend("force", default_config, {
  settings = {
    -- server-specific settings
  },
}))
```

### Changing Theme Colors

Edit `lua/core/colorscheme.lua` — the `M.colors` table at the top defines everything.

### Toggle Features

- `:FormatToggle` — Toggle format-on-save
- `<leader>uh` — Toggle inlay hints
- `<leader>ut` — Toggle treesitter context
- `<leader>uw` — Toggle word wrap
