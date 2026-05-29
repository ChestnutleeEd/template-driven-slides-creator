param(
  [Parameter(Mandatory=$true)][string]$ImageDir,
  [Parameter(Mandatory=$true)][string]$OutPptx,
  [Parameter(Mandatory=$true)][int]$SlideCount,
  [double]$SlideWidth = 13.333333,
  [double]$SlideHeight = 7.5,
  [switch]$NoTransitions
)

$ErrorActionPreference = "Stop"

$resolvedImageDir = Resolve-Path -LiteralPath $ImageDir
$outParent = Split-Path -Parent $OutPptx
if ($outParent) {
  New-Item -ItemType Directory -Force -Path $outParent | Out-Null
}
$outFull = [System.IO.Path]::GetFullPath($OutPptx)

$powerPoint = New-Object -ComObject PowerPoint.Application
$powerPoint.Visible = [Microsoft.Office.Core.MsoTriState]::msoTrue
$presentation = $powerPoint.Presentations.Add()

try {
  $presentation.PageSetup.SlideWidth = $SlideWidth * 72
  $presentation.PageSetup.SlideHeight = $SlideHeight * 72

  for ($i = 1; $i -le $SlideCount; $i++) {
    $imagePath = Join-Path $resolvedImageDir.Path ("slide-{0:D2}.png" -f $i)
    if (-not (Test-Path -LiteralPath $imagePath)) {
      throw "Missing slide image: $imagePath"
    }

    $slide = $presentation.Slides.Add($i, 12)
    $slide.Shapes.AddPicture($imagePath, $false, $true, 0, 0, $presentation.PageSetup.SlideWidth, $presentation.PageSetup.SlideHeight) | Out-Null

    if (-not $NoTransitions) {
      $transition = $slide.SlideShowTransition
      $transition.AdvanceOnClick = $true
      $transition.Duration = 0.55
      $transition.EntryEffect = 1793
    }

    Write-Host "Added slide $i"
  }

  $presentation.SaveAs($outFull)
  Write-Host "Saved $outFull"
}
finally {
  if ($presentation) { $presentation.Close() }
  if ($powerPoint) { $powerPoint.Quit() }
}
