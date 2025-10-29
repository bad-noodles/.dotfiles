# CRUSH.md - Dotfiles Repository Guide

## Build/Lint/Test Commands
- **Lua formatting**: `stylua --check .config/nvim .hammerspoon` (check), `stylua .config/nvim .hammerspoon` (format)
- **Reload Zsh**: `source ~/.zshrc` or `reload` (custom function)
- **Reload Hammerspoon**: `:ReloadConfiguration` in Hammerspoon console or `hs.reload()`
- **Reload Neovim**: `:Lazy reload <plugin>` or restart Neovim
- **No test suite**: This is a personal dotfiles repository

## Code Style Guidelines

### Lua (Neovim, Hammerspoon, WezTerm)
- **Indentation**: 2 spaces (enforced by `.config/nvim/stylua.toml`)
- **Line width**: 120 characters max
- **Imports**: Use `require()` for modules, prefer relative paths for local files (`require("./Custom/module")`)
- **Globals**: `hs` (Hammerspoon), `spoon` (Hammerspoon spoons), `vim` (Neovim), `wezterm` (WezTerm)
- **Functions**: Use `local function name()` for local scope, descriptive snake_case names
- **Tables**: snake_case keys, explicit key-value pairs (`{ key = value }`)
- **Comments**: Minimal, use `--` for single line, only for complex logic

### Configuration Patterns
- **Neovim**: Follow LazyVim conventions, use `vim.opt` for options, `vim.g.autoformat = false` by default
- **Neovim plugins**: Return table with plugin spec, use `opts` function for extending configs
- **Hammerspoon**: Load spoons with `hs.loadSpoon()`, use `spoon.SpoonInstall:andUse()` pattern
- **Hammerspoon custom**: Use `require("./Custom/module")` for custom modules
- **WezTerm**: Use `wezterm.config_builder()`, organize by feature sections (Colors, Font, Tabs, Keys)
- **Zsh**: Modular config in `.config/zsh/config/*.zsh`, use zgenom for plugin management
- **Zsh functions**: Define in config files, use `function name() { ... }` syntax

### File Organization
- **Neovim**: Plugins in `.config/nvim/lua/plugins/`, config in `.config/nvim/lua/config/`
- **Hammerspoon**: Custom modules in `.hammerspoon/Custom/`, spoons in `.hammerspoon/Spoons/`
- **Zsh**: Config modules in `.config/zsh/config/`, plugins managed in `.config/zsh/plugins.zsh`
- **WezTerm**: Single config file at `.config/wezterm/wezterm.lua`
