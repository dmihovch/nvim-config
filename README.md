# 🐻 Dan's Neovim Config

A **portable, Emacs-inspired** Neovim configuration built around the philosophy that
**everything is a buffer**. File management, compilation, search, diagnostics, git,
terminals — all live in buffers you navigate with the same vim keybindings.

## Design Principles

- **Everything is a buffer.** File explorer? Buffer. Compile output? Buffer.
  Diagnostics? Buffer. Terminal? Buffer. Search-and-replace? Buffer. No hidden UI panels.
- **Zero Nerd Font dependency.** All icons are plain text. Works on any terminal.
- **Portable.** One `install.sh` script bootstraps the entire config on a fresh machine.
- **Lazy-loaded.** Plugins load only when needed. Startup is fast.
- **Documented.** Every file explains what it does and how to change it.

---

## Quick Start

```bash
git clone https://github.com/your-username/nvim-config.git ~/.config/nvim
cd ~/.config/nvim
chmod +x install.sh
./install.sh
```

Then open Neovim — lazy.nvim will install all plugins automatically.

---

## Dependencies

The install script handles these, but here's what you need:

| Tool | Purpose |
|---|---|
| `git` | Clone plugins |
| `make` + `gcc`/`clang` | Build telescope-fzf-native, LuaSnip jsregexp |
| `ripgrep` (`rg`) | Telescope live grep, grug-far search |
| `fd` | Telescope file finding (falls back to `find`) |
| `unzip` | Mason LSP server extraction |
| `node` (optional) | For JS/TS LSP servers |
| `python3` (optional) | For Pyright |
| `go` (optional) | For gopls |

---

## Keybindings

### Leader Key: `<Space>`

#### Files & Buffers

| Key | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fp` | Find files (git only) |
| `<leader>f.` | Recent files |
| `<leader>fb` | Switch buffers |
| `<leader>bd` | Delete buffer |
| `<leader>bD` | Delete buffer (force) |
| `<leader>bn` | Next buffer |
| `<leader>bp` | Previous buffer |
| `<leader>bq` | Close all buffers but this |
| `<leader>e` | File explorer (oil.nvim — dired-style) |

#### Search

| Key | Action |
|---|---|
| `<leader>fg` | Live grep (search file contents) |
| `<leader>fw` | Grep word under cursor |
| `<leader>fh` | Search help tags |
| `<leader>fk` | Search keymaps |
| `<leader>fc` | Search commands |
| `<leader>sr` | Search and replace (grug-far) |

#### Diagnostics

| Key | Action |
|---|---|
| `<leader>xx` | Toggle diagnostics buffer (trouble.nvim) |
| `<leader>xw` | Document diagnostics |
| `<leader>xq` | Quickfix list |
| `<leader>xl` | Location list |
| `<leader>q` | Diagnostic quickfix (built-in) |

#### Terminal

| Key | Action |
|---|---|
| `<leader>tt` | Terminal (floating) |
| `<leader>tT` | Terminal (horizontal split) |
| `<leader>tv` | Terminal (vertical split) |

#### Compile

| Key | Action |
|---|---|
| `<leader>cc` | Compile |
| `<leader>cr` | Recompile |
| `<leader>cq` | Close compile window |

#### Windows

| Key | Action |
|---|---|
| `<leader>wv` | Vertical split |
| `<leader>wh` | Horizontal split |
| `<leader>wc` | Close window |
| `<leader>wo` | Close other windows |
| `Ctrl+h/j/k/l` | Move between windows |
| `Ctrl+arrows` | Resize windows |

#### Session

| Key | Action |
|---|---|
| `<leader>ss` | Save session |
| `<leader>sl` | Restore session |
| `<leader>sd` | Delete session |
| `<leader>s.` | Search sessions |

#### Toggle

| Key | Action |
|---|---|
| `<leader>th` | Toggle inlay hints |
| `<leader>u` | Undo tree |

### LSP (when a language server is attached)

| Key | Action |
|---|---|
| `grd` | Go to definition |
| `grD` | Go to declaration |
| `grt` | Go to type definition |
| `gri` | Find implementations |
| `grr` | Find references |
| `grn` | Rename symbol |
| `gra` | Code action |
| `gO` | Document symbols |
| `gW` | Workspace symbols |
| `K` | Hover documentation |
| `<leader>ca` | Code action |

---

## File Structure

```
~/.config/nvim/
├── init.lua                  # Entry point
├── install.sh                # Bootstrap script
├── README.md                 # This file
├── .gitignore
├── lua/
│   ├── options.lua           # Editor settings (tabs, search, UI)
│   ├── keymaps.lua           # Global keybindings
│   ├── autocmds.lua          # Autocommands (yank highlight, etc.)
│   ├── local.lua.example     # Machine-specific overrides (copy to local.lua)
│   └── plugins/
│       ├── init.lua          # Plugin index (imports all plugin files)
│       ├── colorscheme.lua   # Colorscheme config
│       ├── completion.lua    # blink.cmp + LuaSnip
│       ├── editing.lua       # Oil, gitsigns, mini.pairs, compile-mode
│       ├── lsp.lua           # LSP servers, Mason, diagnostics
│       ├── search-replace.lua # grug-far: interactive find-and-replace
│       ├── session.lua       # auto-session: session persistence
│       ├── telescope.lua     # Fuzzy finder
│       ├── terminal.lua      # toggleterm: terminal buffers
│       ├── treesitter.lua    # Syntax highlighting
│       ├── trouble.lua       # trouble.nvim: diagnostics buffer
│       ├── ui.lua            # which-key, lualine
│       └── undotree.lua      # Undo tree visualization
```

---

## Plugin Inventory

### Core (always loaded)
| Plugin | Purpose | Emacs Equivalent |
|---|---|---|
| onedarkpro.nvim | Colorscheme | `custom-theme` |
| oil.nvim | File explorer as editable buffer | `dired` |
| auto-session | Session persistence | `desktop.el` |

### Lazy-loaded on demand
| Plugin | Purpose | Emacs Equivalent |
|---|---|---|
| telescope.nvim | Fuzzy finder (files, grep, buffers, help) | `find-file` / `counsel` |
| blink.cmp | Autocompletion | `company-mode` / `corfu` |
| LuaSnip | Snippet engine | `yasnippet` |
| nvim-lspconfig + Mason | LSP server management | `eglot` / `lsp-mode` |
| nvim-treesitter | Syntax highlighting & indentation | `tree-sitter` |
| gitsigns.nvim | Git gutter signs | `git-gutter` |
| mini.pairs | Auto-close brackets/quotes | `electric-pair-mode` |
| guess-indent.nvim | Auto-detect indentation | `dtrt-indent` |
| compile-mode.nvim | Run build commands in a buffer | `M-x compile` |
| toggleterm.nvim | Terminal buffers | `eshell` / `ansi-term` |
| trouble.nvim | Diagnostics list in a buffer | `compilation-mode` errors |
| grug-far.nvim | Interactive find-and-replace | `wgrep` / `project-query-replace` |
| undotree | Visual undo history | `undo-tree` |
| which-key.nvim | Keybinding hints popup | `which-key` |
| lualine.nvim | Statusline | `mode-line` |
| fidget.nvim | LSP progress spinner | — |
| lazydev.nvim | Lua LSP for Neovim config | — |

---

## How-To Guides

### Change the Colorscheme

1. Open `lua/plugins/colorscheme.lua`
2. Replace the plugin repo and colorscheme command:

```lua
-- Example: switch to catppuccin
return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme 'catppuccin-mocha'
        end,
    },
}
```

3. Restart Neovim. The old colorscheme plugin will be cleaned up automatically.

Popular alternatives (copy-paste ready):
- `'folke/tokyonight.nvim'` → `vim.cmd.colorscheme 'tokyonight'`
- `'EdenEast/nightfox.nvim'` → `vim.cmd.colorscheme 'carbonfox'`
- `'rebelot/kanagawa.nvim'` → `vim.cmd.colorscheme 'kanagawa'`
- `'rose-pine/neovim'` → `vim.cmd.colorscheme 'rose-pine'`

### Add a New LSP Server

1. Open `lua/plugins/lsp.lua`
2. Add the server to the `servers` table (around line 160):

```lua
local servers = {
    clangd = {},
    gopls = {},
    pyright = {},
    rust_analyzer = {},  -- ← add this
    ts_ls = {},
    -- ...
}
```

3. If the server needs special settings:

```lua
rust_analyzer = {
    settings = {
        ['rust-analyzer'] = {
            checkOnSave = { command = 'clippy' },
        },
    },
},
```

4. Restart Neovim. Mason will prompt to install the server.

### Remove an LSP Server

1. Delete its entry from the `servers` table in `lua/plugins/lsp.lua`.
2. Optionally run `:MasonUninstall <server-name>` to remove the binary.

### Add a New Plugin

1. Create a new file in `lua/plugins/` (e.g., `lua/plugins/my-plugin.lua`).
2. Write the plugin spec:

```lua
return {
    {
        'author/plugin-name.nvim',
        event = 'VeryLazy',       -- or a specific event like 'BufRead'
        opts = {                  -- plugin options
            setting = true,
        },
        keys = {                  -- keymaps (auto-registered by lazy.nvim)
            { '<leader>xx', '<cmd>MyCommand<CR>', desc = 'Do the thing' },
        },
    },
}
```

3. Import it in `lua/plugins/init.lua`:

```lua
return {
    { import = 'plugins.colorscheme' },
    -- ...
    { import = 'plugins.my-plugin' },  -- ← add this
}
```

### Machine-Specific Settings

Copy `lua/local.lua.example` to `lua/local.lua` and add overrides:

```lua
-- This file is gitignored. Put machine-specific settings here.
vim.o.guifont = "FiraCode Nerd Font:h14"  -- GUI font (nvim-qt, etc.)
vim.g.python3_host_prog = "/usr/local/bin/python3"
```

The file is already required in `init.lua` — no other changes needed.

### Add a Treesitter Language

1. Open `lua/plugins/treesitter.lua`
2. Add the language to the `ensure_installed` list:

```lua
ensure_installed = {
    -- ...
    'rust',   -- ← add this
    'python', -- ← add this
},
```

3. Restart Neovim. The parser will be installed automatically.

---

## Philosophy: Why This Config Exists

I wanted Neovim to feel more like Emacs in one specific way: **everything lives in a
buffer you can navigate, search, and edit with the same keybindings.** No popups,
no sidebars you can't `Ctrl+w h` into, no modal dialogs. Just buffers.

- **oil.nvim** replaces netrw with a dired-like editable directory buffer.
- **telescope.nvim** replaces file dialogs with a fuzzy-search buffer.
- **compile-mode.nvim** gives you `M-x compile` in Neovim.
- **toggleterm.nvim** gives you persistent terminal buffers like `eshell`/`ansi-term`.
- **trouble.nvim** gives you a structured diagnostics buffer like `compilation-mode` errors.
- **grug-far.nvim** gives you interactive find-and-replace in a buffer like `wgrep`.
- **auto-session** gives you `desktop.el`-style session persistence.
- **undotree** gives you `undo-tree` visualization.

The goal is that you never leave the buffer paradigm.