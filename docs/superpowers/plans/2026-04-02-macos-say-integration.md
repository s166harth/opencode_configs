# MacOS `say` & AI Summarization Integration Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Integrate the macOS native `say` command and a background AI summarization step to provide concise audio feedback for OpenCode.

**Architecture:** Update `plugin/voice.js` to execute `say` and use an LLM-based summarization for any response exceeding 250 characters.

**Tech Stack:** JavaScript (OpenCode Plugin SDK), MacOS `say` command, OpenAI-compatible AI API.

---

### Task 1: Update Configuration and Core Logic

**Files:**
- Modify: `/Users/siddharth/.config/opencode/plugin/voice.js`

- [ ] **Step 1: Update `defaultConfig` and `loadConfig`**
Add `voice`, `summaryThreshold`, `aiEndpoint`, and `aiModel`.

- [ ] **Step 2: Implement `summarizeText` helper**
Write a function that calls the LLM gateway with a summarization prompt.

```javascript
async function summarizeText(text, config) {
    const prompt = `Summarize this technical AI response into 1-2 natural sentences for voice output. Focus only on the 'what' and 'result'. Keep it extremely brief: "${text}"`;
    // implementation using fetch() to AI endpoint...
}
```

- [ ] **Step 3: Implement `sanitizeText` helper**
Strip markdown and newlines.

### Task 2: Implement Voice Output & Tool

**Files:**
- Modify: `/Users/siddharth/.config/opencode/plugin/voice.js`

- [ ] **Step 1: Refactor `speak` function**
Integrate `summarizeText` and the direct `say` command.

```javascript
async function speak(text, config, $) {
    const allowed = await canSpeak(config);
    if (!allowed) return true;

    let textToSpeak = sanitizeText(text);
    if (textToSpeak.length > config.summaryThreshold) {
        textToSpeak = await summarizeText(textToSpeak, config);
    }

    try {
        await $`say -v ${config.voice} "${textToSpeak}"`;
        return true;
    } catch (error) {
        return false;
    }
}
```

- [ ] **Step 2: Update `speak` tool and `event` handler**
Ensure the tool description is updated and `session.idle` event uses the new flow.

### Task 3: Verification

- [ ] **Step 1: Verify short text speech**
Run: `opencode plugin call voice speak --args '{"text": "Short test"}'`
Expected: Audible speech "Short test".

- [ ] **Step 2: Verify long text summarization**
Run: `opencode plugin call voice speak --args '{"text": "Extremely long technical explanation...[200+ words]"}'`
Expected: Audible speech of a 1-2 sentence summary.
