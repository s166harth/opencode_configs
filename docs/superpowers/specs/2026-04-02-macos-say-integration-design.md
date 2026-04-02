# Design Spec: MacOS `say` Command & Summarization Integration

## 1. Goal
Integrate the macOS native `say` command and an automated AI summarization layer for OpenCode TTS. This ensures audio feedback is both high-quality and concise, preventing long text blocks from being read out.

## 2. Approach
Modify the existing `plugin/voice.js` to:
1. Utilize the `say` system command for local speech.
2. Include an AI-driven summarization step for messages exceeding a length threshold.

## 3. Architecture
### Input Handling
-   **Manual Speak Tool**: An exported `speak({ text })` tool.
-   **Event-Driven**: Listener for `session.idle` for announcements.

### Summarization Agent (Plugin-side)
-   **Threshold**: Messages > 250 characters.
-   **Prompt**: "Summarize this technical AI response into 1-2 natural sentences for voice output. Keep it extremely brief."
-   **Engine**: External AI endpoint (configured via environment/default config).

### Processing Logic
-   **Sanitization**: Strip Markdown symbols and newlines before processing.
-   **Summarize-First**: Call AI summarizer if threshold is met.
-   **Speech Delivery**: Call `say -v [Voice] "[Text]"`.

## 4. Configuration
Add to `loadConfig()`:
-   `voice`: Default "Alex".
-   `summaryThreshold`: Default 250 characters.
-   `aiEndpoint`: URL for the LLM gateway.
-   `aiModel`: Model name for summarization.

## 5. Success Criteria
-   Short messages are read out completely.
-   Long messages (e.g., code explanations) are summarized into 1-2 voice-friendly sentences.
-   Audio is clear, local, and free (via `say`).
