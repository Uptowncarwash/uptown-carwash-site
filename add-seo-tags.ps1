# PowerShell script to add SEO tags to remaining pages
# Run this script from the uptown-carwash-site folder

$pages = @(
    @{
        file = "car-wash-services.html"
        canonical = "https://uptowncarwash.com/car-wash-services.html"
        ogTitle = "Car Wash Services & Pricing | Uptown Car Wash San Diego"
        ogDesc = "Exterior washes from `$15.99, interior cleaning, and premium add-ons. San Diego's best car wash since 1988."
    },
    @{
        file = "gift-cards.html"
        canonical = "https://uptowncarwash.com/gift-cards.html"
        ogTitle = "Gift Cards | Uptown Car Wash San Diego"
        ogDesc = "The perfect gift for any occasion. Uptown Car Wash gift cards available in any amount."
    },
    @{
        file = "memberships.html"
        canonical = "https://uptowncarwash.com/memberships.html"
        ogTitle = "Memberships | Uptown Car Wash San Diego"
        ogDesc = "Join our Unlimited Wash Club or manage your existing membership. Wash as often as you like."
    },
    @{
        file = "free-wash.html"
        canonical = "https://uptowncarwash.com/free-wash.html"
        ogTitle = "Free Wash Offer | Uptown Car Wash San Diego"
        ogDesc = "Get a FREE car wash at Uptown Car Wash San Diego! First-time customers receive a complimentary wash."
    },
    @{
        file = "coatings.html"
        canonical = "https://uptowncarwash.com/coatings.html"
        ogTitle = "Ceramic Coatings | Uptown Car Wash San Diego"
        ogDesc = "Professional ceramic coating services. Long-lasting paint protection, hydrophobic finish, UV protection."
    },
    @{
        file = "headlights.html"
        canonical = "https://uptowncarwash.com/headlights.html"
        ogTitle = "Headlight Restoration | Uptown Car Wash San Diego"
        ogDesc = "Professional headlight restoration. Restore clarity and improve night visibility. Safe, effective, affordable."
    },
    @{
        file = "my-membership.html"
        canonical = "https://uptowncarwash.com/my-membership.html"
        ogTitle = "My Membership | Uptown Car Wash San Diego"
        ogDesc = "Manage your Uptown Car Wash Unlimited Wash Club membership. Update payment, change vehicles, or contact support."
    },
    @{
        file = "privacy.html"
        canonical = "https://uptowncarwash.com/privacy.html"
        ogTitle = "Privacy Policy | Uptown Car Wash San Diego"
        ogDesc = "How we collect, use, and protect your personal information at Uptown Car Wash."
    },
    @{
        file = "terms.html"
        canonical = "https://uptowncarwash.com/terms.html"
        ogTitle = "Unlimited Wash Club Terms | Uptown Car Wash San Diego"
        ogDesc = "Membership agreement, billing, and cancellation policy for the Unlimited Wash Club."
    }
)

foreach ($page in $pages) {
    $filePath = $page.file

    if (Test-Path $filePath) {
        $content = Get-Content $filePath -Raw

        # Build the SEO tags to insert
        $seoTags = @"
  <meta name="robots" content="index, follow">
  <link rel="canonical" href="$($page.canonical)">
  <meta property="og:type" content="website">
  <meta property="og:url" content="$($page.canonical)">
  <meta property="og:title" content="$($page.ogTitle)">
  <meta property="og:description" content="$($page.ogDesc)">
  <meta property="og:image" content="https://uptowncarwash.com/Final_Colour.png">
"@

        # Insert after </title> tag
        $content = $content -replace '(</title>)', "`$1`n$seoTags"

        # Write back
        Set-Content $filePath -Value $content -NoNewline
        Write-Host "Updated: $filePath" -ForegroundColor Green
    } else {
        Write-Host "File not found: $filePath" -ForegroundColor Red
    }
}

Write-Host "`nSEO tags added to all pages!" -ForegroundColor Cyan
