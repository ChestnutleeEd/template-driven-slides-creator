param(
  [Parameter(Mandatory=$true)][string]$HtmlPath,
  [Parameter(Mandatory=$true)][string]$OutDir,
  [Parameter(Mandatory=$true)][int]$SlideCount,
  [int]$Width = 3840,
  [int]$Height = 2160,
  [string]$BrowserPath = ""
)

$ErrorActionPreference = "Stop"

$resolvedHtml = Resolve-Path -LiteralPath $HtmlPath
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
$resolvedOut = Resolve-Path -LiteralPath $OutDir

if (-not $BrowserPath) {
  $candidates = @(
    "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe",
    "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe",
    "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
    "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe"
  )
  $BrowserPath = $candidates | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
}

if (-not $BrowserPath -or -not (Test-Path -LiteralPath $BrowserPath)) {
  throw "Could not find Edge or Chrome. Pass -BrowserPath explicitly."
}

$fileUri = ([System.Uri]$resolvedHtml.Path).AbsoluteUri

for ($i = 1; $i -le $SlideCount; $i++) {
  $shot = Join-Path $resolvedOut.Path ("slide-{0:D2}.png" -f $i)
  $url = "{0}?full=1&export=1&slide={1}" -f $fileUri, $i
  & $BrowserPath `
    --headless=new `
    --disable-gpu `
    --hide-scrollbars `
    "--window-size=$Width,$Height" `
    --virtual-time-budget=2500 `
    "--screenshot=$shot" `
    $url | Out-Null
  if (-not (Test-Path -LiteralPath $shot)) {
    throw "Screenshot was not created: $shot"
  }
  Write-Host "Rendered $shot"
}
