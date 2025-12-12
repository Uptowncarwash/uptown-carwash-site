# Fix logo filename case in all HTML files
$files = Get-ChildItem -Path "C:\Users\dlhac\uptown-carwash-site" -Filter "*.html"

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    if ($content -match 'final_colour\.png') {
        $newContent = $content -replace 'final_colour\.png', 'Final_Colour.png'
        Set-Content -Path $file.FullName -Value $newContent -NoNewline
        Write-Host "Fixed: $($file.Name)" -ForegroundColor Green
    }
}

Write-Host "`nDone! Logo filename case fixed in all files." -ForegroundColor Cyan
