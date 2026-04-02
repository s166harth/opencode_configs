# Design Spec: MacOS `say` Command Integration for OpenCode

## 1. Goal
Integrate the macOS native `say` command as the primary text-to-speech (TTS) engine for OpenCode, providing both a manual `speak` tool and automatic announcements.

## 2. Approach
Modify the existing `plugin/voice.js` to utilize the `say` system command instead of external HTTP APIs. This minimizes dependencies and leverages the high-quality, local voices already available on macOS.

## 3. Architecture
### Input Handling
-   **Manual Speak Tool**: An exported `speak({ text })` tool available for agents.
-   **Event-Driven**: Listener for `session.idle` to trigger completion announcements.

### Processing Logic
-   **Sanitization**: Strip Markdown (e.g., `*`, `_`, `#`, backticks) and extra whitespace from input text.
-   **Lock Check**: Verify if speech is allowed (already exists in current `voice.js`).
-   **Execution**: Call `say` via the OpenCode shell client (`$`).

### Configuration
Update `loadConfig()` to include:
-   `voice`: Default to "Alex" or current system preference.
-   `announceOnIdle`: Enable by default.
-   `idleMessage`: Update to "Task completed."

## 4. Components
-   **`plugin/voice.js`**: Core logic for the plugin and tool definition.
-   **Configuration Entry**: Ensure the plugin is registered in `~/.config/opencode/opencode.json`.

## 5. Success Criteria
-   Calling `speak({ text: "Hello" })` executes `say "Hello"`.
-   When a session finishes, the system says "Task completed."
-   No external API keys are required for basic speech.
-   Markdown formatting is removed before speech to prevent reading aloud characters like "asterisk".
