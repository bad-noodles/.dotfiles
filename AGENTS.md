# Agent Instructions for .dotfiles Repository

## Repository Overview
Personal dotfiles repository containing Lua configurations for Neovim, Hammerspoon, WezTerm, and Zsh shell setup.

## Build/Test/Lint Commands
- **Lua formatting**: `stylua --check .` (lint), `stylua .` (format)
- **No test suite**: This is a dotfiles repository without automated tests
- **Reload configs**: `source ~/.zshrc` (zsh), `:ReloadConfiguration` in Hammerspoon

## Code Style Guidelines

### Lua Code Style
- **Indentation**: 2 spaces (enforced by stylua.toml)
- **Line width**: 120 characters maximum
- **Imports**: Use `require()` for modules, prefer relative paths for local files (`require("./Custom/module")`)
- **Global variables**: `hs` (Hammerspoon), `spoon` (Hammerspoon spoons), `vim` (Neovim)
- **Comments**: Use `--` for single line, minimal comments unless complex logic
- **Functions**: Use `local function name()` for local functions, clear descriptive names
- **Tables**: Use snake_case for keys, prefer explicit key-value pairs

### Configuration Patterns  
- **Neovim**: Follow LazyVim conventions, use `vim.opt` for options, disable autoformat by default
- **Hammerspoon**: Use spoon.SpoonInstall pattern, group hotkeys logically
- **WezTerm**: Use `wezterm.config_builder()`, organize by feature sections
- **Zsh**: Source modular files from `.config/zsh/`, use zgenom for plugin management