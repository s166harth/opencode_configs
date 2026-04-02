# MacOS `say` Integration Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the external TTS API and Czech-centric fallback in the existing `voice.js` plugin with a native macOS `say` command integration.

**Architecture:** Update the `VoicePlugin` in `plugin/voice.js` to execute `say` via the OpenCode shell client, including text sanitization and configuration for voice selection.

**Tech Stack:** JavaScript (OpenCode Plugin SDK), MacOS `say` command.

---

### Task 1: Update Configuration and Sanitization

**Files:**
- Modify: `/Users/siddharth/.config/opencode/plugin/voice.js`

- [ ] **Step 1: Update `defaultConfig` and `loadConfig`**
Add `voice` and update defaults for English-centric usage.

- [ ] **Step 2: Implement `sanitizeText` function**
Create a helper to strip Markdown characters before sending text to `say`.

```javascript
function sanitizeText(text) {
    return text
        .replace(/[*_#`~]/g, '') // Remove basic markdown
        .replace(/\[.*?\]\(.*?\)/g, '$1') // Keep link text, remove URL
        .replace(/\n+/g, ' ') // Replace newlines with spaces
        .trim();
}
```

### Task 2: Replace Speech Logic

**Files:**
- Modify: `/Users/siddharth/.config/opencode/plugin/voice.js`

- [ ] **Step 1: Update `speak` function**
Replace the `fetch` and fallback script logic with a direct `say` command.

```javascript
async function speak(text, config, $) {
    const allowed = await canSpeak(config);
    if (!allowed) return true;

    const cleanText = sanitizeText(text);
    if (!cleanText) return true;

    try {
        await $`say -v ${config.voice} "${cleanText}"`;
        return true;
    } catch (error) {
        return false;
    }
}
```

- [ ] **Step 2: Update `VoicePlugin` tool and event handlers**
Update the `speak` tool description and usage to reflect the new logic.

### Task 3: Verification

- [ ] **Step 1: Verify `say` command manually**
Run: `say "Testing the integration"`
Expected: Audible speech.

- [ ] **Step 2: Test the plugin tool (if environment allows)**
Run: `opencode plugin call voice speak --args '{"text": "Hello world"}'`
Expected: Audible speech "Hello world".
