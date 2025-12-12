# Comprehensive SEO Audit Script
$sitePath = "C:\Users\dlhac\uptown-carwash-site"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "SEO Audit - Uptown Car Wash" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Get all HTML files (excluding reference files)
$htmlFiles = Get-ChildItem -Path $sitePath -Filter "*.html" | Where-Object { $_.Name -notmatch "^(webpage|Uptown)" }
$blogFiles = Get-ChildItem -Path "$sitePath\blog" -Filter "*.html" -ErrorAction SilentlyContinue

$allFiles = @($htmlFiles) + @($blogFiles)
$issues = @()

foreach ($file in $allFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    $fileName = $file.Name
    $pageIssues = @()

    Write-Host "Checking: $fileName" -ForegroundColor White

    # Check for title tag
    if ($content -notmatch '<title>') {
        $pageIssues += "Missing <title> tag"
    } elseif ($content -match '<title>([^<]+)</title>') {
        $title = $matches[1]
        if ($title.Length -gt 70) {
            $pageIssues += "Title too long ($($title.Length) chars, max 60-70)"
        }
    }

    # Check for meta description
    if ($content -notmatch 'name="description"') {
        $pageIssues += "Missing meta description"
    } elseif ($content -match 'name="description" content="([^"]+)"') {
        $desc = $matches[1]
        if ($desc.Length -gt 170) {
            $pageIssues += "Description too long ($($desc.Length) chars, max 150-160)"
        }
        if ($desc.Length -lt 120) {
            $pageIssues += "Description too short ($($desc.Length) chars, min 120)"
        }
    }

    # Check for canonical URL
    if ($content -notmatch 'rel="canonical"') {
        $pageIssues += "Missing canonical URL"
    }

    # Check for robots meta
    if ($content -notmatch 'name="robots"') {
        $pageIssues += "Missing robots meta tag"
    }

    # Check for Open Graph tags
    if ($content -notmatch 'og:title') {
        $pageIssues += "Missing og:title"
    }
    if ($content -notmatch 'og:description') {
        $pageIssues += "Missing og:description"
    }
    if ($content -notmatch 'og:image') {
        $pageIssues += "Missing og:image"
    }
    if ($content -notmatch 'og:url') {
        $pageIssues += "Missing og:url"
    }

    # Check for Twitter cards
    if ($content -notmatch 'twitter:card') {
        $pageIssues += "Missing Twitter card tags"
    }

    # Check for H1 tag
    if ($content -notmatch '<h1') {
        $pageIssues += "Missing H1 heading"
    }

    # Check for multiple H1 tags
    $h1Count = ([regex]::Matches($content, '<h1')).Count
    if ($h1Count -gt 1) {
        $pageIssues += "Multiple H1 tags ($h1Count found, should be 1)"
    }

    # Check for images without alt text
    $imgMatches = [regex]::Matches($content, '<img[^>]+>')
    foreach ($img in $imgMatches) {
        if ($img.Value -notmatch 'alt=') {
            $pageIssues += "Image missing alt text"
            break
        }
    }

    if ($pageIssues.Count -eq 0) {
        Write-Host "  All SEO elements present" -ForegroundColor Green
    } else {
        foreach ($issue in $pageIssues) {
            Write-Host "  ISSUE: $issue" -ForegroundColor Yellow
            $issues += [PSCustomObject]@{
                File = $fileName
                Issue = $issue
            }
        }
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "SEO Audit Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Total files checked: $($allFiles.Count)" -ForegroundColor White
Write-Host "Total issues found: $($issues.Count)" -ForegroundColor $(if ($issues.Count -eq 0) { "Green" } else { "Yellow" })

if ($issues.Count -gt 0) {
    Write-Host "`nIssues by file:" -ForegroundColor Yellow
    $issues | Group-Object File | ForEach-Object {
        Write-Host "`n$($_.Name):" -ForegroundColor White
        $_.Group | ForEach-Object { Write-Host "  - $($_.Issue)" -ForegroundColor Yellow }
    }
}
