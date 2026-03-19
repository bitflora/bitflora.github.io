# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A personal portfolio site — a single static HTML/CSS/JS file (`index.html`) with no build toolchain. To preview locally, run:

```bash
python -m http.server
# or
npx serve
```

## Architecture

**Single-file design.** All markup, styles, and logic live in `index.html`. There is no bundler, framework, or transpilation step.

### Visual Layers (z-index stack)

1. **Background** — Full-screen `<iframe>` embedding `../taco-tuesday/index.html` (Solar system animation). Per-project color overlays are toggled on top of this via JS.
2. **Glass panels** — Glassmorphism UI elements (`backdrop-filter: blur`) floating above the background:
   - `.panel-pill` (top-center) — live status badge
   - `.panel-identity` (top-left) — about/links
   - `.panel-projects` (right) — scrollable project cards
   - `.info-panel` (center) — project detail pane, revealed on hover

### Interaction Model

- Hovering a project card swaps `.info-panel` content and toggles the background overlay color.
- The info panel is **sticky** — it does not clear on mouse-leave; it only updates on a new hover.
- On page load, Taco Tuesday details auto-display after an 800 ms delay.

### Project Data

All four projects are hardcoded in a `projects` JS object near the top of the `<script>` block, each with: `eyebrow`, `title`, `subtitle`, `desc`, `cta`, `color`, and `bg`.

| Key   | Project                        | Integration          |
|-------|--------------------------------|----------------------|
| `taco`| Solar Taco Tuesday             | `<iframe>` embed     |
| `pat` | Patristics                     | External Vercel link |
| `gal` | Galileo's Two New Sciences     | External Vercel link |
| `sis` | Sisyphus Quest                 | External link        |

## Design Assets

`design/` contains the spec (`design.md`) and 12 mockup variants (`design/mockups/mockup-a-*.html` through `mockup-l-*.html`). The chosen design is `mockup-l-glass.html` (glassmorphism). `design.md` documents which mockup adjustments were applied to `index.html`.
