# nvim-config

Neovim config where everything is a buffer: file explorer, compile output,
diagnostics, terminal, search-and-replace. No Nerd Font required.

## Install

```bash
git clone git@github.com:dmihovch/nvim-config.git ~/.config/nvim
cd ~/.config/nvim
chmod +x install.sh
./install.sh
```

Open Neovim. lazy.nvim installs all plugins on first run.

## Dependencies

install.sh handles these on Debian/Ubuntu:

| Tool | Used by |
|---|---|
| git | plugin cloning |
| make, gcc | telescope-fzf-native, LuaSnip jsregexp |
| ripgrep | telescope live grep, grug-far |
| fd | telescope file finding |
| unzip | Mason LSP extraction |
| python3 | Pyright LSP |
| nodejs | TypeScript/JavaScript LSP |
| golang-go | gopls LSP |

## Keybindings

Leader key: `<Space>`

### Files and buffers

| Key | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fp` | Find files (git only) |
| `<leader>f.` | Recent files |
| `<leader>fb` | Switch buffer |
| `<leader>bd` | Delete buffer |
| `<leader>bD` | Delete buffer (force) |
| `<leader>bn` | Next buffer |
| `<leader>bp` | Previous buffer |
| `<leader>bq` | Close all buffers but this |
| `<leader>e` | File explorer (oil.nvim) |

### Search

| Key | Action |
|---|---|
| `<leader>fg` | Live grep |
| `<leader>fw` | Grep word under cursor |
| `<leader>fh` | Help tags |
| `<leader>fk` | Keymaps |
| `<leader>fc` | Commands |
| `<leader>sr` | Search and replace (grug-far) |

### Diagnostics

| Key | Action |
|---|---|
| `<leader>xx` | Toggle diagnostics buffer |
| `<leader>xw` | Document diagnostics |
| `<leader>xq` | Quickfix list |
| `<leader>xl` | Location list |
| `<leader>q` | Diagnostic quickfix (built-in) |

### Terminal

| Key | Action |
|---|---|
| `<leader>tt` | Terminal (floating) |
| `<leader>tT` | Terminal (horizontal split) |
| `<leader>tv` | Terminal (vertical split) |

### Compile

| Key | Action |
|---|---|
| `<leader>cc` | Compile |
| `<leader>cr` | Recompile |
| `<leader>cq` | Close compile window |

### Windows

| Key | Action |
|---|---|
| `<leader>wv` | Vertical split |
| `<leader>wh` | Horizontal split |
| `<leader>wc` | Close window |
| `<leader>wo` | Close other windows |
| `Ctrl+h/j/k/l` | Move between windows |
| `Ctrl+arrows` | Resize windows |

### Session

| Key | Action |
|---|---|
| `<leader>ss` | Save session |
| `<leader>sl` | Restore session |
| `<leader>sd` | Delete session |
| `<leader>s.` | Search sessions |

### Directory

| Key | Action |
|---|---|
| `<leader>cd` | Cd to current file directory |
| `<leader>cD` | Cd to git project root |

### Toggle

| Key | Action |
|---|---|
| `<leader>th` | Toggle inlay hints |
| `<leader>u` | Undo tree |

### LSP (when server is attached)

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

## File structure

```
~/.config/nvim/
  init.lua                  Entry point
  install.sh                Bootstrap script
  README.md
  .gitignore
  lua/
    options.lua             Editor settings
    keymaps.lua             Global keybindings
    autocmds.lua            Autocommands
    local.lua.example       Machine overrides (copy to local.lua)
    plugins/
      init.lua              Plugin index
      colorscheme.lua       Colorscheme
      completion.lua        blink.cmp + LuaSnip
      editing.lua           Oil, gitsigns, mini.pairs, compile-mode
      lsp.lua               LSP servers, Mason, diagnostics
      search-replace.lua    grug-far
      session.lua           auto-session
      telescope.lua         Fuzzy finder
      terminal.lua          toggleterm
      treesitter.lua        Syntax highlighting
      trouble.lua           Diagnostics buffer
      ui.lua                which-key, lualine
      undotree.lua          Undo tree
```

## Plugins

| Plugin | Purpose |
|---|---|
| onedarkpro.nvim | Colorscheme |
| oil.nvim | File explorer as editable buffer |
| telescope.nvim | Fuzzy finder |
| blink.cmp | Autocompletion |
| LuaSnip | Snippets |
| nvim-lspconfig + Mason | LSP server management |
| nvim-treesitter | Syntax highlighting and indentation |
| gitsigns.nvim | Git gutter signs |
| mini.pairs | Auto-close brackets and quotes |
| guess-indent.nvim | Auto-detect indentation |
| compile-mode.nvim | Compile runner |
| toggleterm.nvim | Terminal buffers |
| trouble.nvim | Diagnostics list |
| grug-far.nvim | Find and replace |
| auto-session | Session persistence |
| undotree | Undo history visualization |
| which-key.nvim | Keybinding hints |
| lualine.nvim | Statusline |
| fidget.nvim | LSP progress |
| lazydev.nvim | Lua LSP for Neovim config |

## How to change the colorscheme

1. Open `lua/plugins/colorscheme.lua`.
2. Replace the repo URL and colorscheme command.
3. Restart Neovim.

Example switching to catppuccin:

```lua
return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme('catppuccin-mocha')
        end,
    },
}
```

## How to add an LSP server

1. Open `lua/plugins/lsp.lua`.
2. Add the server to the `servers` table:

```lua
local servers = {
    clangd = {},
    gopls = {},
    pyright = {},
    rust_analyzer = {},  -- add this
    ts_ls = {},
}
```

3. Restart Neovim. Mason installs the server.

## How to remove an LSP server

1. Delete its entry from the `servers` table in `lua/plugins/lsp.lua`.
2. Run `:MasonUninstall <server-name>` to remove the binary.

## How to add a plugin

1. Create `lua/plugins/<name>.lua`:

```lua
return {
    {
        'author/plugin-name.nvim',
        event = 'VeryLazy',
        opts = { setting = true },
        keys = {
            { '<leader>xx', '<cmd>MyCommand<CR>', desc = 'Do the thing' },
        },
    },
}
```

2. Import it in `lua/plugins/init.lua`:

```lua
{ import = 'plugins.<name>' },
```

## Machine-specific settings

Copy `lua/local.lua.example` to `lua/local.lua` (gitignored). Add overrides:

```lua
vim.o.guifont = "monospace:h12"
vim.g.python3_host_prog = "/usr/bin/python3"
```

## How to add a Treesitter language

1. Open `lua/plugins/treesitter.lua`.
2. Add the language to `ensure_installed`.
3. Restart Neovim.