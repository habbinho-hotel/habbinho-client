#!/usr/bin/env bash
set -e

if ! command -v npx >/dev/null && [[ -s "${NVM_DIR:-$HOME/.nvm}/nvm.sh" ]]; then
    source "${NVM_DIR:-$HOME/.nvm}/nvm.sh" --no-use
    nvm use --silent "$(cat Octane/.nvmrc)" >&2
fi

if ! command -v npx >/dev/null; then
    printf '%s\n' 'Instale Node 22.12+ com npm para executar o Playwright MCP.' >&2
    exit 1
fi

if [[ $# -eq 0 ]]; then
    set -- --browser chromium --headless --isolated --caps=vision,devtools
fi

exec npx --yes --prefer-offline @playwright/mcp@0.0.86 "$@"
