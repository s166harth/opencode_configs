# NixOS Setup for OpenCode Configuration

Follow these steps on your NixOS machine to get everything working:

## Quick Start

```bash
# Clone this repo
git clone https://github.com/YOUR_REPO_URL ~/.config/opencode
cd ~/.config/opencode

# Enter dev shell (installs nodejs, uv, etc.)
nix develop

# OR with shell.nix (legacy):
nix-shell shell.nix

# Install OpenCode CLI
npm install -g opencode-ai

# Fix hardcoded macOS paths → NixOS paths
sed -i "s|/Users/siddharth/.nvm/versions/node/v22.14.0|$HOME/.npm-global|g" opencode.json

# Install npm dependencies
npm install

# Run OpenCode
opencode
```

That's it. The `nix develop` command handles all prerequisites via the included `flake.nix`.

## What the Flake Provides

The included `flake.nix` sets up:
- **nodejs_22** - JavaScript runtime
- **git** - Version control
- **curl** - HTTP client
- **uv** - Python package manager (for scholar-mcp)
- **NPM_CONFIG_PREFIX** - So global npm installs work without root

## System Integration (Optional)

To integrate permanently with your NixOS/ home-manager, add this repo as a flake input:

```nix
# In your flake.nix inputs:
inputs.opencode-config.url = "github:YOUR_GITHUB_USERNAME/YOUR_REPO";

# In home-manager:
home.packages = with pkgs; [ nodejs_22 git curl ];
programs.bash.initExtra = ''
  export PATH="$HOME/.npm-global/bin:$PATH"
  export NPM_CONFIG_PREFIX="$HOME/.npm-global"
'';
```

## Troubleshooting

### opencode: command not found

```bash
export PATH="$HOME/.npm-global/bin:$PATH"
```

### MCP servers failing

Ensure `uv` is installed (handled automatically by `nix develop`):
```bash
which uv
```

### Voice plugin errors

The `./plugin/voice` uses macOS `say`. Remove it from `opencode.json` plugins array:

```json
"plugin": [
  "opentmux",
  "opencode-google-antigravity-auth",
  "oh-my-openagent@latest",
  "opencode-agent-tmux"
  // remove: "./plugin/voice"
]
```

## Verification

```bash
opencode --version
opencode "hello"
```
