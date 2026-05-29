# Workflow

## 1. Required Skill Gate

This skill requires both `presentations:Presentations` and `html-ppt`.

Before creating any deck, check whether both skills are installed and available:

- `presentations:Presentations`: required for the first-pass deck creation from the supplied PPT/PPTX template and reference materials.
- `html-ppt`: required for final HTML slide authoring, the 36-theme selection step, reusable themes/layouts, CSS animations, canvas FX, carousel/runtime behavior, fullscreen behavior, presenter behavior, and HTML export conventions.

If either skill is missing, stop and ask the user whether to install the missing skill(s). The prompt should explain why they are necessary:

```text
This workflow requires both Presentations and html-ppt.
- Presentations is required to create the first-pass template/reference-based deck.
- html-ppt is required for the final HTML slide system, 36-theme selection, animation, canvas FX, carousel controls, and fullscreen/runtime behavior.

One or both skills are missing. Do you want me to help install or enable them before continuing?
```

Do not silently continue with a downgraded workflow. Continue only after both required skills are available, or after the user explicitly changes the requirement.

## 2. Confirm PPTX Requirement

HTML output is always part of this workflow. PPTX output must be confirmed through conversation.

Ask:

```text
Do you also need a PPTX file?
- HTML only
- HTML + PPTX
- HTML + editable PPTX
```

Use the answer to choose the final export route:

- `HTML only`: deliver the final HTML deck.
- `HTML + PPTX`: prefer high-fidelity image-based PPTX from final HTML.
- `HTML + editable PPTX`: use `Presentations` and artifact-tool workflows for native editable PPTX, accepting that it may require extra QA and may be less pixel-identical to the HTML.

## 3. Gather Inputs

Collect or infer:

- PPT/PPTX template file.
- Reference/source files such as DOCX, PPTX, PDF, Markdown, screenshots, logs, notes, or tables.
- Audience, language, tone, confidentiality requirements, target length, and intended delivery context.
- Whether the user needs HTML only, HTML + image-based PPTX, or HTML + editable PPTX.
- Any fixed template elements that must be preserved.

Default assumptions when not specified:

- Language: English.
- Slide ratio: 16:9.
- HTML slide canvas: 1280 x 720 logical pixels.
- PPTX image export: 3840 x 2160 PNG per slide.
- Style: template-first business-clean executive report.

## 4. Inspect the Template

Before writing slides, inspect the PPT template as the design foundation:

- Render or screenshot representative template slides.
- Identify colors, typography feel, title bars, footers, logos, icons, motifs, geometric shapes, watermark behavior, page numbers, and confidentiality labels.
- Extract reusable assets if needed.
- Record "must preserve" rules.

Do not invent a new brand system. The final output should feel like a refined continuation of the supplied template.

## 5. Build the First-Pass Result With Presentations

Use the installed `presentations:Presentations` skill to create the first-pass result from the supplied template and reference materials.

The first pass should:

- Follow the template's visual system and layout grammar.
- Convert reference materials into a concise narrative.
- Establish slide claims, proof objects, and recommended page sequence.
- Preserve template identity, especially logos, colors, footer/header chrome, geometry, and confidentiality labels.
- Produce an initial deck or structured deck plan that can be refined into the final HTML deck.

For incident/root-cause decks, a useful default sequence is:

1. Cover with root-cause claim and key facts.
2. Executive summary.
3. Incident timeline.
4. Technical mechanism / failure chain.
5. Evidence and parameters.
6. Root cause.
7. Impact and risk.
8. Recommended actions.
9. Closing / decision page.

## 6. Ask the User to Choose an html-ppt Theme

After the first-pass result exists, ask the user to choose one `html-ppt` theme. Show the full list:

```text
Please choose one html-ppt theme for the final polish layer:
minimal-white, editorial-serif, soft-pastel, sharp-mono, arctic-cool, sunset-warm,
catppuccin-latte, catppuccin-mocha, dracula, tokyo-night, nord, solarized-light,
gruvbox-dark, rose-pine, neo-brutalism, glassmorphism, bauhaus, swiss-grid,
terminal-green, xiaohongshu-white, rainbow-gradient, aurora, blueprint,
memphis-pop, cyberpunk-neon, y2k-chrome, retro-tv, japanese-minimal, vaporwave,
midcentury, corporate-clean, academic-paper, news-broadcast, pitch-deck-vc,
magazine-bold, engineering-whiteprint.
```

Recommend 2-3 choices based on the template and audience. Examples:

- Formal business / executive report: `corporate-clean`, `swiss-grid`, `minimal-white`, `pitch-deck-vc`.
- Technical or engineering: `blueprint`, `engineering-whiteprint`, `tokyo-night`, `sharp-mono`.
- Academic/report: `academic-paper`, `editorial-serif`, `solarized-light`.
- More expressive internal sharing: `aurora`, `bauhaus`, `magazine-bold`, `soft-pastel`.

The selected theme is a refinement layer. It must not override the supplied PPT template's brand identity.

## 7. Refine the Final HTML Deck With html-ppt

Use the installed `html-ppt` skill to build or refine the final HTML deck.

Required behavior:

- Preserve the original template style as the base visual system.
- Apply the user-selected html-ppt theme as controlled polish, not a replacement brand.
- Add carousel-style slide navigation with previous/next buttons, dots, counter, and keyboard support.
- Support keyboard navigation: ArrowLeft/ArrowRight, PageUp/PageDown, Home/End, Space, and F for fullscreen when practical.
- Add a visible fullscreen button.
- Support query parameters for QA/export: `?slide=N`, `?full=1`, and `?export=1`.
- Hide UI controls in export mode.
- Add appropriate CSS animations and optional canvas FX from html-ppt when they improve comprehension.

Use template-inspired layouts such as:

- Cover with template geometry and key facts.
- Executive summary with insight cards.
- Timeline.
- Failure chain or process diagram.
- Evidence grid or parameter strip.
- Risk/impact comparison.
- Recommendation cards.
- Closing / decision page.

## 8. Responsive Fullscreen Rules

Fullscreen correctness is mandatory.

Use one fixed logical 16:9 slide coordinate system and scale the complete slide canvas to the viewport.

Recommended model:

- `.deck-shell` owns the viewport.
- `.slide-stage` stays 1280 x 720.
- JavaScript computes `scale = min(window.innerWidth / 1280, window.innerHeight / 720)`.
- Apply scale to the whole slide stage using `zoom` or `transform`.
- In normal mode, cap scale at 1 if a centered preview is desired.
- In fullscreen mode, allow scale above 1 so content fills the screen without leaving large blank lower areas.

Do not let individual text blocks, cards, or diagrams reflow independently in fullscreen. That caused previous failures such as top-heavy slides, incorrect screen fit, and broken geometry.

## 9. Layout QA

Use screenshots before final delivery:

- 1280 x 720 baseline view.
- Normal browser-centered preview.
- Fullscreen-sized viewport, such as 1920 x 1080 or 2048 x 1152.
- Export mode using `?full=1&export=1&slide=N`.
- Any slide with long text, complex arrows, large geometry, cards, charts, or dense evidence.

Fix these issues before delivery:

- Text hidden under template shapes.
- Text overlapping other text, logos, page numbers, controls, or footers.
- Controls covering slide content.
- Fullscreen content not fitting the viewport.
- Slides becoming top-heavy in fullscreen.
- Logos, headers, footers, and confidentiality labels drifting out of alignment.
- Canvas FX or animation obscuring content.
- Export mode showing navigation UI.
- Cropped or off-screen content.

## 10. Build PPTX When Requested

If the user requested PPTX, choose the route based on their answer.

For high-fidelity image-based PPTX:

```powershell
.\scripts\render-html-slides.ps1 -HtmlPath "path\deck.html" -OutDir "path\frames" -SlideCount 9
.\scripts\build-picture-pptx.ps1 -ImageDir "path\frames" -OutPptx "path\deck.pptx" -SlideCount 9
```

The image-based route:

- Preserves final HTML design closely.
- Produces sharp slides when rendered at 3840 x 2160.
- Supports native PowerPoint slide transitions.
- Is not editable at the text/card level.

For editable PPTX:

- Use `Presentations` and artifact-tool presentation JSX.
- Preserve template identity.
- Run extra QA because native PPTX reconstruction may differ from the final HTML.

Verify PPTX:

- Final file exists and is non-empty.
- Slide count is correct.
- Image-based PPTX has full-bleed 16:9 slide images.
- Editable PPTX has no obvious layout drift, text overlap, or broken template elements.

## 11. Final Response

Summarize:

- Final HTML location.
- PPTX location if requested.
- Selected html-ppt theme.
- Required dependency status.
- Any known residual limitation, especially whether PPTX is image-based or editable.
