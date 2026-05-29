# Template-Driven PPT Designer

`template-driven-ppt-designer` 是一个面向 Codex/Agents 的演示文稿制作 skill。它把用户提供的 PowerPoint 模板和源材料转换成高质量的 HTML 演示文稿，并可选导出为高清图片型 PPTX。

这个 skill 的重点不是“重新发明一套样式”，而是保留原始模板的视觉语言：Logo、颜色、页眉页脚、几何元素、机密标识、图标风格和版式节奏都会作为设计约束继续沿用。

## 适合场景

- 用公司 PPT/PPTX 模板生成一份新的汇报 deck。
- 将 Word、PDF、Markdown、旧 PPT、截图、日志或零散笔记整理成商务演示。
- 制作保留品牌风格的 HTML slides。
- 在 HTML 完稿后导出清晰的 16:9 PPTX。
- 为事故复盘、根因分析、项目汇报、方案评审、技术分享等材料建立结构化叙事。

## 能力概览

- 必选输出：交互式 HTML deck。
- 可选输出：基于 3840 x 2160 PNG 的高清图片型 PPTX。
- 支持模板视觉继承：颜色、Logo、页眉页脚、标签、几何形状、图标语言。
- 支持商务汇报常见页面：封面、执行摘要、时间线、机制链路、证据网格、风险影响、行动建议、结束页。
- 支持交互控制：上一页/下一页、键盘导航、页码、圆点导航、全屏模式。
- 支持 QA/export 查询参数：`?slide=N`、`?full=1`、`?export=1`。
- 支持通过 `html-ppt` 作为 HTML deck 设计引擎。
- 支持通过 PowerPoint COM 在 Windows 本地构建图片型 PPTX。

## 安装

如果你的 Codex/Agents 环境支持从 GitHub 安装 skills，可以使用：

```bash
npx skills add https://github.com/ChestnutleeEd/pattern-based-slides-creator
```

如果该仓库只包含 skill 目录之外的其他内容，请将本目录复制或安装到 agents 可发现的 skills 路径中，并确保目录名保持为：

```text
template-driven-ppt-designer
```

安装后，skill 的入口文件应位于：

```text
template-driven-ppt-designer/SKILL.md
```

## 依赖建议

本 skill 可以独立提供流程约束，但推荐配合以下能力使用：

- `html-ppt`：用于 HTML slides 的模板、主题、布局、动画和运行时。
- `Presentations` / PowerPoint：用于需要 PPTX 产物的场景。
- Edge 或 Chrome：用于将 HTML slides 渲染为高清 PNG。
- Microsoft PowerPoint for Windows：用于通过 COM 自动生成 PPTX。

## 基本用法

在 Codex/Agents 中可以这样描述任务：

```text
Use $template-driven-ppt-designer to create a polished HTML deck from my PPT template and source content.
```

如果还需要 PPTX：

```text
Use $template-driven-ppt-designer to create an HTML deck and a high-resolution PPTX export from my PPT template and source content.
```

中文示例：

```text
请使用 $template-driven-ppt-designer，基于我提供的公司 PPT 模板和 Word 材料，制作一份英文根因分析汇报。HTML 必须有，另外请导出一份高清 PPTX。
```

## 输入材料

推荐提供：

- 一个 PPT/PPTX 模板文件。
- 一份或多份源材料，例如 DOCX、PPTX、PDF、Markdown、截图、日志、表格或文字说明。
- 目标受众，例如管理层、客户、工程团队、销售团队。
- 目标语言，例如 English、中文、双语。
- 期望页数或汇报时长。
- 是否需要 PPTX。
- 是否需要保留机密标识、页脚、客户名称、版本信息等模板元素。

当信息缺失时，skill 默认采用：

- 语言：English。
- 比例：16:9。
- HTML 逻辑画布：1280 x 720。
- PPTX 图片导出：3840 x 2160。
- 风格：business-clean / corporate executive report。

## 工作流

1. 确认交付物：HTML 必选，PPTX 可选。
2. 收集模板和源材料。
3. 视觉检查模板，识别必须保留的品牌元素。
4. 将源材料整理为演示叙事。
5. 使用 HTML deck 作为主产物进行设计。
6. 保持 16:9 固定画布，并整体缩放实现全屏适配。
7. 添加适度动画和背景 FX。
8. 截图检查普通视图、全屏视图和导出视图。
9. 如用户要求 PPTX，则从最终 HTML 渲染高清 PNG 并生成 PPTX。
10. 验证 PPTX 清晰度、比例和页内铺满情况。

详细流程见 [references/workflow.md](references/workflow.md)。

## 设计原则

- 模板是设计权威，不随意替换成通用主题。
- 保留 Logo、主色、页眉页脚、标签、几何 motif 和图标风格。
- 使用克制、清晰、可信的商务汇报视觉。
- 标题要表达判断或结论，而不是只写泛泛的页面类型。
- 文本尽量拆成卡片、证据条、参数条或流程节点。
- 全屏时缩放整个 16:9 slide canvas，而不是让每个文本块单独重排。
- 动画服务理解，不抢夺正文注意力。
- PPTX 导出优先走高清图片路线，以换取视觉一致性和清晰度。

详细设计规则见 [references/design-rules.md](references/design-rules.md)。

## PPTX 导出

PPTX 导出采用“HTML 作为唯一视觉来源”的图片型路线：

1. 先完成并验证 HTML。
2. 将每页 HTML 渲染为 3840 x 2160 PNG。
3. 在空白 16:9 PowerPoint 中把每张 PNG 铺满一页。
4. 添加简单原生转场。
5. 检查图片尺寸和最终清晰度。

示例命令：

```powershell
.\scripts\render-html-slides.ps1 -HtmlPath "path\deck.html" -OutDir "path\frames" -SlideCount 9
.\scripts\build-picture-pptx.ps1 -ImageDir "path\frames" -OutPptx "path\deck.pptx" -SlideCount 9
```

### `render-html-slides.ps1`

将 HTML deck 截图为逐页 PNG。

常用参数：

- `-HtmlPath`：HTML deck 路径。
- `-OutDir`：PNG 输出目录。
- `-SlideCount`：总页数。
- `-Width`：截图宽度，默认 `3840`。
- `-Height`：截图高度，默认 `2160`。
- `-BrowserPath`：Edge/Chrome 路径，通常可自动发现。

### `build-picture-pptx.ps1`

将逐页 PNG 组装为 PPTX。

常用参数：

- `-ImageDir`：包含 `slide-01.png`、`slide-02.png` 等图片的目录。
- `-OutPptx`：输出 PPTX 路径。
- `-SlideCount`：总页数。
- `-SlideWidth`：PPT 宽度，默认 `13.333333` 英寸。
- `-SlideHeight`：PPT 高度，默认 `7.5` 英寸。
- `-NoTransitions`：不添加转场。

## 目录结构

```text
template-driven-ppt-designer/
├─ SKILL.md
├─ agents/
│  └─ openai.yaml
├─ references/
│  ├─ design-rules.md
│  └─ workflow.md
├─ scripts/
│  ├─ build-picture-pptx.ps1
│  └─ render-html-slides.ps1
├─ .gitignore
└─ README.md
```

## 校验

可以使用 Codex 官方 skill 校验脚本检查基础结构：

```bash
python path/to/skill-creator/scripts/quick_validate.py path/to/template-driven-ppt-designer
```

当前结构应满足：

- `SKILL.md` 存在。
- frontmatter 中包含 `name` 和 `description`。
- skill 名称与目录名一致。
- `agents/openai.yaml` 提供 UI 展示信息。
- 引用文件和脚本路径存在。

## 限制

- 默认 PPTX 是图片型导出，不支持直接编辑每个文本框或图形。
- 如果需要可编辑 PPTX，需要额外进行 PowerPoint 原生重建，视觉一致性也需要单独 QA。
- PPTX 自动构建依赖 Windows PowerPoint COM。
- HTML 截图导出依赖 Edge 或 Chrome。
- 如果模板里有复杂动画、嵌入视频或特殊字体，需要在 HTML 中手动近似或补充资源。

## 清理与安全

本项目遵守“不要批量删除文件或目录”的工作约束。生成过程可能产生 PNG、PPTX、PDF、日志或临时目录；需要清理时，请一次只删除一个明确路径的文件，或由用户手动清理批量产物。

## License

No license file is currently included. Unless a license is added later, treat the repository as all rights reserved by default.
