# Create SEO Review Folder - UPDATED
# Includes blog folder and all fixes

$sourcePath = "C:\Users\dlhac\uptown-carwash-site"
$destPath = "C:\Users\dlhac\uptown-carwash-seo-review"

# Remove old folder if exists
if (Test-Path $destPath) {
    Remove-Item -Path $destPath -Recurse -Force
}

# Create destination folders
New-Item -ItemType Directory -Path $destPath | Out-Null
New-Item -ItemType Directory -Path "$destPath\css" | Out-Null
New-Item -ItemType Directory -Path "$destPath\blog" | Out-Null

# Copy all HTML files (root level)
Copy-Item -Path "$sourcePath\*.html" -Destination $destPath -Exclude "webpage*.html", "Uptown*.html"
Write-Host "Copied main HTML files" -ForegroundColor Green

# Copy blog HTML files
Copy-Item -Path "$sourcePath\blog\*.html" -Destination "$destPath\blog\"
Write-Host "Copied blog HTML files" -ForegroundColor Green

# Copy CSS
Copy-Item -Path "$sourcePath\css\styles.css" -Destination "$destPath\css\"
Write-Host "Copied CSS" -ForegroundColor Green

# Copy robots.txt and sitemap.xml
Copy-Item -Path "$sourcePath\robots.txt" -Destination $destPath
Copy-Item -Path "$sourcePath\sitemap.xml" -Destination $destPath
Write-Host "Copied robots.txt and sitemap.xml" -ForegroundColor Green

# Copy images (png, jpg, jpeg, webp, svg)
$imageExtensions = @("*.png", "*.jpg", "*.jpeg", "*.webp", "*.svg", "*.ico")
foreach ($ext in $imageExtensions) {
    $images = Get-ChildItem -Path $sourcePath -Filter $ext -ErrorAction SilentlyContinue
    foreach ($img in $images) {
        Copy-Item -Path $img.FullName -Destination $destPath
    }
}
Write-Host "Copied images" -ForegroundColor Green

# Count files
$fileCount = (Get-ChildItem -Path $destPath -Recurse -File).Count
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "SEO Review folder created!" -ForegroundColor Cyan
Write-Host "Location: $destPath" -ForegroundColor Cyan
Write-Host "Total files: $fileCount" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Contents:" -ForegroundColor Yellow
Write-Host "- Main pages (HTML)" -ForegroundColor White
Write-Host "- Blog folder with 3 posts" -ForegroundColor White
Write-Host "- CSS stylesheet" -ForegroundColor White
Write-Host "- sitemap.xml" -ForegroundColor White
Write-Host "- robots.txt" -ForegroundColor White
Write-Host "- All images" -ForegroundColor White
Write-Host ""
Write-Host "Next: Right-click the folder and select 'Compress to ZIP file'" -ForegroundColor Yellow
