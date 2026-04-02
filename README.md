# OpenCode Setup

This repository contains my OpenCode configuration, skills, and custom agents.

## What's Included

- **oh-my-opencode.json** - Agent and category model configurations
- **opencode.json** - OpenCode plugin and MCP server configuration
- **skills/superpowers/** - Symlink to superpowers skills (separate repo)
- **backups/** - Backup of patched oh-my-openagent CLI file
- **superpowers/agents/helios.md** - Custom helios research agent
- **plugins/** - Local plugin configurations

## Quick Setup on New Machine

1. **Install OpenCode** (if not already installed):
   ```bash
   npm install -g opencode-ai
   ```

2. **Clone this repo to ~/.config/opencode**:
   ```bash
   git clone <this-repo> ~/.config/opencode
   ```

3. **Create symlink for custom agent**:
   ```bash
   mkdir -p ~/.claude/agents
   ln -s ~/.config/opencode/superpowers/agents/helios.md ~/.claude/agents/helios.md
   ```

4. **Install dependencies** (if needed):
   ```bash
   cd ~/.config/opencode
   npm install
   ```

5. **Restart OpenCode**

## Node Modules Patching Note

The `backups/cli-index-patched.js` contains a patched version of oh-my-openagent that adds `helios` to the agent ordering. If you need to reapply:

1. Reinstall oh-my-openagent: `npm update oh-my-openagent`
2. Restore patch: Copy `backups/cli-index-patched.js` to:
   ```
   ~/.nvm/versions/node/<your-node-version>/lib/node_modules/oh-my-openagent/dist/cli/index.js
   ```
3. Restart OpenCode

## Custom Agents

Custom agents are defined in `superpowers/agents/` as markdown files with frontmatter.