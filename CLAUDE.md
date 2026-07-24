# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

This is not a software project — it's the working folder for a single keynote presentation: **"Beyond Dashboards: Deploying AI Agents in Real Business Operations,"** delivered by Mina George at AI Connect 2026. There is no build system, package manager, linter, or test suite. There is nothing to "run" other than opening the HTML file in a browser.

## Files

- `ai_connect_2026_reveal_professional.html` — the entire slide deck. A single self-contained HTML file built on [reveal.js](https://revealjs.com) v5.1.0, loaded via CDN (`cdn.jsdelivr.net`). Open it directly in a browser (double-click, or `start ai_connect_2026_reveal_professional.html` on Windows) to present or preview — no server or build step required.
- `STORY_INTRODUCTION_WITH_PROMPTS - Updated .md` — background/history doc for the "Alex" narrative and the original AI image-generation prompts. **The HTML's per-slide speaker notes are the source of truth for delivery, not this doc** — the opening is now a silent cinematic sequence (see below), not a narrated story, so don't try to read this document's prose aloud.
- `Alex_AI_Agent_Cinematic_Sequence.mp4` — 30s cinematic cold-open video, full-bleed, muted, no controls, fades in from black.
- `ChatGPT Image 1.jpg` – `ChatGPT Image 7.jpg` — all seven generated illustrations, JPEG-recompressed from the original PNG masters for load performance. All seven are used, in numeric order, as the seven full-bleed cinematic beats that follow the cold-open video (see below). None are archived or held back.
- `yt-thumb-ECR4oAwocjs.jpg` — locally-cached YouTube thumbnail, used on the "optional deeper dive" reference card so that slide has zero live network dependency.
- `_archive/rejected/`, `_archive/source-masters/` — now contain only lossless PNG masters of the seven images (all of which are back in active use as JPEGs in the root). Nothing "rejected" remains excluded from the deck.
- `_backup_2026-07-24_pre-phase1/` — full snapshot of every file as it stood before the multi-phase rebuild began. Reference only; not part of the live deck.

## The opening: a silent cinematic sequence

The first ~2-3 minutes of the deck are not slides to present — they're a silent film that plays largely on its own before the presenter starts talking:

1. **Cold open** (`#coldopen`) — the MP4 plays full-bleed, no borders, no native controls, fading in from black via a CSS opacity transition (`video.show`). It auto-plays muted; if the browser blocks autoplay, a centered glass `.cine-play` button appears (shown only on autoplay failure) for the presenter to tap. On `ended`, it auto-advances to Image 1.
2. **Seven full-bleed image beats**, one per section (`.cine`, alternating with `.cine.alt` for a varied Ken Burns pan direction), each showing exactly one image at near-full-screen with a large, minimal caption (`.cine-eyebrow` + `.cine-headline`, max ~10-15 words) over a bottom gradient scrim (`.cine-scrim`) for legibility. Each auto-advances via `data-autoslide` (~9-10s) — a slow, one-directional Ken Burns zoom (`kenburnsA`/`kenburnsB` keyframes, scoped to `.present` so it only plays on the active slide) drives the motion. The story beat per image (in order): office wakes up → dashboards everywhere → alerts/emails/notifications → stress/confusion/no answers → still searching → the AI agent appears → transformation/one decision/confidence.
3. **Chrome is hidden throughout**: a `cinematic-mode` class is toggled onto `.reveal` (via the `slidechanged`/`ready` handlers) whenever the current slide is the cold-open or a `.cine` slide, which hides reveal.js's own controls/progress bar/slide-number for a clean, chrome-free film look. It returns automatically once the title slide is reached.
4. **Fade to title**: Image 7 carries `data-transition="fade" data-transition-speed="slow"`, so the outgoing transition into the (unmodified) title slide is a slow cross-fade — reveal.js resolves transition/speed from the *outgoing* slide, so this doesn't require touching the title slide's own `data-transition="zoom"` at all. From the title slide onward, the deck is back to fully presenter-paced, exactly as it always was.
5. `@media (prefers-reduced-motion: reduce)` disables the Ken Burns pans, orb float, heatmap pulse, caret blink, and video fade for users/systems that request it — captions appear instantly instead of animating in.

Every cinematic slide still has an `<aside class="notes">` — they mostly say "stay silent," plus one optional whispered line and a reminder that pressing → is always a safety-net manual skip (autoslide is presenter-interruptible by design).

## Working on the rest of the slide deck

- One `<style>` block defines the visual system as CSS custom properties (`--bg`, `--ink`, `--cyan`, `--violet`, `--green`, `--amber`, `--rose`, etc.) and reusable component classes (`.card`, `.flat`, `.pill`, `.pipeline`/`.step`, `.timeline`/`.node`, `.flow`/`.flowbox`, `.compare`, `.grid2/3/4`, `.agent-demo`, `.watch-later`, `.fallback-overlay`). Reuse these for new slides rather than introducing one-off styles.
- 29 `<section>` elements total: cold-open + 7 cinematic image beats + title + opening quote + the rest of the original content deck (dashboard paradox through thank-you), unchanged from the original design. Most non-cinematic sections use `.bg-grid` (background grid/orb decoration) and a `.full` wrapper for vertical centering. Reveal.js fragment classes (`fragment fade-up`, `fade-left`, `fade-right`, `zoom-in`) drive progressive reveal there — DOM order is reveal order.
- Press `S` during presentation to open reveal.js's speaker view (opens a popup window — allow popups for this file if the browser prompts).
- **One live third-party iframe remains**: the transformer-attention explainer (`poloclub.github.io/transformer-explainer`). It has a built-in offline fallback (`#transformerFallback`): a static local explanation auto-appears if the iframe hasn't fired `load` within 5s or the browser reports `navigator.onLine === false`; a "Show offline version / Try live version" pill lets the presenter toggle manually at any time. The former YouTube iframe slide was replaced with a static "optional deeper dive" reference card (local thumbnail + link) after discovering the embedded video was actually the *same* creators' full transformer explainer — redundant with the interactive tool on the previous slide — so that slide now has zero network dependency.
- A small inline `<script>` block also builds the 81-cell `.heatmap` grid and runs a typewriter effect (with a genuinely blinking `.caret`) over the `demoLines` array (the fake agent conversation on the "live-style demo" slide).
- reveal.js's CDN bundle (`reveal.css`/`reveal.js` v5.1.0) includes print-pdf support natively — append `?print-pdf` to the file URL and use the browser's print dialog to export a PDF handout; no extra stylesheet include needed.

When editing content, slide copy and structure live entirely in the HTML `<section>` markup — there's no templating layer or data file driving it.
