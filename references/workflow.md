# Workflow

## 1. Confirm Deliverables

HTML is mandatory. PPTX is optional. At the start, ask the user whether they want:

- HTML only
- HTML + PPTX

If the user already answered, continue. If they ask for PPTX, use the image-based export route unless they explicitly require editable PowerPoint objects.

## 1.5. Check Optional Skill Dependencies

This skill orchestrates other presentation skills but does not bundle their full contents.

Before relying on external capabilities, check whether they are installed and available:

- `html-ppt`: use for HTML deck templates, themes, reusable layouts, CSS animations, canvas FX, keyboard runtime, presenter mode, and HTML rendering conventions. If it is available, read its `SKILL.md` and relevant references such as themes, layouts, animations, or full-deck templates before authoring.
- `presentations:Presentations`: use for native editable PPTX workflows based on artifact-tool presentation JSX. If it is available and the user needs editable PPTX, read its `SKILL.md` and follow its operating contract.

If `html-ppt` is unavailable, continue with a custom static HTML deck and this skill's design rules, but do not claim access to `html-ppt` themes, templates, animations, presenter mode, or canvas FX.

If `presentations:Presentations` is unavailable, use this skill's default route: final HTML first, then optional high-resolution image-based PPTX via PNG frames and PowerPoint COM.

## 2. Gather Inputs

Collect or infer:

- PPT/PPTX template file.
- Source content file(s), such as DOCX, PPTX, PDF, Markdown, screenshots, logs, or notes.
- Audience, language, tone, confidentiality requirements, and target length.
- Any third-party skill the user wants involved, especially `html-ppt` or `presentations:Presentations`.

Default assumptions when not specified:

- Language: English.
- Style: business-clean / corporate executive report.
- Slide ratio: 16:9.
- HTML slide canvas: 1280 x 720 logical pixels.
- PPTX export: 3840 x 2160 PNG per slide.

## 3. Inspect the Template

Before designing, inspect the template like a visual system:

- Render or screenshot several template slides.
- Identify theme colors, typography feel, title bars, footers, logos, icons, motifs, geometric shapes, watermark behavior, and confidentiality labels.
- Extract reusable image assets if needed.
- Record "must preserve" elements. For SAP-style decks, preserve the SAP logo, blue palette, angular blocks, header/footer bars, and internal/customer label.

Do not invent a new brand system. The output should feel like a refined continuation of the supplied template.

## 4. Build the Narrative

Read the source content and convert it into a compact presentation story:

- Define the core claim.
- Identify the timeline, mechanism, evidence, impact/risk, recommendation, and next actions.
- Turn raw technical details into slide-ready headings and short supporting copy.
- Prefer strong executive headlines over generic section labels.

For incident/root-cause decks, a useful sequence is:

1. Cover with root-cause claim and key facts.
2. Executive summary.
3. Incident timeline.
4. Technical mechanism / failure chain.
5. Evidence and parameters.
6. Root cause.
7. Impact and risk.
8. Recommended actions.
9. Closing / decision page.

## 5. Build the HTML Deck

Use `html-ppt` when available. Apply the corporate-clean style and template-inspired layouts:

- Cover slide with strong template geometry.
- Executive summary with KPI cards.
- Timeline slide.
- Failure chain / process-arrow slide.
- Evidence grid / parameter strip.
- Two-column risk or comparison slide.
- Recommendation cards.
- Closing slide with action emphasis.

Required HTML behavior:

- Carousel-style slide navigation with previous/next buttons, dots, counter, and keyboard support.
- Keyboard: ArrowLeft/ArrowRight, PageUp/PageDown, Home/End, Space, and F for fullscreen when practical.
- Fullscreen button.
- Query support for QA/export: `?slide=N`, `?full=1`, and `?export=1`.
- Export mode hides navigation and fixes the viewport for clean screenshots.

## 6. Responsive Fullscreen

Use one fixed logical slide size, normally 1280 x 720. The responsive layer should scale the complete slide canvas to fit the viewport.

Recommended model:

- `.deck-shell` owns the viewport.
- `.slide-stage` stays 1280 x 720.
- JavaScript computes `scale = min(window.innerWidth / 1280, window.innerHeight / 720)`.
- Apply scale to the whole slide stage using `zoom` or `transform`.
- In normal mode, cap scale at 1 so the preview remains centered.
- In fullscreen mode, allow scale above 1 so content fills the screen without leaving large blank lower areas.

Do not let individual text blocks or cards reflow independently in fullscreen; that causes top-heavy slides and broken geometry.

## 7. Animation and Canvas FX

Use subtle presentation animation:

- Slide transition: fade/slide, 350-650 ms.
- Content reveal: fade-up, fade-left/right, zoom-pop, staggered cards.
- Process/timeline: line draw or staged node reveal.
- KPI cards: small upward motion or count-style emphasis if appropriate.

Canvas FX should be low opacity and behind content:

- Constellation / network dots for technical root-cause analysis.
- Data stream or flowing lines for systems/process themes.
- Chain reaction or pulse effect for failure propagation.
- Orbit rings or soft particles for cover/closing slides.

Disable or simplify FX in export mode if they cause inconsistent screenshots.

## 8. Fill Empty Areas Intelligently

If a slide feels half-empty, add relevant structure rather than decoration:

- Evidence cards.
- Parameter strips.
- Risk notes.
- "What it means" callouts.
- Control/action metadata.
- Source/confidence markers.
- Small diagrams or process chips.

Keep density executive-friendly: more complete than a sparse mockup, less crowded than raw notes.

## 9. Verify HTML

Use screenshots before final delivery:

- 1280 x 720 baseline view.
- Normal browser-centered preview.
- Fullscreen-sized viewport, such as 1920 x 1080 or 2048 x 1152.
- Any slides with complex arrows, large geometry, cards, or long text.

Check:

- No text is hidden under template shapes.
- No text overlaps other text or logos.
- Footer/header elements remain aligned.
- Navigation does not cover slide content.
- `?export=1` hides UI controls.
- Fullscreen fills the viewport by scaling the whole slide, not by leaving content stacked at the top.

## 10. Build PPTX When Requested

Use the final HTML as source of truth.

Suggested command flow:

```powershell
.\scripts\render-html-slides.ps1 -HtmlPath "path\deck.html" -OutDir "path\frames" -SlideCount 9
.\scripts\build-picture-pptx.ps1 -ImageDir "path\frames" -OutPptx "path\deck.pptx" -SlideCount 9
```

The image-based PPTX route:

- Preserves HTML design exactly.
- Produces sharp slides when rendered at 3840 x 2160.
- Supports native PowerPoint slide transitions.
- Is not editable at the text/card level.

Verify PPTX:

- Unzip or inspect media dimensions; every slide image should be 3840 x 2160 unless the user chose another resolution.
- Open/export a contact sheet from PowerPoint if available.
- Confirm the deck contains one full-bleed image per slide and native transitions.

## 11. Iterate With Third-Party Skills

When the user references a third-party skill:

- Read that skill's `SKILL.md`.
- Apply only the relevant parts rather than copying the whole style blindly.
- Keep this skill's priority order: template preservation, readable business design, carousel/fullscreen correctness, then decorative animation.

If the third-party skill conflicts with the user's template, preserve the template.
