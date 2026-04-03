{
  description = "OpenCode Configuration with Custom Agents and Skills";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          # Build inputs
          buildInputs = with pkgs; [
            git
            nodejs_22
            curl
            unzip
            (python3.withPackages (p: [ p.pip ]))
          ];

          # npm/pip setup
          NPM_CONFIG_PREFIX = "$HOME/.npm-global";
          PIP_PREFIX = "$HOME/.pip";

          # Shell rc file to source
          shellHook = ''
            # uv installation (if not present)
            if ! command -v uv &> /dev/null; then
              curl -LsSf https://astral.sh/uv/install.sh | sh
            fi
            source $HOME/.local/bin/env

            # npm global prefix
            export NPM_CONFIG_PREFIX="$HOME/.npm-global"
            mkdir -p "$NPM_CONFIG_PREFIX"
            export PATH="$NPM_CONFIG_PREFIX/bin:$PATH"

            # OpenCode config path
            export OPENCODE_CONFIG_DIR="$HOME/.config/opencode"

            echo "OpenCode dev shell ready. Run 'opencode' to start."
          '';
        };
      }
    );
}
