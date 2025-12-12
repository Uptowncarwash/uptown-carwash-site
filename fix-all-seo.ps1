# Comprehensive SEO Fix Script for Uptown Car Wash
# This script adds missing SEO elements to all pages

$sitePath = "C:\Users\dlhac\uptown-carwash-site"

# Define all pages with their SEO details
$pages = @{
    "blog.html" = @{
        title = "Car Care Blog | Uptown Car Wash San Diego"
        description = "Expert car care tips, detailing advice, and news from Uptown Car Wash - San Diego's trusted full-service car wash since 1988."
        canonical = "https://uptowncarwash.com/blog.html"
        ogImage = "https://uptowncarwash.com/pexels-photo-6872150.jpeg"
    }
    "my-membership.html" = @{
        title = "My Membership | Uptown Car Wash San Diego"
        description = "Manage your Uptown Car Wash Unlimited Wash Club membership - Update payment, change vehicles, or contact support."
        canonical = "https://uptowncarwash.com/my-membership.html"
        ogImage = "https://uptowncarwash.com/Final_Colour.png"
    }
}

# Function to add missing SEO tags
function Add-MissingSEO {
    param(
        [string]$filePath,
        [hashtable]$seoData
    )

    $content = Get-Content -Path $filePath -Raw
    $modified = $false

    # Add robots meta if missing
    if ($content -notmatch 'name="robots"') {
        $content = $content -replace '(<meta name="description"[^>]+>)', "`$1`n  <meta name=`"robots`" content=`"index, follow`">"
        $modified = $true
        Write-Host "  Added robots meta" -ForegroundColor Yellow
    }

    # Add canonical if missing
    if ($content -notmatch 'rel="canonical"') {
        $canonical = $seoData.canonical
        $content = $content -replace '(<meta name="robots"[^>]+>)', "`$1`n  <link rel=`"canonical`" href=`"$canonical`">"
        $modified = $true
        Write-Host "  Added canonical URL" -ForegroundColor Yellow
    }

    # Add og:image if missing
    if ($content -notmatch 'og:image') {
        $ogImage = $seoData.ogImage
        $content = $content -replace '(<meta property="og:url"[^>]+>)', "`$1`n  <meta property=`"og:image`" content=`"$ogImage`">"
        $modified = $true
        Write-Host "  Added og:image" -ForegroundColor Yellow
    }

    # Add Twitter card meta tags if missing
    if ($content -notmatch 'twitter:card') {
        $title = $seoData.title
        $description = $seoData.description
        $twitterTags = @"

  <!-- Twitter Card -->
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="$title">
  <meta name="twitter:description" content="$description">
"@
        # Insert before </head>
        $content = $content -replace '(</head>)', "$twitterTags`n`$1"
        $modified = $true
        Write-Host "  Added Twitter card tags" -ForegroundColor Yellow
    }

    if ($modified) {
        Set-Content -Path $filePath -Value $content -NoNewline
        return $true
    }
    return $false
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "SEO Fix Script - Uptown Car Wash" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

$fixedCount = 0

foreach ($page in $pages.Keys) {
    $filePath = Join-Path $sitePath $page
    if (Test-Path $filePath) {
        Write-Host "Processing: $page" -ForegroundColor White
        if (Add-MissingSEO -filePath $filePath -seoData $pages[$page]) {
            $fixedCount++
            Write-Host "  UPDATED" -ForegroundColor Green
        } else {
            Write-Host "  Already complete" -ForegroundColor Gray
        }
    } else {
        Write-Host "File not found: $page" -ForegroundColor Red
    }
}

# Now add Twitter cards to all pages that already have other SEO but missing Twitter
$allPages = @(
    "index.html", "about.html", "car-wash-services.html", "detailing-services.html",
    "unlimited-wash.html", "contact.html", "gift-cards.html", "memberships.html",
    "free-wash.html", "coatings.html", "headlights.html", "privacy.html", "terms.html"
)

Write-Host "`nAdding Twitter cards to remaining pages..." -ForegroundColor Cyan

foreach ($page in $allPages) {
    $filePath = Join-Path $sitePath $page
    if (Test-Path $filePath) {
        $content = Get-Content -Path $filePath -Raw

        if ($content -notmatch 'twitter:card') {
            # Extract existing title and description
            if ($content -match '<title>([^<]+)</title>') {
                $title = $matches[1]
            }
            if ($content -match '<meta name="description" content="([^"]+)"') {
                $description = $matches[1]
            }

            $twitterTags = @"

  <!-- Twitter Card -->
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="$title">
  <meta name="twitter:description" content="$description">
"@
            $content = $content -replace '(</head>)', "$twitterTags`n`$1"
            Set-Content -Path $filePath -Value $content -NoNewline
            Write-Host "  $page - Added Twitter cards" -ForegroundColor Green
            $fixedCount++
        } else {
            Write-Host "  $page - Already has Twitter cards" -ForegroundColor Gray
        }
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Completed! Fixed $fixedCount pages" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan
