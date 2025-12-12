# Comprehensive Link Audit Script
$sitePath = "C:\Users\dlhac\uptown-carwash-site"
$brokenLinks = @()

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Link Audit - Uptown Car Wash" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Get all HTML files (excluding reference files)
$htmlFiles = Get-ChildItem -Path $sitePath -Filter "*.html" | Where-Object { $_.Name -notmatch "^(webpage|Uptown)" }
$blogFiles = Get-ChildItem -Path "$sitePath\blog" -Filter "*.html" -ErrorAction SilentlyContinue

$allFiles = @($htmlFiles) + @($blogFiles)

foreach ($file in $allFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    $fileDir = Split-Path $file.FullName

    # Find all href attributes (internal links only)
    $matches = [regex]::Matches($content, 'href="([^"#]+)"')

    foreach ($match in $matches) {
        $href = $match.Groups[1].Value

        # Skip external links, mailto, tel
        if ($href -match "^(http|https|mailto:|tel:|/|#)") { continue }

        # Resolve the path
        $targetPath = Join-Path $fileDir $href

        if (-not (Test-Path $targetPath)) {
            $brokenLinks += [PSCustomObject]@{
                File = $file.Name
                BrokenLink = $href
            }
        }
    }
}

if ($brokenLinks.Count -eq 0) {
    Write-Host "All internal links are working!" -ForegroundColor Green
} else {
    Write-Host "BROKEN LINKS FOUND:" -ForegroundColor Red
    $brokenLinks | Format-Table -AutoSize
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Checking specific blog links..." -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Manually check blog links
$blogLinks = @(
    "blog/how-often-should-you-wash-your-car.html",
    "blog/benefits-of-ceramic-coating.html",
    "blog/protect-your-car-from-sun-damage.html"
)

foreach ($link in $blogLinks) {
    $fullPath = Join-Path $sitePath $link
    if (Test-Path $fullPath) {
        Write-Host "  OK: $link" -ForegroundColor Green
    } else {
        Write-Host "  MISSING: $link" -ForegroundColor Red
    }
}

Write-Host "`nAudit complete!" -ForegroundColor Cyan
