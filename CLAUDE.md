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

### Layout: an open book

The site is styled as a 17th-century book, opened to a two-page spread (based on `design/mockups/mockup-q-frontispiece.html`).

- **Left page** — title page ("The Collected Works of Tim Jasko … In Four Books"), a table of contents built from the `books` data, and the imprint holding the GitHub / LinkedIn / email links.
- **Right page** (`#chapter`) — the selected project, rendered as a chapter: running head, drop cap, marginalia, a plate image, and a ☞ call-to-action link.
- **`.leaf`** — the page-turn animation. On a chapter change the outgoing page is copied onto the leaf, which rotates over while the new chapter renders underneath. Skipped under `prefers-reduced-motion` and on narrow screens, where the spread collapses to one column.

### Interaction Model

- Each chapter has a `slug`; the TOC links are `#slug` hashes, and `hashchange` drives page turns, so chapters are linkable and survive reload. ←/→ keys step through chapters.
- Page numbers are computed (`PAGES_PER_CHAPTER`), not hardcoded.
- The Taco Tuesday chapter uses `live:` instead of `img:` — a scaled-down `<iframe>` of `taco-tuesday/index.html`. On load, the page injects CSS into the (same-origin) iframe to hide its `#control-panel`.

### Project Data

All projects live in the `books` array in the `<script>` block. Each book has `n`, `title`, `gloss`, and `chapters`; each chapter has `slug`, `t` (chapter title), `short` (TOC label), `sub`, `p` (body), `m` (marginal notes), `hand` (handwritten note), `cta` (`[label, href]`), and either `img` or `live`.

| Book | Title                  | Chapters                              |
|------|------------------------|---------------------------------------|
| I    | Of Old Books           | Patristics, Galileo, Euclid           |
| II   | Of the Heavens         | Kepler, Solar Taco Tuesday            |
| III  | Of Blocks              | Zoogoer, AsteriskCraft (Minecraft)    |
| IV   | Of Divers Curiosities  | Piet, Sim Tick, Sisyphus Quest        |

## Design Assets

`design/` contains the spec (`design.md`) and mockup variants in `design/mockups/`. `mockup-a` through `mockup-l` are the original layout explorations (the previous site was based on `mockup-l-glass.html`); `mockup-m` through `mockup-t` explore organizing projects into categories. The current site is based on `mockup-q-frontispiece.html`.
