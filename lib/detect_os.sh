#!/usr/bin/env bash
# Detecção de SO, arquitetura e path do Homebrew.

os_name() {
  case "$(uname -s)" in
    Darwin) echo "macos" ;;
    Linux) echo "linux" ;;
    *) echo "unknown" ;;
  esac
}

os_arch() {
  case "$(uname -m)" in
    arm64|aarch64) echo "arm64" ;;
    x86_64) echo "x86_64" ;;
    *) echo "unknown" ;;
  esac
}

brew_prefix() {
  if [[ "$(os_arch)" == "arm64" ]]; then
    echo "/opt/homebrew"
  else
    echo "/usr/local"
  fi
}

ensure_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    return 0
  fi

  if [[ "${DRY_RUN:-false}" == "true" ]]; then
    echo "[dry-run] instalaria: Homebrew"
    return 0
  fi

  echo "Homebrew não encontrado — instalando..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$($(brew_prefix)/bin/brew shellenv)"
}

# Execução direta (não sourced): imprime o diagnóstico e sai.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  echo "SO=$(os_name) ARCH=$(os_arch) BREW_PREFIX=$(brew_prefix)"
fi
