# OpenCode Voice Setup

This guide explains how to use voice input and output with OpenCode.

## Quick Start

Run these commands in two separate terminals:

```bash
# Terminal 1 - OpenCode Server
tmux new -s omo-dev -d "opencode --port 4096"
tmux attach -t omo-dev

# Terminal 2 - Voice Input  
tmux new -s omo-voice -d "opencode-voice --port 4096"
tmux attach -t omo-voice
```

## Usage

- **Hold Space** in the voice session to record, **release** to send
- Press **q** to quit
- TTS (text-to-speech) works automatically via the voice plugin

## What Was Installed

| Component | Description |
|-----------|-------------|
| `opencode-voice` | Rust binary for voice input (whisper.cpp) |
| `opencode-voice-plugin` | TTS output plugin at `~/.opencode/plugin/voice.js` |

## Commands

```bash
# Start both sessions
tmux new -s omo-dev -d "opencode --port 4096" && tmux new -s omo-voice -d "opencode-voice --port 4096"

# List sessions
tmux ls

# Attach to sessions
tmux attach -t omo-dev  # OpenCode
tmux attach -t omo-voice  # Voice input

# Kill sessions
tmux kill-session -t omo-dev
tmux kill-session -t omo-voice

# Check audio devices
opencode-voice devices

# Re-download Whisper model
opencode-voice setup
```

## Troubleshooting

- **No audio input**: Check microphone permissions in System Settings
- **Global hotkey not working**: Grant Accessibility permission in System Settings → Privacy & Security → Accessibility, or use `--no-global` flag
- **Can't connect**: Make sure OpenCode is running first on port 4096
