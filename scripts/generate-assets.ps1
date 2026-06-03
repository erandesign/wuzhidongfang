Add-Type -AssemblyName System.Drawing

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$outDir = Join-Path $root "public\images"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

function ColorFromHex($hex, [int]$alpha = 255) {
  $value = $hex.TrimStart("#")
  $r = [Convert]::ToInt32($value.Substring(0, 2), 16)
  $g = [Convert]::ToInt32($value.Substring(2, 2), 16)
  $b = [Convert]::ToInt32($value.Substring(4, 2), 16)
  return [System.Drawing.Color]::FromArgb($alpha, $r, $g, $b)
}

function New-Canvas([int]$width, [int]$height, $top, $bottom) {
  $bitmap = New-Object System.Drawing.Bitmap($width, $height)
  $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
  $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
  $graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
  $rect = New-Object System.Drawing.Rectangle(0, 0, $width, $height)
  $brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rect, $top, $bottom, 90)
  $graphics.FillRectangle($brush, $rect)
  $brush.Dispose()
  return @{ Bitmap = $bitmap; Graphics = $graphics; Width = $width; Height = $height }
}

function Add-Grain($g, [int]$width, [int]$height, [int]$count, [int]$alpha) {
  $random = New-Object System.Random(33)
  for ($i = 0; $i -lt $count; $i++) {
    $x = $random.Next(0, $width)
    $y = $random.Next(0, $height)
    $size = $random.Next(1, 4)
    $shade = $random.Next(80, 180)
    $brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb($alpha, $shade, $shade, $shade))
    $g.FillRectangle($brush, $x, $y, $size, $size)
    $brush.Dispose()
  }
}

function Add-Shadow($g, [float]$x, [float]$y, [float]$w, [float]$h, [int]$alpha = 46) {
  for ($i = 0; $i -lt 6; $i++) {
    $brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb([Math]::Max(2, $alpha - ($i * 7)), 30, 30, 26))
    $g.FillEllipse($brush, $x - ($i * 10), $y - ($i * 5), $w + ($i * 20), $h + ($i * 10))
    $brush.Dispose()
  }
}

function Draw-Linen($g, [float]$x, [float]$y, [float]$w, [float]$h, [float]$angle, $baseColor) {
  $state = $g.Save()
  $g.TranslateTransform($x + $w / 2, $y + $h / 2)
  $g.RotateTransform($angle)
  $g.TranslateTransform(-$w / 2, -$h / 2)
  $brush = New-Object System.Drawing.SolidBrush($baseColor)
  $g.FillRectangle($brush, 0, 0, $w, $h)
  $brush.Dispose()
  $pen = New-Object System.Drawing.Pen((ColorFromHex "#fff9ef" 44), 1)
  for ($i = 0; $i -lt $w; $i += 18) {
    $g.DrawLine($pen, $i, 0, $i - 35, $h)
  }
  for ($j = 0; $j -lt $h; $j += 22) {
    $g.DrawLine($pen, 0, $j, $w, $j + 12)
  }
  $pen.Dispose()
  $edge = New-Object System.Drawing.Pen((ColorFromHex "#8f8171" 80), 2)
  $g.DrawRectangle($edge, 0, 0, $w, $h)
  $edge.Dispose()
  $g.Restore($state)
}

function Draw-Vessel($g, [float]$x, [float]$y, [float]$w, [float]$h, $bodyColor, $rimColor) {
  $path = New-Object System.Drawing.Drawing2D.GraphicsPath
  $path.StartFigure()
  $path.AddBezier($x + $w * 0.47, $y + $h * 0.02, $x + $w * 0.08, $y + $h * 0.20, $x + $w * 0.10, $y + $h * 0.84, $x + $w * 0.47, $y + $h * 0.98)
  $path.AddBezier($x + $w * 0.47, $y + $h * 0.98, $x + $w * 0.90, $y + $h * 0.86, $x + $w * 0.88, $y + $h * 0.22, $x + $w * 0.53, $y + $h * 0.02)
  $path.CloseFigure()
  $brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush((New-Object System.Drawing.RectangleF($x, $y, $w, $h)), $bodyColor, (ColorFromHex "#7f796e"), 20)
  $g.FillPath($brush, $path)
  $brush.Dispose()
  $pen = New-Object System.Drawing.Pen((ColorFromHex "#faf6ea" 76), 2)
  $g.DrawPath($pen, $path)
  $pen.Dispose()
  $rimBrush = New-Object System.Drawing.SolidBrush($rimColor)
  $g.FillEllipse($rimBrush, $x + $w * 0.26, $y, $w * 0.48, $h * 0.13)
  $rimBrush.Dispose()
  $inner = New-Object System.Drawing.SolidBrush((ColorFromHex "#3d3b34" 120))
  $g.FillEllipse($inner, $x + $w * 0.31, $y + $h * 0.03, $w * 0.38, $h * 0.06)
  $inner.Dispose()
}

function Draw-Incense($g, [float]$x, [float]$y, [float]$scale = 1.0) {
  $stem = New-Object System.Drawing.Pen((ColorFromHex "#2b2721" 210), [Math]::Max(2, 3 * $scale))
  $g.DrawLine($stem, $x, $y, $x + 22 * $scale, $y - 230 * $scale)
  $stem.Dispose()
  $smoke = New-Object System.Drawing.Pen((ColorFromHex "#f5f0e5" 126), [Math]::Max(2, 5 * $scale))
  $path = New-Object System.Drawing.Drawing2D.GraphicsPath
  $path.AddBezier($x + 18 * $scale, $y - 230 * $scale, $x - 76 * $scale, $y - 320 * $scale, $x + 98 * $scale, $y - 390 * $scale, $x - 18 * $scale, $y - 470 * $scale)
  $path.AddBezier($x - 18 * $scale, $y - 470 * $scale, $x + 90 * $scale, $y - 555 * $scale, $x - 42 * $scale, $y - 620 * $scale, $x + 40 * $scale, $y - 690 * $scale)
  $g.DrawPath($smoke, $path)
  $path.Dispose()
  $smoke.Dispose()
}

function Draw-Lamp($g, [float]$x, [float]$y, [float]$w, [float]$h) {
  $glow = New-Object System.Drawing.SolidBrush((ColorFromHex "#f0d39b" 54))
  $g.FillEllipse($glow, $x - $w * 0.4, $y - $h * 0.2, $w * 1.8, $h * 1.4)
  $glow.Dispose()
  $shade = New-Object System.Drawing.Drawing2D.GraphicsPath
  $lampPoints = [System.Drawing.PointF[]]@(
    (New-Object System.Drawing.PointF -ArgumentList (($x + ($w * 0.22)), $y)),
    (New-Object System.Drawing.PointF -ArgumentList (($x + ($w * 0.82)), ($y + ($h * 0.04)))),
    (New-Object System.Drawing.PointF -ArgumentList (($x + $w), ($y + ($h * 0.74)))),
    (New-Object System.Drawing.PointF -ArgumentList ($x, ($y + ($h * 0.70))))
  )
  $shade.AddPolygon($lampPoints)
  $paper = New-Object System.Drawing.SolidBrush((ColorFromHex "#eadbc0" 228))
  $g.FillPath($paper, $shade)
  $paper.Dispose()
  $edge = New-Object System.Drawing.Pen((ColorFromHex "#6d5d4c" 110), 2)
  $g.DrawPath($edge, $shade)
  $edge.Dispose()
  $base = New-Object System.Drawing.SolidBrush((ColorFromHex "#3a2d24"))
  $g.FillRectangle($base, $x + $w * 0.46, $y + $h * 0.70, $w * 0.08, $h * 0.26)
  $g.FillEllipse($base, $x + $w * 0.26, $y + $h * 0.90, $w * 0.48, $h * 0.09)
  $base.Dispose()
}

function Save-Canvas($canvas, $name) {
  $path = Join-Path $outDir $name
  $canvas.Bitmap.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
  $canvas.Graphics.Dispose()
  $canvas.Bitmap.Dispose()
}

function New-Hero {
  $canvas = New-Canvas 1800 1200 (ColorFromHex "#d8c9b4") (ColorFromHex "#6c715d")
  $g = $canvas.Graphics
  Add-Grain $g 1800 1200 1700 20
  Draw-Linen $g 120 650 1220 290 -6 (ColorFromHex "#c7b7a4")
  Add-Shadow $g 840 800 430 96 58
  Draw-Vessel $g 820 330 340 560 (ColorFromHex "#d9d1c3") (ColorFromHex "#f2eadb")
  Add-Shadow $g 520 890 520 72 38
  Draw-Incense $g 530 865 1.0
  Draw-Lamp $g 1250 235 310 480
  $veil = New-Object System.Drawing.SolidBrush((ColorFromHex "#1a1916" 46))
  $g.FillRectangle($veil, 0, 0, 680, 1200)
  $veil.Dispose()
  Save-Canvas $canvas "hero-still-life.png"
}

function New-CategoryCeramics {
  $canvas = New-Canvas 1000 1300 (ColorFromHex "#eee7dc") (ColorFromHex "#b2a795")
  $g = $canvas.Graphics
  Add-Grain $g 1000 1300 900 18
  Draw-Linen $g 80 790 780 260 -8 (ColorFromHex "#d1c3ae")
  Add-Shadow $g 265 865 430 80 45
  Draw-Vessel $g 300 330 360 590 (ColorFromHex "#d7d3c8") (ColorFromHex "#f7f2e8")
  Save-Canvas $canvas "category-ceramics.png"
}

function New-CategoryLinen {
  $canvas = New-Canvas 1000 1300 (ColorFromHex "#e9dfcf") (ColorFromHex "#918a7a")
  $g = $canvas.Graphics
  Add-Grain $g 1000 1300 1100 22
  Draw-Linen $g 130 210 740 870 4 (ColorFromHex "#cdbda6")
  Draw-Linen $g 240 350 530 610 -11 (ColorFromHex "#e5d8c6")
  $shadow = New-Object System.Drawing.SolidBrush((ColorFromHex "#2b2a25" 32))
  $g.FillEllipse($shadow, 210, 1050, 620, 95)
  $shadow.Dispose()
  Save-Canvas $canvas "category-linen.png"
}

function New-CategoryIncense {
  $canvas = New-Canvas 1000 1300 (ColorFromHex "#d1c1ad") (ColorFromHex "#5d6950")
  $g = $canvas.Graphics
  Add-Grain $g 1000 1300 900 18
  Draw-Linen $g 80 890 820 170 3 (ColorFromHex "#b9aa96")
  Add-Shadow $g 350 940 330 80 52
  $holder = New-Object System.Drawing.SolidBrush((ColorFromHex "#39362f"))
  $g.FillEllipse($holder, 342, 890, 320, 100)
  $g.FillEllipse((New-Object System.Drawing.SolidBrush((ColorFromHex "#5d584c"))), 390, 892, 230, 48)
  $holder.Dispose()
  Draw-Incense $g 505 910 0.9
  Save-Canvas $canvas "category-incense.png"
}

function New-CategoryLight {
  $canvas = New-Canvas 1000 1300 (ColorFromHex "#ece0cc") (ColorFromHex "#8b806f")
  $g = $canvas.Graphics
  Add-Grain $g 1000 1300 950 20
  $beam = New-Object System.Drawing.SolidBrush((ColorFromHex "#f5d78c" 52))
  $g.FillPolygon($beam, @(
    (New-Object System.Drawing.Point(690, 0)),
    (New-Object System.Drawing.Point(1000, 0)),
    (New-Object System.Drawing.Point(1000, 1300)),
    (New-Object System.Drawing.Point(380, 1300))
  ))
  $beam.Dispose()
  Draw-Lamp $g 285 370 390 610
  Save-Canvas $canvas "category-light.png"
}

function New-LifestyleRoom {
  $canvas = New-Canvas 1600 1280 (ColorFromHex "#eee7dc") (ColorFromHex "#958c7a")
  $g = $canvas.Graphics
  Add-Grain $g 1600 1280 1800 18
  $wall = New-Object System.Drawing.SolidBrush((ColorFromHex "#e4dac9"))
  $g.FillRectangle($wall, 0, 0, 1600, 620)
  $wall.Dispose()
  $floor = New-Object System.Drawing.SolidBrush((ColorFromHex "#b8aa96"))
  $g.FillRectangle($floor, 0, 620, 1600, 660)
  $floor.Dispose()
  $shadowPen = New-Object System.Drawing.Pen((ColorFromHex "#736757" 70), 18)
  for ($i = 0; $i -lt 9; $i++) {
    $g.DrawLine($shadowPen, 930 + ($i * 92), 0, 520 + ($i * 92), 1280)
  }
  $shadowPen.Dispose()
  Draw-Linen $g 340 720 830 250 -5 (ColorFromHex "#d4c2aa")
  Draw-Vessel $g 610 430 260 430 (ColorFromHex "#d9d2c4") (ColorFromHex "#f6f0e2")
  Draw-Incense $g 1030 780 0.72
  Draw-Lamp $g 190 310 270 420
  Save-Canvas $canvas "lifestyle-room.png"
}

function New-ProductVessel {
  $canvas = New-Canvas 900 1100 (ColorFromHex "#eee8df") (ColorFromHex "#c0b4a1")
  $g = $canvas.Graphics
  Add-Grain $g 900 1100 700 15
  Add-Shadow $g 260 835 370 78 45
  Draw-Vessel $g 290 250 310 590 (ColorFromHex "#dcd7cc") (ColorFromHex "#fbf7ee")
  Save-Canvas $canvas "product-vessel.png"
}

function New-ProductLinenRunner {
  $canvas = New-Canvas 900 1100 (ColorFromHex "#e8ddcb") (ColorFromHex "#a79c8a")
  $g = $canvas.Graphics
  Add-Grain $g 900 1100 850 20
  Draw-Linen $g 165 150 560 810 -5 (ColorFromHex "#d9c7ad")
  Draw-Linen $g 245 230 400 620 8 (ColorFromHex "#efe3d0")
  Save-Canvas $canvas "product-linen-runner.png"
}

function New-ProductIncenseHolder {
  $canvas = New-Canvas 900 1100 (ColorFromHex "#d8c9b8") (ColorFromHex "#68715b")
  $g = $canvas.Graphics
  Add-Grain $g 900 1100 760 17
  Add-Shadow $g 250 770 395 72 48
  $holder = New-Object System.Drawing.SolidBrush((ColorFromHex "#38352e"))
  $g.FillEllipse($holder, 240, 710, 410, 115)
  $holder.Dispose()
  $top = New-Object System.Drawing.SolidBrush((ColorFromHex "#5d574c"))
  $g.FillEllipse($top, 302, 716, 286, 55)
  $top.Dispose()
  Draw-Incense $g 455 720 0.78
  Save-Canvas $canvas "product-incense-holder.png"
}

function New-ProductStoneLamp {
  $canvas = New-Canvas 900 1100 (ColorFromHex "#eee0ca") (ColorFromHex "#8e846f")
  $g = $canvas.Graphics
  Add-Grain $g 900 1100 750 16
  Draw-Lamp $g 235 265 430 620
  Save-Canvas $canvas "product-stone-lamp.png"
}

New-Hero
New-CategoryCeramics
New-CategoryLinen
New-CategoryIncense
New-CategoryLight
New-LifestyleRoom
New-ProductVessel
New-ProductLinenRunner
New-ProductIncenseHolder
New-ProductStoneLamp

Copy-Item (Join-Path $outDir "category-ceramics.png") (Join-Path $outDir "journal-ceramic.png") -Force
Copy-Item (Join-Path $outDir "category-linen.png") (Join-Path $outDir "journal-linen.png") -Force
Copy-Item (Join-Path $outDir "category-incense.png") (Join-Path $outDir "journal-incense.png") -Force

Write-Host "Generated brand imagery in $outDir"
