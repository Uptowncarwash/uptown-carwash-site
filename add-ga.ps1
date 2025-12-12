# Add Google Analytics to all HTML pages
$gaCode = @"

<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-YRRZRP31SW"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-YRRZRP31SW');
</script>
"@

# Get all HTML files in root (exclude old backup files)
$rootFiles = Get-ChildItem -Path "C:\Users\dlhac\uptown-carwash-site\*.html" | Where-Object { $_.Name -notmatch "^(webpage|Uptown)" }

# Get blog HTML files
$blogFiles = Get-ChildItem -Path "C:\Users\dlhac\uptown-carwash-site\blog\*.html" -ErrorAction SilentlyContinue

$allFiles = @()
$allFiles += $rootFiles
if ($blogFiles) { $allFiles += $blogFiles }

$count = 0

foreach ($file in $allFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    if ($content -notmatch "G-YRRZRP31SW") {
        $newContent = $content -replace "(<head>)", "`$1$gaCode"
        Set-Content -Path $file.FullName -Value $newContent -NoNewline
        Write-Host "Added GA to: $($file.Name)" -ForegroundColor Green
        $count++
    } else {
        Write-Host "Already has GA: $($file.Name)" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "Total files updated: $count" -ForegroundColor Cyan
