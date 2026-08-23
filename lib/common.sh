#!/usr/bin/env bash
# Helpers compartilhados pelos installers/*.sh

has_cmd() { command -v "$1" >/dev/null 2>&1; }

brew_formula_installed() { brew list --formula "$1" >/dev/null 2>&1; }

brew_cask_installed() { brew list --cask "$1" >/dev/null 2>&1; }

brew_install_formula() { brew install "$1"; }

brew_install_cask() { brew install --cask "$1"; }
