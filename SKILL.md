---
name: template-driven-slides-creator
description: Create template-driven presentation decks from a user-provided PPT/PPTX template and reference materials by coordinating the required Presentations and html-ppt skills. Use when the user wants a first-pass deck derived from a template plus source/reference content, then an HTML slide experience refined with one of html-ppt's 36 themes, template-preserving visual polish, fullscreen/keyboard/carousel behavior, animation, QA screenshots, and mandatory user confirmation about whether PPTX output is needed.
---

# Template-Driven Slides Creator

## Overview

Create a polished presentation from a user's existing PowerPoint template plus reference/source content. The workflow is template-first, then skill-coordinated:

1. Use `presentations:Presentations` to create an initial rule-following deck/story from the supplied template and reference materials.
2. Use `html-ppt` to turn the result into a refined HTML slide experience, ask the user to choose from the 36 html-ppt themes, and apply template-preserving visual polish, animation, carousel navigation, keyboard controls, fullscreen behavior, and export readiness.
3. Ask the user through conversation whether a PPTX file is needed. If requested, export or rebuild according to the chosen route and verify the result.

This is an orchestration skill. It does not bundle or copy the full contents of `html-ppt` or `presentations:Presentations`. Both skills are required dependencies.

## Required Dependency Gate

At the start of every task, check whether both required skills are installed and available:

- `presentations:Presentations`: required for the initial template/reference-based deck creation and native PPTX-aware workflows.
- `html-ppt`: required for the final HTML slide system, theme selection, layouts, CSS animations, canvas FX, runtime navigation, presenter/fullscreen behavior, and HTML rendering conventions.

If either required skill is missing, stop before creating the deck and ask the user whether to install the missing skill(s). Explain that:

- Without `Presentations`, the initial template-grounded PPTX-aware creation pass is not available.
- Without `html-ppt`, the required 36-theme selection, animation system, canvas FX, carousel/runtime features, and HTML slide conventions are not available.

Do not continue with a degraded workflow unless the user explicitly changes the requirements.

## Required User Questions

Always ask these questions through conversation before building the final deck:

1. Confirm both required skills are available; if not, ask whether to install the missing skill(s).
2. Ask whether the user needs a PPTX file in addition to the HTML output.
3. Ask the user to choose one `html-ppt` theme from this list:

`minimal-white`, `editorial-serif`, `soft-pastel`, `sharp-mono`, `arctic-cool`, `sunset-warm`, `catppuccin-latte`, `catppuccin-mocha`, `dracula`, `tokyo-night`, `nord`, `solarized-light`, `gruvbox-dark`, `rose-pine`, `neo-brutalism`, `glassmorphism`, `bauhaus`, `swiss-grid`, `terminal-green`, `xiaohongshu-white`, `rainbow-gradient`, `aurora`, `blueprint`, `memphis-pop`, `cyberpunk-neon`, `y2k-chrome`, `retro-tv`, `japanese-minimal`, `vaporwave`, `midcentury`, `corporate-clean`, `academic-paper`, `news-broadcast`, `pitch-deck-vc`, `magazine-bold`, `engineering-whiteprint`.

Recommend 2-3 themes based on the template and audience, but let the user choose. The selected theme is a refinement layer; it must not erase the supplied PPT template's brand identity.

## Workflow

Follow the full workflow in [references/workflow.md](references/workflow.md):

1. Gate on required skills: `presentations:Presentations` and `html-ppt`.
2. Ask whether PPTX output is needed.
3. Inspect the supplied PPT/PPTX template and reference materials.
4. Use `Presentations` to create the first-pass template-following result from the template plus references.
5. Ask the user to choose one of the 36 `html-ppt` themes.
6. Use `html-ppt` to refine the final HTML deck while preserving the original template style.
7. Implement required runtime behavior: fullscreen button, carousel/slide navigation, keyboard controls, animation, and export-friendly query modes.
8. Verify normal, fullscreen, and export layouts with screenshots; fix text overlap, hidden content, broken scaling, footer/logo collisions, and off-screen elements.
9. If PPTX is requested, create and verify the PPTX output.

## Design Rules

Use [references/design-rules.md](references/design-rules.md) for the visual standard. Key requirements:

- Treat the user's PPT template as the design foundation.
- Preserve logos, colors, geometric motifs, icon language, headers, footers, confidentiality labels, and page chrome.
- Use the selected `html-ppt` theme to enhance rhythm, typography, animation, and polish without replacing the template's identity.
- Keep every slide readable and balanced.
- Fullscreen must scale the complete 16:9 slide canvas to the viewport.
- Text must never overlap, hide under template shapes, collide with logos/footers, or disappear after fullscreen/export.
- Navigation and controls must not cover slide content.
- Animations and canvas FX must support comprehension and stay behind content.

## PPTX Output

PPTX is not assumed. The agent must ask the user whether PPTX is needed.

When PPTX is requested, choose the route based on the user's need:

- Use `Presentations` for native editable PPTX when editability is required.
- Use the HTML-to-4K-PNG image route when visual fidelity to the final HTML is more important than editability.

For the image-based route:

1. Finalize and verify HTML first.
2. Render each slide at 3840 x 2160 with `?full=1&export=1&slide=N`.
3. Insert each PNG full-bleed into a blank 16:9 PowerPoint slide.
4. Add simple native transitions such as fade.
5. Verify media dimensions and contact-sheet clarity.

Use `scripts/render-html-slides.ps1` and `scripts/build-picture-pptx.ps1` as starting automation.

## Tool Coordination

- Read and use the installed `Presentations` skill before the initial deck creation pass.
- Read and use the installed `html-ppt` skill before theme selection, HTML authoring, animation, canvas FX, runtime, and export behavior.
- Do not copy or recreate the full `html-ppt` or `Presentations` instructions inside this skill.
- Use browser or Playwright-style screenshots to verify layout, especially fullscreen and export behavior.
- Use PowerPoint COM on Windows when creating or checking image-based PPTX locally.

## Safety

Respect repository cleanup rules. Do not bulk-delete files or directories. If temporary render images or build artifacts accumulate and the project forbids bulk deletion, leave them in place or ask the user to remove them manually.
