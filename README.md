# Template-Driven Slides Creator

`template-driven-slides-creator` 是一个面向 Codex/Agents 的模板驱动型 slides 创作 skill。它适合这样的任务：用户提供一个 PPT/PPTX 模板，再提供参考文档、资料、旧 deck、Word、PDF、Markdown、截图或笔记，agent 需要基于模板风格生成一份完整、漂亮、可演示的 slides 成果。

这个 skill 的核心思想是：

1. **先尊重模板**：用户给的 PPT 模板是视觉基础，Logo、颜色、页眉页脚、几何元素、机密标识、图标风格、页码和版式节奏都必须保留。
2. **先用 `Presentations` 做初版**：根据模板和参考资料，先创建一版遵循模板规则、叙事结构清晰的初始成果。
3. **再用 `html-ppt` 做最终美化**：让用户从 `html-ppt` 的 36 个 themes 里选择一个主题，把它作为“美化层”叠加到模板风格之上，用于优化节奏、动画、全屏、轮播、交互和视觉完成度。
4. **必须通过对话确认 PPTX**：HTML 是主要输出；是否还需要 PPTX，必须问用户。
5. **必须做二轮逐页检测**：最终版生成后，agent 需要从第一页到最后一页检查排版、动画、全屏、导出和设计深化空间。
6. **必须避免版式重复**：如果很多页都像同一个卡片网格或同一种标题+框架组合，需要继续优化，让设计更丰富、多样、有节奏。

## Skill 名称

```text
template-driven-slides-creator
```

推荐调用方式：

```text
Use $template-driven-slides-creator to create slides from my PPT template and reference documents.
```

中文示例：

```text
请使用 $template-driven-slides-creator，基于我提供的 PPT 模板和参考文档，先生成符合模板风格的初版，再让我选择 html-ppt 主题进行最终优化。请先问我是否需要 PPTX。
```

## 必要依赖

本 skill 是一个“编排型 skill”，不会把 `html-ppt` 和 `Presentations` 的全部内容复制到本仓库中。它会要求 agent 在工作时调用这两个 skill。

这两个 skill 是必要依赖，不是可选项：

- `presentations:Presentations`
- `html-ppt`

如果其中任何一个不存在，agent 必须在一开始停止并通过对话询问用户是否安装或启用缺失的 skill，同时解释它们为什么必要。

### 为什么必须要 `Presentations`

`Presentations` 负责第一阶段：根据用户提供的 PPT/PPTX 模板和参考资料创建初版成果。

它适合：

- 原生 PPTX / PowerPoint 相关工作流。
- 使用 artifact-tool presentation JSX。
- 分析和继承模板结构。
- 创建可编辑 PPTX 或 PPTX-aware 初稿。
- 对 deck 做更严格的预览、渲染和 QA。

`Presentations` 通常来自 Codex 的 Presentations 插件/运行时。它不是本仓库自带内容，具体安装路径会因机器、用户目录和插件版本而变化。

```text
<CODEX_HOME>/plugins/cache/openai-primary-runtime/presentations/<version>/skills/presentations/SKILL.md
```

请在 Codex 中启用 `Presentations` 插件或确认 `$presentations:Presentations` 可用。用户可以查看该插件自带的 `SKILL.md`，了解 artifact-tool presentation JSX、PPTX 导入、PPTX 导出、预览和 QA 等其他功能。

### 为什么必须要 `html-ppt`

`html-ppt` 负责第二阶段：将初版成果优化成最终 HTML slide experience。

它提供：

- 36 个 themes。
- 单页布局和整套 deck 模板。
- CSS 动画。
- canvas FX。
- 键盘导航。
- 主题切换。
- 全屏能力。
- presenter mode。
- HTML-to-PNG 渲染约定。

`html-ppt` 原地址：

[https://github.com/lewislulu/html-ppt-skill](https://github.com/lewislulu/html-ppt-skill)

安装方式：

```bash
npx skills add https://github.com/lewislulu/html-ppt-skill
```

`html-ppt` 还有很多额外能力，例如 full-deck templates、presenter mode、animations showcase、themes showcase、single-page layouts 等。用户可以前往它的源仓库查看完整功能。

## 安装本 Skill

如果你的 Codex/Agents 环境支持从 GitHub 安装 skills，可以使用：

```bash
npx skills add https://github.com/ChestnutleeEd/template-driven-slides-creator
```

安装后，skill 目录名应为：

```text
template-driven-slides-creator
```

入口文件应为：

```text
template-driven-slides-creator/SKILL.md
```

## 推荐安装顺序

1. 启用或确认 `Presentations` 插件可用。
2. 安装 `html-ppt`：

```bash
npx skills add https://github.com/lewislulu/html-ppt-skill
```

3. 安装本 skill：

```bash
npx skills add https://github.com/ChestnutleeEd/template-driven-slides-creator
```

4. 在 Codex 中确认可以触发：

```text
$presentations:Presentations
$html-ppt
$template-driven-slides-creator
```

## 整体工作流程

### 1. 检查必要依赖

agent 必须先检查：

- `Presentations` 是否存在。
- `html-ppt` 是否存在。

如果缺失，必须询问是否安装或启用，并说明：

- 没有 `Presentations`，无法完成“基于模板和参考资料创建初版”的阶段。
- 没有 `html-ppt`，无法完成“36 themes 选择、动画、canvas FX、轮播、全屏、HTML runtime”的最终优化阶段。

### 2. 询问是否需要 PPTX

agent 必须通过对话询问：

```text
是否还需要 PPTX 文件？
- 只需要 HTML
- HTML + PPTX
- HTML + 可编辑 PPTX
```

默认不能替用户假设一定要或一定不要 PPTX。

### 3. 读取模板和参考资料

agent 会分析：

- PPT/PPTX 模板。
- 参考文档。
- 目标受众。
- 语言和语气。
- 页数或演示时长。
- 必须保留的模板元素。

模板分析重点：

- Logo。
- 主色和辅助色。
- 页眉、页脚、页码。
- 机密标识。
- 几何图形和装饰语言。
- 图标风格。
- 字体感觉。
- 版式节奏。

### 4. 使用 `Presentations` 创建初版

第一阶段使用 `Presentations`，根据模板和参考资料创建初版成果。

初版目标：

- 遵循模板视觉规则。
- 提炼参考资料中的叙事主线。
- 形成页面结构。
- 明确每页的结论、证据和视觉对象。
- 保留模板里的关键品牌元素。

这一步可以产出初版 PPTX、结构化 deck plan、页面草案或可继续优化的中间成果，具体取决于用户材料和环境能力。

### 5. 让用户选择 `html-ppt` 主题

第二阶段开始前，agent 必须列出 36 个 `html-ppt` themes，并提供中文翻译，让用户选择一个。

完整列表：

| Theme | 中文释义 |
| --- | --- |
| `minimal-white` | 极简白 |
| `editorial-serif` | 编辑部衬线 |
| `soft-pastel` | 柔和粉彩 |
| `sharp-mono` | 锐利等宽 |
| `arctic-cool` | 北极冷调 |
| `sunset-warm` | 日落暖调 |
| `catppuccin-latte` | 拿铁浅色 |
| `catppuccin-mocha` | 摩卡深色 |
| `dracula` | 德古拉暗色 |
| `tokyo-night` | 东京夜色 |
| `nord` | 北欧冷调 |
| `solarized-light` | 日光浅色 |
| `gruvbox-dark` | 复古暗色 |
| `rose-pine` | 玫瑰松木 |
| `neo-brutalism` | 新粗野主义 |
| `glassmorphism` | 玻璃拟态 |
| `bauhaus` | 包豪斯 |
| `swiss-grid` | 瑞士网格 |
| `terminal-green` | 终端绿色 |
| `xiaohongshu-white` | 小红书白 |
| `rainbow-gradient` | 彩虹渐变 |
| `aurora` | 极光 |
| `blueprint` | 蓝图 |
| `memphis-pop` | 孟菲斯波普 |
| `cyberpunk-neon` | 赛博霓虹 |
| `y2k-chrome` | 千禧铬色 |
| `retro-tv` | 复古电视 |
| `japanese-minimal` | 日式极简 |
| `vaporwave` | 蒸汽波 |
| `midcentury` | 中世纪现代 |
| `corporate-clean` | 商务简洁 |
| `academic-paper` | 学术论文 |
| `news-broadcast` | 新闻播报 |
| `pitch-deck-vc` | VC 融资路演 |
| `magazine-bold` | 大胆杂志 |
| `engineering-whiteprint` | 工程白图 |

agent 可以根据模板和用途推荐 2-3 个主题，但最终应由用户选择。

推荐参考：

- 正式商务汇报：`corporate-clean`、`swiss-grid`、`minimal-white`、`pitch-deck-vc`
- 技术分享 / 工程报告：`blueprint`、`engineering-whiteprint`、`tokyo-night`、`sharp-mono`
- 学术 / 报告：`academic-paper`、`editorial-serif`、`solarized-light`
- 更有表达感的内部分享：`aurora`、`bauhaus`、`magazine-bold`、`soft-pastel`

注意：选择的 theme 是美化层，不是替换模板。模板风格永远优先。

### 6. 使用 `html-ppt` 优化最终版

agent 使用 `html-ppt` 将初版成果优化为最终 HTML slides。

必须实现或检查：

- 保留模板风格。
- 应用用户选择的 theme。
- 全屏按钮。
- 轮播或 carousel 导航。
- 上一页 / 下一页控制。
- 页码或 slide counter。
- 键盘导航。
- 适度 CSS 动画。
- 必要时使用 canvas FX。
- 支持 `?slide=N`、`?full=1`、`?export=1`。
- export 模式隐藏导航控件。

### 7. 二轮逐页检测与设计深化

最终 HTML 版生成后，agent 必须进行二轮检测，从第一页到最后一页逐页检查。这个步骤不是可选项，不能只看首页或只看 contact sheet。

第一类检查是技术质量：

- 排版是否对齐。
- 文本是否重叠、裁切或被模板形状遮住。
- Logo、页眉、页脚、页码、机密标识是否保留并对齐。
- 全屏后是否正确适配屏幕。
- 轮播按钮、导航点、页码是否遮挡正文。
- 动画顺序、速度和可读性是否合理。
- canvas FX 是否在内容后方，是否干扰文字。
- `?export=1` 模式是否隐藏所有不该出现的控件。

第二类检查是设计深化：

- 是否很多页都是同一种版式。
- 是否连续多页都是类似的卡片网格。
- 是否每页都有明确视觉锚点。
- 是否有页面显得太空、太平或只是把文字放进框里。
- 是否可以加入更合适的图表、时间线、证据条、参数带、流程图、对比模块、重点 callout。
- 是否可以通过不同的构图、信息密度、动画节奏，让整份 deck 更丰富、多样、有作者感。

如果二轮检测发现问题，agent 必须继续迭代弱页，然后重新检查相关页面。不能因为“所有页面都已经生成”就直接交付。

### 8. 避免之前的错误

这个 skill 明确要求 agent 不能再犯这些错误：

- 全屏后不符合屏幕尺寸。
- slide 只贴在屏幕上方，下面大面积空白。
- 文字和文字互相遮挡。
- 文字被模板形状盖住。
- 文字和 Logo、页脚、页码、机密标识冲突。
- 轮播按钮或导航点遮挡正文。
- canvas FX 覆盖正文。
- export 模式仍然显示控制按钮。
- 1280 x 720 看起来正常，但 1920 x 1080 全屏时布局坏掉。

正确做法是使用固定 16:9 逻辑画布，例如 1280 x 720，然后整体缩放到屏幕，而不是让每个文本块单独重排。

### 9. 截图 QA

交付前应检查：

- 1280 x 720 基准视图。
- 普通浏览器预览。
- 1920 x 1080 或类似尺寸的全屏视图。
- `?full=1&export=1&slide=N` 导出视图。
- 所有复杂页面，例如流程图、时间线、证据网格、长文本、图表、卡片页。

必须修复：

- 文本遮挡。
- 内容裁切。
- Logo 或页脚错位。
- 全屏比例错误。
- 控件遮挡内容。
- 导出图里出现导航 UI。

### 10. PPTX 输出

如果用户选择需要 PPTX，有两种路线：

#### HTML + PPTX

适合追求视觉保真的场景。

流程：

1. 先完成最终 HTML。
2. 将每页渲染为 3840 x 2160 PNG。
3. 把 PNG 全屏铺到 16:9 PowerPoint 中。
4. 添加简单原生转场。
5. 检查清晰度和页数。

示例：

```powershell
.\scripts\render-html-slides.ps1 -HtmlPath "path\deck.html" -OutDir "path\frames" -SlideCount 9
.\scripts\build-picture-pptx.ps1 -ImageDir "path\frames" -OutPptx "path\deck.pptx" -SlideCount 9
```

优点：视觉还原度高，清晰。  
缺点：PPTX 中的文字和形状不可逐个编辑。

#### HTML + 可编辑 PPTX

适合用户明确要求可编辑文本框、图形、表格或图表的场景。

流程：

1. 使用 `Presentations` / artifact-tool presentation JSX。
2. 继承模板视觉系统。
3. 原生构建或编辑 PPTX。
4. 做额外 QA。

优点：可编辑。  
缺点：和最终 HTML 可能不是像素级一致，需要额外校验。

如果生成 PPTX，agent 还需要确认二轮检测中的修复在 PPTX 导出或重建后仍然保留。

## 示例 Prompt

### HTML only

```text
Use $template-driven-slides-creator to create an HTML slide deck from my PPT template and reference document. Ask me to choose one html-ppt theme before final polish.
```

### HTML + PPTX

```text
Use $template-driven-slides-creator to create final HTML slides and also ask whether I need a high-fidelity PPTX export.
```

### 中文

```text
请使用 $template-driven-slides-creator。我的输入包括一个 PPT 模板和一份参考文档。请先检查 Presentations 和 html-ppt 是否可用，然后问我是否需要 PPTX，再用 Presentations 做初版，之后列出 html-ppt 的 36 个主题及中文翻译让我选择，并基于选择的主题完成最终美化。最终版生成后，请从第一页到最后一页做二轮检测，重点检查全屏尺寸、文字遮挡、动画效果和版式是否重复。
```

## 目录结构

```text
template-driven-slides-creator/
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
python path/to/skill-creator/scripts/quick_validate.py path/to/template-driven-slides-creator
```

校验重点：

- `SKILL.md` 存在。
- frontmatter 中包含 `name` 和 `description`。
- `name` 为 `template-driven-slides-creator`。
- skill 目录名与 skill 名称一致。
- `agents/openai.yaml` 展示信息匹配新名称。
- 引用文件和脚本路径存在。

## 外部 Skill 源地址

### html-ppt

源地址：

[https://github.com/lewislulu/html-ppt-skill](https://github.com/lewislulu/html-ppt-skill)

安装：

```bash
npx skills add https://github.com/lewislulu/html-ppt-skill
```

说明：请前往该仓库查看完整主题、模板、动画、canvas FX、presenter mode 和 runtime 功能。

### Presentations

来源：

```text
Codex Presentations plugin/runtime
```

通用本地路径形式：

```text
<CODEX_HOME>/plugins/cache/openai-primary-runtime/presentations/<version>/skills/presentations/SKILL.md
```

说明：`Presentations` 通常来自 Codex 的 Presentations 插件/运行时。请在 Codex 插件环境中启用它，并查看该插件自带的 `SKILL.md` 了解 artifact-tool presentation JSX、PPTX 导入、PPTX 导出、预览和 QA 等能力。README 不应写入任何个人用户目录或机器专属路径。

## 限制

- 本仓库不复制 `html-ppt` 和 `Presentations` 的全部内容。
- 没有这两个必要依赖时，本 workflow 不应继续执行。
- 图片型 PPTX 视觉保真但不可逐元素编辑。
- 可编辑 PPTX 需要额外 QA，并且可能与 HTML 最终版存在细微差异。
- HTML 截图导出依赖 Edge 或 Chrome。
- 图片型 PPTX 自动构建依赖 Windows PowerPoint COM。

## 清理与安全

本项目遵守“不要批量删除文件或目录”的工作约束。生成过程可能产生 PNG、PPTX、PDF、日志或临时目录；需要清理时，请一次只删除一个明确路径的文件，或由用户手动清理批量产物。

## License

No license file is currently included. Unless a license is added later, treat the repository as all rights reserved by default.
