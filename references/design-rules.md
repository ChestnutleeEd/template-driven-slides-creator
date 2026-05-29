# Design Rules

## Template Preservation

The supplied template is the design authority. Preserve:

- Logo placement and logo proportions.
- Core colors and accent colors.
- Header bars, footer bars, page labels, confidentiality text, and section chrome.
- Geometric motifs, such as angular blue blocks, diagonals, strips, and cut corners.
- Icon language and line weight.
- Typography feel, even when the exact font is unavailable in HTML.

Do not remove SAP or other template-specific elements unless the user explicitly asks. Do not replace the template with a generic theme.

## Business-Clean Look

Aim for a restrained executive report:

- Clear hierarchy: small section label, strong headline, concise evidence.
- Large whitespace, but every region should feel intentionally composed.
- Thin borders, left accent bars, subtle shadows, and crisp grid alignment.
- Cards are useful for repeated evidence, risks, actions, and KPIs; avoid nested cards.
- Use blue/navy accents from the template, plus limited signal colors such as yellow for warnings.

Avoid:

- Decorative gradients unrelated to the template.
- Overly rounded cards.
- Stock-photo or marketing hero layouts unless the template itself uses them.
- Dense paragraphs that feel copied from a report.

## Layout Patterns

Use these patterns when fitting source content:

- Cover: template geometry plus root claim, metadata, and 2-4 KPI tiles.
- Executive summary: 3-4 insight cards plus one bottom evidence strip.
- Timeline: horizontal line, milestone dots, short descriptions, and a bottom interpretation row.
- Technical mechanism: arrow/process chain with compact cards, plus parameter strip.
- Root cause: large diagnosis statement with proof points and mechanism.
- Impact/risk: 2x2 cards with color-coded accent bars.
- Actions: prioritized action cards with owner, reason, and expected effect.
- Closing: concise decision ask or next-step frame.

## Text Handling

Headlines should be specific and analytical, not generic. Replace "Technical Mechanism" body text with a claim such as "Parallel OData requests exhausted MPI buffers before the dispatcher could recover."

Keep body copy short:

- Card titles: 2-5 words.
- Card body: 1-2 lines when possible.
- Dense technical identifiers can be placed in monospace-style chips or evidence strips.

If text becomes too long:

- Split it into cards.
- Move details into a bottom evidence strip.
- Use smaller supporting text only in secondary areas.
- Never hide overflow under template shapes.

## Fullscreen Scaling

Use a fixed 16:9 slide coordinate system and scale it as a whole. This prevents slides from looking correct in a centered preview but top-heavy in fullscreen.

Recommended values:

- Logical canvas: 1280 x 720.
- Standard screenshot: 1280 x 720.
- PPTX screenshot: 3840 x 2160.
- Presentation ratio: 16:9 wide.

Normal mode can show a centered slide with surrounding page background. Fullscreen mode should fill the viewport while preserving the complete slide composition.

## Animation

Animations should feel like a polished business presentation:

- Fast enough to support pacing.
- Simple enough not to distract.
- Consistent across slides.
- Disabled or stabilized for export screenshots when needed.

Good choices:

- Fade between slides.
- Fade-up for headers and cards.
- Staggered reveal for timelines/process chains.
- Small zoom-pop for KPIs.
- Line draw for process and timeline connectors.

## Canvas FX

Canvas FX are background texture, not content:

- Opacity should usually stay below 0.25.
- Keep FX behind text, logos, and cards.
- Avoid high-contrast particles near body copy.
- Respect export mode; deterministic or static FX is preferred for PPTX image export.

Use FX that match the topic:

- Constellation/network: systems investigation.
- Data stream: HTTP/OData/resource flow.
- Chain/pulse: failure propagation.
- Soft particles/orbits: cover or closing emphasis.

## PPTX Image Export

The final PPTX should be sharp. Do not capture 1280 x 720 slides for PowerPoint if clarity matters.

Preferred export:

- Render each HTML slide to 3840 x 2160 PNG.
- Insert as full-slide image in a 16:9 PowerPoint.
- Add native fade transitions.

Tradeoff:

- Image-based PPTX is visually faithful and crisp.
- It is not text-editable. If editability is required, rebuild natively with PowerPoint shapes and accept a separate QA pass.
