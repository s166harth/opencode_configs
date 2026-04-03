{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    git
    nodejs_22
    curl
    unzip
  ];

  NPM_CONFIG_PREFIX = "$HOME/.npm-global";

  shellHook = ''
    # uv installation
    if ! command -v uv &> /dev/null; then
      curl -LsSf https://astral.sh/uv/install.sh | sh
    fi
    source $HOME/.local/bin/env

    export NPM_CONFIG_PREFIX="$HOME/.npm-global"
    mkdir -p "$NPM_CONFIG_PREFIX"
    export PATH="$NPM_CONFIG_PREFIX/bin:$PATH"

    echo "OpenCode dev shell ready."
  '';
}
