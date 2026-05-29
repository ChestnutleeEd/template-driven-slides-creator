---
name: template-driven-ppt-designer
description: Create polished business presentations from a user-provided PPT/PPTX template and source material. Use when the user wants an HTML deck that preserves the template's visual language, logo, colors, icons, geometry, and footer/header elements, with optional high-resolution image-based PPTX export and iterative optimization using third-party presentation skills such as html-ppt and Presentations.
---

# Template-Driven PPT Designer

## Overview

Create a presentation from a user's existing PowerPoint template plus source content, preserving the template style while improving structure, layout, animation, and visual polish. The required primary deliverable is an interactive HTML deck; PPTX is optional and should default to a high-resolution image-based export from the final HTML.

This skill is an orchestration skill. It does not bundle the full contents of `html-ppt` or `presentations:Presentations`. Use those skills when they are installed and available:

- Use `html-ppt` for HTML deck templates, themes, slide layouts, CSS animations, canvas FX, keyboard runtime, presenter mode, and PNG-oriented HTML rendering patterns.
- Use `presentations:Presentations` for native editable PPTX workflows based on artifact-tool presentation JSX.
- If either skill is unavailable, continue with this skill's workflow and scripts, but do not claim that unavailable templates, animations, canvas FX, or native editable PPTX helpers are present.

## Start Here

First ask or confirm the output choice:

```text
HTML is always generated. Do you also want a PPTX version?
- HTML only
- HTML + PPTX
```

If the user already specified the format, proceed without asking again. Ask for missing template/content files only when they cannot be discovered from the workspace.

## Workflow

Follow the full workflow in [references/workflow.md](references/workflow.md):

1. Inspect the PPT template visually and structurally before designing.
2. Extract and synthesize the source content into an English slide narrative unless the user asks for another language.
3. Build the HTML deck with the `html-ppt` skill as the design engine when available.
4. Preserve all important template elements, especially logos, colors, geometric motifs, footer/header bars, icon style, and confidentiality labels.
5. Add carousel navigation, keyboard controls, fullscreen mode, slide animations, and subtle canvas FX.
6. Verify normal and fullscreen layouts with screenshots.
7. If PPTX is requested, render the final HTML slides as 4K PNGs and build a 16:9 PPTX where each slide is a full-slide image, with native PowerPoint transitions.

## Design Rules

Use [references/design-rules.md](references/design-rules.md) for the visual standard. Key requirements:

- Preserve the original template's identity; do not remove template/SAP elements unless explicitly requested.
- Use a business-clean, executive-report style: simple, confident, spacious, but not sparse.
- Keep every slide balanced; avoid layouts where one half is empty unless the emptiness is intentional and visually anchored.
- Make fullscreen responsive by scaling the entire 16:9 slide canvas to the viewport, not by stretching individual slide content.
- Keep animation subtle: content transitions support comprehension, canvas FX stays behind content and never obscures text.
- For PPTX clarity, use high-resolution image export from HTML, not low-resolution screenshots.

## Optional PPTX Export

For PPTX, prefer the image-based route:

1. Finalize and verify HTML first.
2. Render each slide at 3840 x 2160 with `?full=1&export=1&slide=N`.
3. Insert each PNG full-bleed into a blank 16:9 PowerPoint slide.
4. Add simple native transitions such as fade.
5. Verify media dimensions and contact-sheet clarity.

Use `scripts/render-html-slides.ps1` and `scripts/build-picture-pptx.ps1` as starting automation. This PPTX route is high fidelity and presentation-ready, but not text-editable. If the user specifically needs editable PPTX, explain that it requires a separate native reconstruction pass and will be less pixel-identical than the HTML.

## Tool Coordination

- Use `html-ppt` for HTML layout systems, corporate-clean style, template-inspired slide patterns, carousel behavior, CSS slide animations, canvas FX, presenter mode, and HTML-to-PNG export conventions. Read the installed `html-ppt` skill before relying on its available themes, animations, or templates.
- Use `presentations:Presentations` when a native editable PPTX or PowerPoint artifact workflow is needed. Read the installed Presentations skill before using artifact-tool presentation JSX.
- Do not copy or recreate the full `html-ppt` or `Presentations` instructions inside this skill. Treat them as external dependencies so their upstream behavior can stay current.
- Use browser or Playwright-style screenshots to verify layout, especially fullscreen behavior.
- Use PowerPoint COM on Windows when creating or checking the image-based PPTX locally.

## Safety

Respect repository cleanup rules. Do not bulk-delete files or directories. If temporary render images or build artifacts accumulate and the project forbids bulk deletion, leave them in place or ask the user to remove them manually.
