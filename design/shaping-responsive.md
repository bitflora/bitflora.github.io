---
shaping: true
---

# Responsive Layout — Shaping

## Requirements (R)

| ID | Requirement | Status |
|----|-------------|--------|
| R0 | Site renders usably at all screen sizes from ~375px (phone) to 4K | Core goal |
| R1 | At ≥1024px, preserves the current glassmorphism side-by-side design | Must-have |
| R2 | At ≥1024px, panels never overlap each other or clip horizontally | Must-have |
| R3 | At ≥1024px, projects panel never clips its content vertically | Must-have |
| R4 | At <1024px, identity + projects glass panels stack vertically in a scrollable layout | Must-have |
| R5 | At <1024px, tapping a project card navigates directly to the project URL | Must-have |
| R6 | Iframe background (solar system) stays visible at all sizes | Must-have |
| R7 | Status pill is hidden at <1024px | Must-have |

---

## A: Fluid desktop (clamp-based) + mobile reflow

| Part | Mechanism |
|------|-----------|
| A1 | Panel widths use `clamp(240px, 25vw, 360px)` — scales from 240px at 960px viewport to 360px at 1440px+ |
| A2 | Panel positions (`left`, `right`, `top`) switch to viewport-relative values at desktop breakpoint |
| A3 | Info panel width formula updated from `min(680px, calc(100vw - 440px))` to `min(680px, calc(50vw - 56px))` so it tracks the panel widths |
| A4 | Mobile (<1024px): `body` switches from `overflow:hidden` to `overflow-y:auto`; panels switch from `position:fixed` to `position:static`; panels stack in a centered column with `margin:auto` |
| A5 | Mobile: pill (`panel-pill`) hidden via `display:none` |
| A6 | Mobile: project cards use `<a href>` directly to project URL — no JS detail view |
| A7 | Desktop hover/info-panel JS stays active only above the breakpoint (JS reads `window.innerWidth`) |

---

## B: Two desktop configs + mobile reflow

| Part | Mechanism |
|------|-----------|
| B1 | ≥1440px: current layout, zero changes |
| B2 | 1024–1439px: hardcoded smaller panel widths (280px), adjusted fixed positions |
| B3 | Info panel width formula hardcoded per breakpoint |
| B4 | Mobile (<1024px): same as A4–A7 |

---

## Fit Check

| Req | Requirement | Status | A | B |
|-----|-------------|--------|---|---|
| R0 | Site renders usably at all screen sizes from ~375px to 4K | Core goal | ✅ | ✅ |
| R1 | At ≥1024px, preserves glassmorphism side-by-side design | Must-have | ✅ | ✅ |
| R2 | At ≥1024px, panels never overlap each other or clip horizontally | Must-have | ✅ | ✅ |
| R3 | At ≥1024px, projects panel never clips content vertically | Must-have | ✅ | ✅ |
| R4 | At <1024px, panels stack vertically in a scrollable layout | Must-have | ✅ | ✅ |
| R5 | At <1024px, project cards navigate directly to URL | Must-have | ✅ | ✅ |
| R6 | Iframe background visible at all sizes | Must-have | ✅ | ✅ |
| R7 | Status pill hidden at <1024px | Must-have | ✅ | ✅ |

**Notes:**
- B requires maintaining two sets of hardcoded panel dimensions — more breakpoints to update if the design changes
- A scales continuously with no extra maintenance burden; the `clamp()` approach is one set of values

**Selected shape: A**

---

## Detail A: Mobile Layout Sketch

```
Desktop (≥1024px)
┌──────────────────────────────────────────────────────┐
│ [Identity 25vw]    [● Pill]    [Projects 25vw]       │
│                    [info panel]                       │
└──────────────────────────────────────────────────────┘

Mobile (<1024px) — scrollable
┌─────────────────────────┐
│ ┌─────────────────────┐ │
│ │ Jim Tasko           │ │  ← identity panel
│ │ bio / links         │ │
│ └─────────────────────┘ │
│ ┌─────────────────────┐ │
│ │ PROJECTS            │ │  ← projects panel
│ │ Taco Tuesday      > │ │
│ │ Patristics        > │ │
│ │ Galileo           > │ │
│ │ Sisyphus          > │ │
│ └─────────────────────┘ │
└─────────────────────────┘
```

### Mobile CSS changes
- `html, body`: remove `overflow: hidden`, add `overflow-y: auto`
- `.panel-identity`, `.panel-projects`: `position: static`, `width: calc(100% - 32px)`, `margin: 16px auto`
- `.panel-projects`: remove `top`/`bottom`/`right`; `height: auto`, remove `overflow: hidden` + `flex-column` constraints
- `.proj-card`: `flex: none`, `min-height: auto`, restore natural height
- `.panel-pill`: `display: none`
- `.info-panel`: `display: none`
- `.bg-taco`: stays as `position: fixed; inset: 0` (still works as a fixed bg on scrollable page)

### Desktop fluid changes
- `.panel-identity` width: `clamp(240px, 25vw, 360px)`
- `.panel-projects` width: `clamp(240px, 25vw, 360px)`
- `.info-panel` width: `min(680px, calc(50vw - 56px))`

### JS changes
- Wrap the hover/info-panel logic in a check: `if (window.innerWidth >= 1024)`
- Or use a `matchMedia` listener to enable/disable the hover handlers
