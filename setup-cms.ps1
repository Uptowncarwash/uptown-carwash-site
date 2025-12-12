# ============================================================
# UPTOWN CAR WASH - FULL CMS SETUP SCRIPT
# Run this once: powershell -ExecutionPolicy Bypass -File setup-cms.ps1
# ============================================================

Write-Host "Setting up Decap CMS for Uptown Car Wash..." -ForegroundColor Cyan

# Create directories
$dirs = @(
    "src/_data/pages",
    "src/_includes/layouts",
    "src/_includes/partials",
    "src/pages",
    "images/uploads"
)
foreach ($dir in $dirs) {
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
}
Write-Host "Created directories" -ForegroundColor Green

# ============================================================
# DATA FILES
# ============================================================

# Settings
@'
{
  "business_name": "Uptown Car Wash & Detail Center",
  "phone": "(619) 297-9274",
  "phone_link": "+16192979274",
  "email": "uptowncarwashsd@gmail.com",
  "address": "4157 Normal St",
  "city_state_zip": "San Diego, CA 92103",
  "full_address": "4157 Normal St, San Diego, CA 92103",
  "hours": {
    "summer": {"label": "Summer (Mar-Nov)", "mon_sat": "8 AM - 6 PM", "sunday": "9 AM - 6 PM"},
    "winter": {"label": "Winter (Nov-Mar)", "mon_sat": "8 AM - 5 PM", "sunday": "9 AM - 5 PM"}
  },
  "holidays_closed": "Thanksgiving, Christmas, and New Year's Day",
  "maps_url": "https://www.google.com/maps/search/?api=1&query=Uptown+Car+Wash+4157+Normal+St+San+Diego+CA+92103",
  "year_established": "1988",
  "formsubmit_email": "uptowncarwashsd@gmail.com"
}
'@ | Out-File -FilePath "src/_data/settings.json" -Encoding UTF8

# Memberships
@'
{
  "intro": {
    "title": "Unlimited Wash Club",
    "subtitle": "Wash as often as you like!",
    "benefits": [
      {"icon": "50%", "title": "Half Off First Month", "desc": "Save 50% on your first month's membership"},
      {"icon": "∞", "title": "Unlimited Washes", "desc": "Wash as often as you like, every day if you want"},
      {"icon": "✓", "title": "No Contract", "desc": "Cancel anytime, no long-term commitment"},
      {"icon": "10%", "title": "Detailing Discount", "desc": "Members save 10% on all detailing services"}
    ]
  },
  "plans": [
    {
      "name": "Plan #1",
      "price": "$59.99",
      "first_month": "$29.99",
      "featured": true,
      "badge": "BEST VALUE",
      "features": ["Prep Wash", "Soft Foam Wash", "Air Dry + Hand Towel Drying", "Tri Foam Polish", "Ceramic Wax", "Wheel Cleaner", "Tire Shine", "Express Touch Discount", "10% Detailing Discount", "Hand-Applied Graphene Spray Wax"],
      "stripe_link": ""
    },
    {
      "name": "Plan #2",
      "price": "$49.99",
      "first_month": "$24.99",
      "featured": false,
      "features": ["Prep Wash", "Soft Foam Wash", "Air Dry + Hand Towel Drying", "Tri Foam Polish", "Ceramic Wax", "Wheel Cleaner", "Tire Shine", "Express Touch Discount", "10% Detailing Discount", "Hand-Applied Carnauba Spray Wax"],
      "stripe_link": ""
    },
    {
      "name": "Plan #3",
      "price": "$39.99",
      "first_month": "$19.99",
      "featured": false,
      "features": ["Prep Wash", "Soft Foam Wash", "Air Dry + Hand Towel Drying", "Tri Foam Polish", "Ceramic Wax", "Wheel Cleaner", "Tire Shine", "10% Detailing Discount"],
      "stripe_link": ""
    },
    {
      "name": "Plan #4",
      "price": "$29.99",
      "first_month": "$14.99",
      "featured": false,
      "features": ["Prep Wash", "Soft Foam Wash", "Air Dry + Hand Towel Drying", "Tri Foam Polish", "Ceramic Wax"],
      "stripe_link": ""
    }
  ],
  "how_it_works": [
    {"step": 1, "title": "Sign Up", "desc": "Choose your plan and sign up in person or online"},
    {"step": 2, "title": "Get Your Tag", "desc": "Receive your windshield RFID tag for automatic recognition"},
    {"step": 3, "title": "Drive Through", "desc": "Just drive up and we'll recognize your vehicle automatically"},
    {"step": 4, "title": "Enjoy!", "desc": "Wash as often as you like with no additional cost"}
  ]
}
'@ | Out-File -FilePath "src/_data/memberships.json" -Encoding UTF8

# Car Wash Pricing
@'
{
  "title": "Car Wash Services",
  "subtitle": "Express exterior and full-service options",
  "express": [
    {"name": "Wash #1", "price": "$25.99", "features": ["Prep Wash", "Auto Wash", "Towel Dry", "Triple Foam", "Sealant Protectant", "Rim Cleaner", "Tire Shine", "Air Freshener", "Graphene Hand Wax"]},
    {"name": "Wash #2", "price": "$22.99", "features": ["Prep Wash", "Auto Wash", "Towel Dry", "Triple Foam", "Sealant Protectant", "Rim Cleaner", "Tire Shine", "Air Freshener", "Carnauba Hand Wax"]},
    {"name": "Wash #3", "price": "$20.99", "features": ["Prep Wash", "Auto Wash", "Towel Dry", "Triple Foam", "Sealant Protectant", "Rim Cleaner", "Tire Shine"]},
    {"name": "Wash #4", "price": "$15.99", "features": ["Prep Wash", "Auto Wash", "Towel Dry", "Triple Foam", "Sealant Protectant"]},
    {"name": "Wash #5", "price": "$11.99", "features": ["Prep Wash", "Auto Wash", "Towel Dry"]}
  ]
}
'@ | Out-File -FilePath "src/_data/carwash.json" -Encoding UTF8

# Home page
@'
{
  "hero": {
    "title": "Welcome to Uptown Car Wash",
    "subtitle": "San Diego's Premier Full-Service Car Wash Since 1988"
  },
  "who_we_are": {
    "label": "WHO WE ARE",
    "title": "We are Uptown Car Wash",
    "text1": "Uptown Car Wash & Detail Center is a locally owned, family-operated business proudly serving San Diego since 1988. As one of the last true full-service car washes in San Diego—and an award-winning one—we combine modern hybrid wash technology with hands-on expertise.",
    "text2": "Our experienced team, including staff with 20+ years of service and a General Manager with 40+ years in the industry, delivers expert-level care for every vehicle."
  },
  "services": [
    {"title": "Drive-Through Express", "desc": "Quick, quality exterior wash", "image": "Uptown Carwash _ Full-Service Car Detailers1_files/drive-through-touchless-car-wash.png", "link": "car-wash-services.html"},
    {"title": "Full-Service Detailing", "desc": "Complete interior & exterior care", "image": "Uptown Carwash _ Full-Service Car Detailers1_files/inside-outside-detailing.png", "link": "detailing-services.html"},
    {"title": "Large Vehicle Washes", "desc": "Trucks, SUVs, and oversized vehicles", "image": "Uptown Carwash _ Full-Service Car Detailers1_files/large-vehicle-washes.png", "link": "car-wash-services.html"},
    {"title": "Unlimited Wash Club", "desc": "Wash as often as you like", "image": "Uptown Carwash _ Full-Service Car Detailers1_files/unlimited-car-wash-club-subscription.jpg", "link": "unlimited-wash.html"}
  ]
}
'@ | Out-File -FilePath "src/_data/pages/home.json" -Encoding UTF8

# About page
@'
{
  "title": "About Us",
  "subtitle": "Family-owned and operated since 1988",
  "our_story": {
    "heading": "Our Story",
    "paragraphs": [
      "Uptown Car Wash & Detail Center is a locally owned, family-operated business proudly serving San Diego since 1988. For more than 35 years, we've remained committed to delivering exceptional service, quality care, and a superior clean for every vehicle that comes through our doors.",
      "As one of the last true full-service car washes in San Diego—and an award-winning one—we continue to uphold the tradition of hands-on service. Many of our team members have been with us for over 20 years, and our General Manager brings 40+ years of industry experience, ensuring every customer receives expert-level attention and care."
    ]
  },
  "hybrid_wash": {
    "heading": "A Modern Hybrid Wash Experience",
    "intro": "In 2021, we upgraded our facility with state-of-the-art, eco-conscious equipment designed to provide the safest and most effective wash possible. Our hybrid system combines:",
    "features": [
      "Touchless high-pressure water for gentle, precise cleaning",
      "Soft neoprene, high-density foam brushes that won't hold dirt or grit",
      "A rich foam bath using eco-friendly, non-caustic soaps",
      "Dual drying with high-power blowers plus hand towel drying"
    ],
    "conclusion": "This unique approach delivers a deeper clean while protecting your paint, finish, and overall vehicle condition."
  },
  "services": {
    "express": {"heading": "Express Exterior Services", "items": ["Drive-through exterior wash", "Triple-foam polish", "Ceramic and graphene spray protectants", "Tire shine & wheel cleaning", "Spot-free rinse and air dry, towel dry with microfiber towels by hand"]},
    "full_service": {"heading": "Full-Service Washes", "items": ["Interior vacuuming of floors and seats", "Window cleaning inside and out", "Dusting of the dashboard and center console", "Door-jamb wiping", "Hand towel drying with soft microfiber towels"]},
    "detailing": {"heading": "Professional Detailing Services", "items": ["Full interior & exterior detailing", "Paint correction", "Clay bar treatments", "Machine polishing & waxing", "Ceramic coatings", "Graphene coatings", "Carpet & upholstery shampooing", "Leather cleaning, restoration & conditioning", "Deep interior detailing"]}
  },
  "differentiators": {
    "heading": "What Sets Us Apart",
    "items": ["Family-owned and operated for 35+ years", "Award-winning customer service", "One of San Diego's last full-service car washes", "Hybrid wash system with touchless and soft-foam technology", "Eco-friendly, non-caustic cleaning products", "Experienced staff with decades of combined expertise", "Specialized care for all vehicle types, finishes, and interiors"]
  },
  "images": [
    {"src": "uptown-building-1.jpg", "alt": "Uptown Car Wash San Diego - Street View"},
    {"src": "uptown-building-2.jpg", "alt": "Uptown Car Wash Mural and Entrance"},
    {"src": "uptown-building-3.jpg", "alt": "Uptown Car Wash Building and Wash Bay"}
  ]
}
'@ | Out-File -FilePath "src/_data/pages/about.json" -Encoding UTF8

# Free wash page
@'
{
  "title": "FREE CAR WASH!",
  "subtitle": "First-time customers get a complimentary wash",
  "wash_name": "#3 Express Wash",
  "wash_value": "$20.99",
  "redeem_steps": [
    "Fill out the form below with your information",
    "Show this page on your phone when you arrive",
    "Enjoy your free #3 Express Wash ($20.99 value)"
  ],
  "features": ["Prep Wash", "Auto Wash", "Towel Dry", "Triple Foam", "Sealant Protectant", "Rim Cleaner", "Tire Shine"]
}
'@ | Out-File -FilePath "src/_data/pages/free_wash.json" -Encoding UTF8

# Contact page
@'
{
  "title": "Contact Us",
  "subtitle": "We'd love to hear from you",
  "form_heading": "Send Us a Message"
}
'@ | Out-File -FilePath "src/_data/pages/contact.json" -Encoding UTF8

Write-Host "Created data files" -ForegroundColor Green

# ============================================================
# ELEVENTY CONFIG
# ============================================================

@'
const fs = require("fs");

module.exports = function(eleventyConfig) {
  // Pass through static files
  eleventyConfig.addPassthroughCopy("css");
  eleventyConfig.addPassthroughCopy("images");
  eleventyConfig.addPassthroughCopy("admin");
  eleventyConfig.addPassthroughCopy("*.png");
  eleventyConfig.addPassthroughCopy("*.jpg");
  eleventyConfig.addPassthroughCopy("*.jpeg");
  eleventyConfig.addPassthroughCopy("*.svg");
  eleventyConfig.addPassthroughCopy("Uptown Carwash _ Full-Service Car Detailers1_files");
  eleventyConfig.addPassthroughCopy("robots.txt");
  eleventyConfig.addPassthroughCopy("sitemap.xml");

  // Watch for changes
  eleventyConfig.addWatchTarget("./src/_data/");

  // Date filter
  eleventyConfig.addFilter("dateFormat", (date) => {
    return new Date(date).toLocaleDateString('en-US', {year: 'numeric', month: 'long', day: 'numeric'});
  });

  // Markdown filter
  eleventyConfig.addFilter("markdown", (content) => {
    const md = require("markdown-it")();
    return md.render(content || "");
  });

  return {
    dir: {
      input: "src",
      output: "_site",
      includes: "_includes",
      data: "_data"
    },
    templateFormats: ["njk", "md", "html"],
    htmlTemplateEngine: "njk",
    markdownTemplateEngine: "njk"
  };
};
'@ | Out-File -FilePath ".eleventy.js" -Encoding UTF8

Write-Host "Updated Eleventy config" -ForegroundColor Green

# ============================================================
# BASE LAYOUT
# ============================================================

@'
<!DOCTYPE html>
<html lang="en">
<head>
<script async src="https://www.googletagmanager.com/gtag/js?id=G-YRRZRP31SW"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-YRRZRP31SW');
</script>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="{{ description or 'Uptown Car Wash San Diego - Full service car wash and detailing since 1988.' }}">
  <meta name="robots" content="index, follow">
  <title>{{ title }} | Uptown Car Wash San Diego</title>
  <link rel="canonical" href="https://uptowncarwashsandiego.com/{{ page.url }}">
  <meta property="og:type" content="website">
  <meta property="og:url" content="https://uptowncarwashsandiego.com/{{ page.url }}">
  <meta property="og:title" content="{{ title }} | Uptown Car Wash San Diego">
  <meta property="og:description" content="{{ description or 'San Diego full-service car wash since 1988.' }}">
  <meta property="og:image" content="https://uptowncarwashsandiego.com/Final_Colour.png">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="/css/styles.css">
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="{{ title }} | Uptown Car Wash San Diego">
  <meta name="twitter:description" content="{{ description or 'San Diego full-service car wash since 1988.' }}">
</head>
<body>
  <header class="header">
    <div class="container header-inner">
      <a href="/" class="logo">
        <img src="/Final_Colour.png" alt="Uptown Car Wash San Diego" class="logo-large">
      </a>
      <button class="mobile-menu-btn" aria-label="Toggle menu" aria-expanded="false">
        <span class="hamburger"></span>
      </button>
      <nav class="nav">
        <ul class="nav-list">
          <li class="nav-item"><a href="/about/">ABOUT</a></li>
          <li class="nav-item"><a href="/car-wash-services/">CAR WASH</a></li>
          <li class="nav-item"><a href="/detailing-services/">DETAILING</a></li>
          <li class="nav-item"><a href="/gift-cards/">GIFT CARDS</a></li>
          <li class="nav-item"><a href="/unlimited-wash/">WASH CLUB</a></li>
          <li class="nav-item"><a href="/memberships/">MEMBERSHIPS</a></li>
          <li class="nav-item"><a href="/blog/">BLOG</a></li>
          <li class="nav-item"><a href="/contact/">CONTACT</a></li>
        </ul>
      </nav>
      <a href="/free-wash/" class="btn btn-primary header-cta">FREE WASH</a>
    </div>
  </header>

  <main>
    {{ content | safe }}
  </main>

  <footer class="footer">
    <div class="container">
      <p>&copy; {{ settings.year_established }} - 2025 Uptown Car Wash San Diego. All rights reserved.</p>
      <div class="footer-links">
        <a href="/privacy/">Privacy</a>
        <a href="/terms/">Terms</a>
        <a href="/contact/">Contact</a>
      </div>
    </div>
  </footer>

  <script>
    const menuBtn = document.querySelector('.mobile-menu-btn');
    const nav = document.querySelector('.nav');
    if(menuBtn) {
      menuBtn.addEventListener('click', () => {
        nav.classList.toggle('nav-open');
        menuBtn.classList.toggle('active');
      });
    }
  </script>
</body>
</html>
'@ | Out-File -FilePath "src/_includes/layouts/base.njk" -Encoding UTF8

Write-Host "Created base layout" -ForegroundColor Green

# ============================================================
# PAGE TEMPLATES
# ============================================================

# Homepage
@'
---
layout: layouts/base.njk
title: Full Service Car Wash & Detailing
description: Uptown Car Wash San Diego - Full service car wash and detailing since 1988. Award-winning service at 4157 Normal St.
permalink: /
---
{% set home = pages.home %}

<!-- Hero Slideshow -->
<section class="hero-slideshow">
  <div class="slides">
    <div class="slide active" style="background-image: url('/pexels-photo-170811.jpeg')"></div>
    <div class="slide" style="background-image: url('/pexels-photo-193999.jpeg')"></div>
    <div class="slide" style="background-image: url('/pexels-photo-6872150.jpeg')"></div>
  </div>
  <div class="hero-content">
    <div class="container">
      <h1>{{ home.hero.title }}</h1>
      <p>{{ home.hero.subtitle }}</p>
      <div class="hero-buttons">
        <a href="/car-wash-services/" class="btn btn-primary">OUR SERVICES</a>
        <a href="{{ settings.maps_url }}" class="btn btn-secondary" target="_blank">GET DIRECTIONS</a>
      </div>
    </div>
  </div>
</section>

<!-- Awards -->
<section class="awards-area">
  <div class="container">
    <h3 class="awards-title">Awards & Achievements</h3>
    <div class="awards-grid">
      <div class="single-award"><img alt="best carwash award" src="/Uptown Carwash _ Full-Service Car Detailers1_files/best-car-wash-award-1.png"></div>
      <div class="single-award"><img alt="best car wash award" src="/Uptown Carwash _ Full-Service Car Detailers1_files/best-car-wash-award-2.png"></div>
      <div class="single-award"><img alt="best carwash award" src="/Uptown Carwash _ Full-Service Car Detailers1_files/best-car-wash-award-3.png"></div>
      <div class="single-award"><img alt="best car wash award" src="/Uptown Carwash _ Full-Service Car Detailers1_files/best-car-wash-award-4.png"></div>
      <div class="single-award"><img alt="best carwash award" src="/Uptown Carwash _ Full-Service Car Detailers1_files/best-car-wash-award-5.png"></div>
      <div class="single-award"><img alt="best carwash award" src="/Uptown Carwash _ Full-Service Car Detailers1_files/best-car-wash-2020-award-1.png"></div>
      <div class="single-award"><img alt="best carwash award" src="/Uptown Carwash _ Full-Service Car Detailers1_files/best-car-wash-2020-award-2.png"></div>
      <div class="single-award"><img alt="best carwash award" src="/Uptown Carwash _ Full-Service Car Detailers1_files/uptown-24.png"></div>
    </div>
  </div>
</section>

<!-- Google Reviews Widget -->
<section class="reviews-section">
  <div class="container">
    <script src="https://static.elfsight.com/platform/platform.js" async></script>
    <div class="elfsight-app-3d9cc516-3b6d-427e-a6c1-60c2381e559e" data-elfsight-app-lazy></div>
  </div>
</section>

<!-- Who We Are -->
<section class="who-we-are-area">
  <div class="container">
    <div class="who-we-are-grid">
      <div class="who-we-are-content">
        <p class="section-label">{{ home.who_we_are.label }}</p>
        <h2>{{ home.who_we_are.title }}</h2>
        <p>{{ home.who_we_are.text1 }}</p>
        <p>{{ home.who_we_are.text2 }}</p>
        <a href="/about/" class="btn btn-secondary">Learn More About Us</a>
      </div>
      <div class="who-we-are-photos">
        <img src="/pexels-photo-6872150.jpeg" alt="Professional Car Wash Service">
        <img src="/istockphoto-2220731732-612x612.jpg" alt="Car Wash in Action">
        <img src="/istockphoto-2220731979-612x612.jpg" alt="Quality Car Detailing">
      </div>
    </div>
  </div>
</section>

<!-- Services -->
<section class="services-area">
  <div class="container">
    <h2 class="services-title">Top Services</h2>
    <div class="services-grid">
      {% for service in home.services %}
      <a href="/{{ service.link }}" class="service-card">
        <img src="/{{ service.image }}" alt="{{ service.title }}">
        <h3>{{ service.title }}</h3>
        <p>{{ service.desc }}</p>
      </a>
      {% endfor %}
    </div>
  </div>
</section>

<!-- Contact -->
<section class="contact-area">
  <div class="container">
    <div class="contact-grid">
      <div class="contact-info">
        <h2>CONTACT US</h2>
        <div class="contact-item">
          <img src="/Uptown Carwash _ Full-Service Car Detailers1_files/call-icon.svg" alt="Phone">
          <a href="tel:{{ settings.phone_link }}">{{ settings.phone }}</a>
        </div>
        <div class="contact-item">
          <img src="/Uptown Carwash _ Full-Service Car Detailers1_files/mail-icon.svg" alt="Email">
          <a href="mailto:{{ settings.email }}">{{ settings.email }}</a>
        </div>
        <div class="contact-item">
          <img src="/Uptown Carwash _ Full-Service Car Detailers1_files/map-icon.svg" alt="Address">
          <address>{{ settings.full_address }}</address>
        </div>
        <div class="contact-hours">
          <p><strong>Monday to Saturday:</strong> {{ settings.hours.summer.mon_sat }}</p>
          <p><strong>Sunday:</strong> {{ settings.hours.summer.sunday }}</p>
          <p class="holidays-label">Holidays Closed:</p>
          <p>{{ settings.holidays_closed }}</p>
        </div>
        <form class="contact-form" action="https://formsubmit.co/{{ settings.formsubmit_email }}" method="POST">
          <input type="hidden" name="_subject" value="New Contact Form (Homepage) - Uptown Car Wash">
          <input type="hidden" name="_captcha" value="false">
          <input type="text" name="name" placeholder="Name" required>
          <input type="email" name="email" placeholder="Email" required>
          <input type="tel" name="phone" placeholder="Phone">
          <textarea name="message" placeholder="Message" rows="4" required></textarea>
          <button type="submit" class="btn btn-primary">SEND MESSAGE</button>
        </form>
      </div>
      <div class="contact-map directions-cta">
        <div class="directions-content">
          <h3>Visit Us</h3>
          <p class="directions-address">{{ settings.address }}<br>{{ settings.city_state_zip }}</p>
          <a href="{{ settings.maps_url }}" class="btn btn-primary btn-large" target="_blank" rel="noopener">GET DIRECTIONS</a>
        </div>
      </div>
    </div>
  </div>
</section>
'@ | Out-File -FilePath "src/pages/index.njk" -Encoding UTF8

# About page
@'
---
layout: layouts/base.njk
title: About Us
description: About Uptown Car Wash San Diego - Family-owned since 1988. Learn about our history, mission, and commitment to quality car wash and detailing services.
permalink: /about/
---
{% set about = pages.about %}

<section class="page-hero">
  <div class="container">
    <h1>{{ about.title }}</h1>
    <p>{{ about.subtitle }}</p>
  </div>
</section>

<section class="about-content">
  <div class="container">
    <div class="about-grid">
      <div class="about-text">
        <h2>{{ about.our_story.heading }}</h2>
        {% for p in about.our_story.paragraphs %}
        <p>{{ p | safe }}</p>
        {% endfor %}

        <h3>{{ about.hybrid_wash.heading }}</h3>
        <p>{{ about.hybrid_wash.intro }}</p>
        <ul class="about-services-list">
          {% for feature in about.hybrid_wash.features %}
          <li>{{ feature }}</li>
          {% endfor %}
        </ul>
        <p>{{ about.hybrid_wash.conclusion }}</p>

        <h3>Our Services</h3>
        <h4>{{ about.services.express.heading }}</h4>
        <ul class="about-services-list">
          {% for item in about.services.express.items %}<li>{{ item }}</li>{% endfor %}
        </ul>
        <h4>{{ about.services.full_service.heading }}</h4>
        <ul class="about-services-list">
          {% for item in about.services.full_service.items %}<li>{{ item }}</li>{% endfor %}
        </ul>
        <h4>{{ about.services.detailing.heading }}</h4>
        <ul class="about-services-list">
          {% for item in about.services.detailing.items %}<li>{{ item }}</li>{% endfor %}
        </ul>

        <h3>{{ about.differentiators.heading }}</h3>
        <ul class="about-services-list">
          {% for item in about.differentiators.items %}<li>{{ item }}</li>{% endfor %}
        </ul>
      </div>
      <div class="about-images">
        {% for img in about.images %}
        <img src="/{{ img.src }}" alt="{{ img.alt }}">
        {% endfor %}
      </div>
    </div>
  </div>
</section>

<section class="awards-area">
  <div class="container">
    <h3 class="awards-title">Awards & Achievements</h3>
    <div class="awards-grid">
      <div class="single-award"><img alt="best carwash award" src="/Uptown Carwash _ Full-Service Car Detailers1_files/best-car-wash-award-1.png"></div>
      <div class="single-award"><img alt="best car wash award" src="/Uptown Carwash _ Full-Service Car Detailers1_files/best-car-wash-award-2.png"></div>
      <div class="single-award"><img alt="best carwash award" src="/Uptown Carwash _ Full-Service Car Detailers1_files/best-car-wash-award-3.png"></div>
      <div class="single-award"><img alt="best car wash award" src="/Uptown Carwash _ Full-Service Car Detailers1_files/best-car-wash-award-4.png"></div>
      <div class="single-award"><img alt="best carwash award" src="/Uptown Carwash _ Full-Service Car Detailers1_files/best-car-wash-award-5.png"></div>
      <div class="single-award"><img alt="best carwash award" src="/Uptown Carwash _ Full-Service Car Detailers1_files/best-car-wash-2020-award-1.png"></div>
      <div class="single-award"><img alt="best carwash award" src="/Uptown Carwash _ Full-Service Car Detailers1_files/best-car-wash-2020-award-2.png"></div>
      <div class="single-award"><img alt="best carwash award" src="/Uptown Carwash _ Full-Service Car Detailers1_files/uptown-24.png"></div>
    </div>
  </div>
</section>

<section class="cta-area">
  <div class="container">
    <h2>Ready for a Sparkling Clean Car?</h2>
    <p>Visit us today or sign up for our Unlimited Wash Club</p>
    <div class="cta-buttons">
      <a href="{{ settings.maps_url }}" class="btn btn-primary" target="_blank">GET DIRECTIONS</a>
      <a href="/unlimited-wash/" class="btn btn-secondary">JOIN WASH CLUB</a>
    </div>
  </div>
</section>
'@ | Out-File -FilePath "src/pages/about.njk" -Encoding UTF8

# Unlimited Wash page
@'
---
layout: layouts/base.njk
title: Unlimited Wash Club
description: Uptown Car Wash Unlimited Wash Club - Wash as often as you like from $29.99/month. Half off your first month. No long-term contract.
permalink: /unlimited-wash/
---

<section class="page-hero">
  <div class="container">
    <h1>{{ memberships.intro.title }}</h1>
    <p>{{ memberships.intro.subtitle }}</p>
  </div>
</section>

<section class="benefits-section">
  <div class="container">
    <div class="benefits-grid">
      {% for benefit in memberships.intro.benefits %}
      <div class="benefit-item">
        <div class="benefit-icon">{{ benefit.icon | safe }}</div>
        <h3>{{ benefit.title }}</h3>
        <p>{{ benefit.desc }}</p>
      </div>
      {% endfor %}
    </div>
  </div>
</section>

<section class="services-pricing">
  <div class="container">
    <h2>Choose Your Plan</h2>
    <div class="pricing-grid membership-grid">
      {% for plan in memberships.plans %}
      <div class="pricing-card{% if plan.featured %} featured{% endif %}">
        {% if plan.badge %}<div class="pricing-badge">{{ plan.badge }}</div>{% endif %}
        <h3>{{ plan.name }}</h3>
        <div class="price">{{ plan.price }}<span>/mo</span></div>
        <div class="first-month">First month: {{ plan.first_month }}</div>
        <ul class="pricing-features">
          {% for feature in plan.features %}
          <li>{{ feature }}</li>
          {% endfor %}
        </ul>
        {% if plan.stripe_link %}
        <a href="{{ plan.stripe_link }}" class="btn {% if plan.featured %}btn-primary{% else %}btn-secondary{% endif %}">SIGN UP</a>
        {% else %}
        <a href="/contact/" class="btn {% if plan.featured %}btn-primary{% else %}btn-secondary{% endif %}">SIGN UP</a>
        {% endif %}
      </div>
      {% endfor %}
    </div>
  </div>
</section>

<section class="how-it-works">
  <div class="container">
    <h2>How It Works</h2>
    <div class="steps-grid">
      {% for step in memberships.how_it_works %}
      <div class="step">
        <div class="step-number">{{ step.step }}</div>
        <h3>{{ step.title }}</h3>
        <p>{{ step.desc }}</p>
      </div>
      {% endfor %}
    </div>
  </div>
</section>

<section class="cta-area">
  <div class="container">
    <h2>Ready to Join?</h2>
    <p>Stop by today to sign up for your Unlimited Wash Club membership</p>
    <div class="cta-buttons">
      <a href="{{ settings.maps_url }}" class="btn btn-primary" target="_blank">GET DIRECTIONS</a>
      <a href="tel:{{ settings.phone_link }}" class="btn btn-secondary">CALL {{ settings.phone }}</a>
    </div>
  </div>
</section>
'@ | Out-File -FilePath "src/pages/unlimited-wash.njk" -Encoding UTF8

# Free Wash page
@'
---
layout: layouts/base.njk
title: Free Wash Offer
description: Get a FREE car wash at Uptown Car Wash San Diego! First-time customers receive a complimentary wash.
permalink: /free-wash/
---
{% set fw = pages.free_wash %}

<section class="page-hero">
  <div class="container">
    <h1>{{ fw.title }}</h1>
    <p>{{ fw.subtitle }}</p>
  </div>
</section>

<section class="free-wash-section">
  <div class="container">
    <div class="free-wash-card">
      <div class="free-wash-details">
        <h2>How to Redeem</h2>
        <ol class="redeem-steps">
          {% for step in fw.redeem_steps %}
          <li>{{ step }}</li>
          {% endfor %}
        </ol>
        <div class="offer-details">
          <p><strong>Offer includes:</strong></p>
          <ul>
            {% for feature in fw.features %}
            <li>{{ feature }}</li>
            {% endfor %}
          </ul>
        </div>
      </div>

      <form class="free-wash-form" action="https://formsubmit.co/{{ settings.formsubmit_email }}" method="POST">
        <input type="hidden" name="_subject" value="New FREE WASH Signup - Uptown Car Wash">
        <input type="hidden" name="_captcha" value="false">
        <h3>Claim Your Free Wash</h3>
        <div class="form-row">
          <div class="form-group">
            <label for="firstName">First Name *</label>
            <input type="text" id="firstName" name="firstName" required>
          </div>
          <div class="form-group">
            <label for="lastName">Last Name *</label>
            <input type="text" id="lastName" name="lastName" required>
          </div>
        </div>
        <div class="form-group">
          <label for="email">Email *</label>
          <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
          <label for="phone">Phone</label>
          <input type="tel" id="phone" name="phone">
        </div>
        <button type="submit" class="btn btn-primary btn-block">CLAIM FREE WASH</button>
        <p class="form-note">* First-time customers only. One per household.</p>
      </form>
    </div>
  </div>
</section>

<section class="cta-area">
  <div class="container">
    <h2>Find Us</h2>
    <p>{{ settings.full_address }}</p>
    <a href="{{ settings.maps_url }}" class="btn btn-primary" target="_blank">GET DIRECTIONS</a>
  </div>
</section>
'@ | Out-File -FilePath "src/pages/free-wash.njk" -Encoding UTF8

# Contact page
@'
---
layout: layouts/base.njk
title: Contact Us
description: Contact Uptown Car Wash San Diego - Call (619) 297-9274 or visit us at 4157 Normal St.
permalink: /contact/
---

<section class="page-hero">
  <div class="container">
    <h1>Contact Us</h1>
    <p>We'd love to hear from you</p>
  </div>
</section>

<section class="contact-page-content">
  <div class="container">
    <div class="contact-page-grid">
      <div class="contact-details">
        <h2>Get in Touch</h2>
        <div class="contact-item">
          <img src="/Uptown Carwash _ Full-Service Car Detailers1_files/call-icon.svg" alt="Phone">
          <div>
            <strong>Phone</strong>
            <a href="tel:{{ settings.phone_link }}">{{ settings.phone }}</a>
          </div>
        </div>
        <div class="contact-item">
          <img src="/Uptown Carwash _ Full-Service Car Detailers1_files/mail-icon.svg" alt="Email">
          <div>
            <strong>Email</strong>
            <a href="mailto:{{ settings.email }}">{{ settings.email }}</a>
          </div>
        </div>
        <div class="contact-item">
          <img src="/Uptown Carwash _ Full-Service Car Detailers1_files/map-icon.svg" alt="Address">
          <div>
            <strong>Address</strong>
            <address>{{ settings.full_address }}</address>
          </div>
        </div>
        <a href="{{ settings.maps_url }}" class="btn btn-primary" target="_blank">GET DIRECTIONS</a>

        <h3>Business Hours</h3>
        <div class="hours-grid">
          <div><strong>{{ settings.hours.summer.label }}</strong></div>
          <div>Mon-Sat: {{ settings.hours.summer.mon_sat }}</div>
          <div>Sunday: {{ settings.hours.summer.sunday }}</div>
          <div><strong>{{ settings.hours.winter.label }}</strong></div>
          <div>Mon-Sat: {{ settings.hours.winter.mon_sat }}</div>
          <div>Sunday: {{ settings.hours.winter.sunday }}</div>
        </div>
        <p><strong>Closed:</strong> {{ settings.holidays_closed }}</p>
      </div>

      <div class="contact-form-wrapper">
        <h2>Send Us a Message</h2>
        <form class="contact-form" action="https://formsubmit.co/{{ settings.formsubmit_email }}" method="POST">
          <input type="hidden" name="_subject" value="New Contact Form - Uptown Car Wash">
          <input type="hidden" name="_captcha" value="false">
          <div class="form-group">
            <label for="name">Name *</label>
            <input type="text" id="name" name="name" required>
          </div>
          <div class="form-group">
            <label for="email">Email *</label>
            <input type="email" id="email" name="email" required>
          </div>
          <div class="form-group">
            <label for="phone">Phone</label>
            <input type="tel" id="phone" name="phone">
          </div>
          <div class="form-group">
            <label for="message">Message *</label>
            <textarea id="message" name="message" rows="5" required></textarea>
          </div>
          <button type="submit" class="btn btn-primary">SEND MESSAGE</button>
        </form>
      </div>
    </div>
  </div>
</section>
'@ | Out-File -FilePath "src/pages/contact.njk" -Encoding UTF8

# Gift Cards page
@'
---
layout: layouts/base.njk
title: Gift Cards
description: Purchase Uptown Car Wash gift cards - The perfect gift for any occasion.
permalink: /gift-cards/
---

<section class="page-hero">
  <div class="container">
    <h1>Gift Cards</h1>
    <p>The perfect gift for any occasion</p>
  </div>
</section>

<section class="gift-cards-content">
  <div class="container">
    <div class="gift-card-info">
      <h2>Give the Gift of a Clean Car</h2>
      <p>Uptown Car Wash gift cards make the perfect present for birthdays, holidays, or just because. Available in any amount.</p>
    </div>
    <div class="gift-card-widget">
      <iframe width="100%" height="750px" id="loopz-card-purchase" src="https://my.loopz.io/gift-card/e655cec7-0554-49b4-966b-c88ca04abe1a?locale=en-US" style="border-width: 0px; min-width:300px;"></iframe>
    </div>
    <div class="purchase-alternatives">
      <h3>Or Purchase In Person</h3>
      <div class="purchase-options">
        <div class="purchase-option">
          <p>{{ settings.full_address }}</p>
          <a href="{{ settings.maps_url }}" class="btn btn-primary" target="_blank" rel="noopener">GET DIRECTIONS</a>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="cta-area">
  <div class="container">
    <h2>Questions About Gift Cards?</h2>
    <p>Contact us and we'll be happy to help</p>
    <a href="/contact/" class="btn btn-primary">CONTACT US</a>
  </div>
</section>
'@ | Out-File -FilePath "src/pages/gift-cards.njk" -Encoding UTF8

# Memberships page
@'
---
layout: layouts/base.njk
title: Memberships
description: Uptown Car Wash San Diego Memberships - Join our Unlimited Wash Club or manage your membership.
permalink: /memberships/
---

<section class="page-hero">
  <div class="container">
    <h1>Memberships</h1>
    <p>Join our Unlimited Wash Club or manage your account</p>
  </div>
</section>

<section class="membership-section">
  <div class="container">
    <div class="membership-grid">
      <div class="membership-card featured">
        <h2>Join the Unlimited Wash Club</h2>
        <p>Wash your car as often as you like for one low monthly price. Plans start at just $29.99/month.</p>
        <ul class="membership-benefits">
          <li>Unlimited washes every month</li>
          <li>No long-term contract</li>
          <li>Cancel anytime</li>
          <li>50% off your first month</li>
        </ul>
        <a href="/unlimited-wash/" class="btn btn-primary">VIEW PLANS & JOIN</a>
      </div>
      <div class="membership-card">
        <h2>Manage My Membership</h2>
        <p>Already a member? Update your payment method, change vehicles, upgrade your plan, or cancel your membership.</p>
        <ul class="membership-benefits">
          <li>Update payment information</li>
          <li>Change registered vehicle</li>
          <li>Upgrade or downgrade plan</li>
          <li>Contact support</li>
        </ul>
        <a href="/my-membership/" class="btn btn-secondary">MANAGE ACCOUNT</a>
      </div>
    </div>
    <div class="membership-help">
      <h2>Membership Questions?</h2>
      <p>Our team is happy to help with any questions about the Unlimited Wash Club.</p>
      <div class="help-options">
        <div class="help-option">
          <h3>By Phone</h3>
          <p><a href="tel:{{ settings.phone_link }}">{{ settings.phone }}</a></p>
        </div>
        <div class="help-option">
          <h3>By Email</h3>
          <p><a href="mailto:{{ settings.email }}">{{ settings.email }}</a></p>
        </div>
        <div class="help-option">
          <h3>In Person</h3>
          <p>{{ settings.address }}<br>{{ settings.city_state_zip }}</p>
        </div>
      </div>
    </div>
  </div>
</section>
'@ | Out-File -FilePath "src/pages/memberships.njk" -Encoding UTF8

# Blog listing
@'
---
layout: layouts/base.njk
title: Blog
description: Car care tips, news, and updates from Uptown Car Wash San Diego.
permalink: /blog/
---

<section class="page-hero">
  <div class="container">
    <h1>Blog</h1>
    <p>Car care tips, news, and updates</p>
  </div>
</section>

<section class="blog-listing">
  <div class="container">
    <div class="blog-grid">
      {% for post in collections.blog | reverse %}
      <article class="blog-card">
        {% if post.data.featured_image %}
        <img src="{{ post.data.featured_image }}" alt="{{ post.data.title }}">
        {% endif %}
        <div class="blog-card-content">
          <time>{{ post.data.date | dateFormat }}</time>
          <h2><a href="{{ post.url }}">{{ post.data.title }}</a></h2>
          <p>{{ post.data.excerpt }}</p>
          <a href="{{ post.url }}" class="btn btn-secondary">Read More</a>
        </div>
      </article>
      {% else %}
      <p>No blog posts yet. Check back soon!</p>
      {% endfor %}
    </div>
  </div>
</section>
'@ | Out-File -FilePath "src/pages/blog.njk" -Encoding UTF8

Write-Host "Created page templates" -ForegroundColor Green

# ============================================================
# BLOG POST LAYOUT
# ============================================================

@'
---
layout: layouts/base.njk
---
<section class="page-hero">
  <div class="container">
    <h1>{{ title }}</h1>
    <p>{{ date | dateFormat }}</p>
  </div>
</section>

<article class="blog-post">
  <div class="container">
    {% if featured_image %}
    <img src="{{ featured_image }}" alt="{{ title }}" class="post-featured-image">
    {% endif %}
    <div class="post-content">
      {{ content | safe }}
    </div>
    <div class="post-footer">
      <a href="/blog/" class="btn btn-secondary">&larr; Back to Blog</a>
    </div>
  </div>
</article>
'@ | Out-File -FilePath "src/_includes/layouts/post.njk" -Encoding UTF8

Write-Host "Created blog post layout" -ForegroundColor Green

# ============================================================
# COPY REMAINING STATIC PAGES
# ============================================================

# Terms page
@'
---
layout: layouts/base.njk
title: Unlimited Wash Club Terms
description: Uptown Car Wash Unlimited Wash Club Terms and Conditions.
permalink: /terms/
---

<section class="page-hero">
  <div class="container">
    <h1>Unlimited Wash Club Terms</h1>
    <p>Membership Terms and Conditions</p>
  </div>
</section>

<section class="legal-content">
  <div class="container">
    <div class="legal-text">
      <h2>Membership Agreement</h2>
      <p>By enrolling in the Uptown Car Wash Unlimited Wash Club ("Program"), you agree to the following terms and conditions.</p>

      <h2>Membership Benefits</h2>
      <ul>
        <li>Unlimited car washes at your selected plan level</li>
        <li>One vehicle per membership</li>
        <li>10% discount on detailing services (select plans)</li>
        <li>Express Touch discount (select plans)</li>
        <li>No long-term contract required</li>
      </ul>

      <h2>Billing</h2>
      <ul>
        <li>Your credit/debit card will be charged on the same date each month</li>
        <li>First month promotional pricing (50% off) applies to new members only</li>
        <li>Membership automatically renews each month until cancelled</li>
        <li>Price changes will be communicated 30 days in advance</li>
      </ul>

      <h2>Vehicle Requirements</h2>
      <ul>
        <li>Membership is valid for one vehicle only</li>
        <li>Vehicle must be registered to the membership</li>
        <li>RFID tag must remain properly attached to windshield</li>
        <li>Vehicle must fit through our wash tunnel (max height restrictions apply)</li>
        <li>Membership is non-transferable between vehicles</li>
      </ul>

      <h2>Vehicle Changes</h2>
      <p>To change the vehicle on your membership, visit us in person with:</p>
      <ul>
        <li>Valid photo ID</li>
        <li>New vehicle registration</li>
      </ul>
      <p>One vehicle change per 30-day period is permitted.</p>

      <h2>Cancellation Policy</h2>
      <ul>
        <li>Cancel anytime with no cancellation fee</li>
        <li>Cancellation must be requested before your next billing date</li>
        <li>Cancel in person, by phone, or by email</li>
        <li>No refunds for partial months</li>
        <li>Membership benefits continue until end of current billing period</li>
      </ul>

      <h2>Contact</h2>
      <p>For membership questions or to cancel:</p>
      <ul>
        <li>Phone: <a href="tel:{{ settings.phone_link }}">{{ settings.phone }}</a></li>
        <li>Email: <a href="mailto:{{ settings.email }}">{{ settings.email }}</a></li>
        <li>In Person: {{ settings.full_address }}</li>
      </ul>
    </div>
  </div>
</section>
'@ | Out-File -FilePath "src/pages/terms.njk" -Encoding UTF8

# Privacy page
@'
---
layout: layouts/base.njk
title: Privacy Policy
description: Uptown Car Wash San Diego Privacy Policy.
permalink: /privacy/
---

<section class="page-hero">
  <div class="container">
    <h1>Privacy Policy</h1>
    <p>Your privacy is important to us</p>
  </div>
</section>

<section class="legal-content">
  <div class="container">
    <div class="legal-text">
      <h2>Information We Collect</h2>
      <p>We collect information you provide directly, such as name, email, and phone number when you fill out forms or sign up for memberships.</p>

      <h2>How We Use Your Information</h2>
      <ul>
        <li>To provide our services</li>
        <li>To process membership payments</li>
        <li>To send promotional offers (with your consent)</li>
        <li>To improve our services</li>
      </ul>

      <h2>Contact Us</h2>
      <p>If you have questions about this privacy policy, contact us at:</p>
      <ul>
        <li>Email: <a href="mailto:{{ settings.email }}">{{ settings.email }}</a></li>
        <li>Phone: <a href="tel:{{ settings.phone_link }}">{{ settings.phone }}</a></li>
      </ul>
    </div>
  </div>
</section>
'@ | Out-File -FilePath "src/pages/privacy.njk" -Encoding UTF8

# My Membership page
@'
---
layout: layouts/base.njk
title: My Membership
description: Manage your Uptown Car Wash membership.
permalink: /my-membership/
---

<section class="page-hero">
  <div class="container">
    <h1>My Membership</h1>
    <p>Manage your Unlimited Wash Club account</p>
  </div>
</section>

<section class="my-membership-content">
  <div class="container">
    <div class="membership-manage-card">
      <h2>Membership Management</h2>
      <p>To manage your membership, please contact us:</p>
      <div class="manage-options">
        <div class="manage-option">
          <h3>By Phone</h3>
          <a href="tel:{{ settings.phone_link }}" class="btn btn-primary">{{ settings.phone }}</a>
        </div>
        <div class="manage-option">
          <h3>By Email</h3>
          <a href="mailto:{{ settings.email }}" class="btn btn-secondary">{{ settings.email }}</a>
        </div>
        <div class="manage-option">
          <h3>In Person</h3>
          <p>{{ settings.full_address }}</p>
          <a href="{{ settings.maps_url }}" class="btn btn-secondary" target="_blank">GET DIRECTIONS</a>
        </div>
      </div>
    </div>
  </div>
</section>
'@ | Out-File -FilePath "src/pages/my-membership.njk" -Encoding UTF8

Write-Host "Created remaining pages" -ForegroundColor Green

# ============================================================
# UPDATE DECAP CMS CONFIG
# ============================================================

@'
backend:
  name: git-gateway
  branch: main

media_folder: "images/uploads"
public_folder: "/images/uploads"

publish_mode: editorial_workflow

collections:
  - name: "blog"
    label: "Blog Posts"
    folder: "src/posts"
    create: true
    slug: "{{slug}}"
    fields:
      - { label: "Title", name: "title", widget: "string" }
      - { label: "Publish Date", name: "date", widget: "datetime", format: "YYYY-MM-DD" }
      - { label: "Meta Description (SEO)", name: "description", widget: "text", hint: "150-160 characters" }
      - { label: "Keywords (SEO)", name: "keywords", widget: "string", hint: "Comma-separated" }
      - { label: "Featured Image", name: "featured_image", widget: "image", required: false }
      - { label: "Excerpt", name: "excerpt", widget: "text" }
      - { label: "Layout", name: "layout", widget: "hidden", default: "layouts/post.njk" }
      - { label: "Body", name: "body", widget: "markdown" }

  - name: "settings"
    label: "Site Settings"
    files:
      - name: "general"
        label: "Business Info"
        file: "src/_data/settings.json"
        fields:
          - { label: "Business Name", name: "business_name", widget: "string" }
          - { label: "Phone", name: "phone", widget: "string" }
          - { label: "Phone Link", name: "phone_link", widget: "string" }
          - { label: "Email", name: "email", widget: "string" }
          - { label: "Address", name: "address", widget: "string" }
          - { label: "City State Zip", name: "city_state_zip", widget: "string" }
          - { label: "Full Address", name: "full_address", widget: "string" }
          - label: "Hours"
            name: "hours"
            widget: "object"
            fields:
              - label: "Summer"
                name: "summer"
                widget: "object"
                fields:
                  - { label: "Label", name: "label", widget: "string" }
                  - { label: "Mon-Sat", name: "mon_sat", widget: "string" }
                  - { label: "Sunday", name: "sunday", widget: "string" }
              - label: "Winter"
                name: "winter"
                widget: "object"
                fields:
                  - { label: "Label", name: "label", widget: "string" }
                  - { label: "Mon-Sat", name: "mon_sat", widget: "string" }
                  - { label: "Sunday", name: "sunday", widget: "string" }
          - { label: "Holidays Closed", name: "holidays_closed", widget: "string" }
          - { label: "Google Maps URL", name: "maps_url", widget: "string" }
          - { label: "Year Established", name: "year_established", widget: "string" }
          - { label: "FormSubmit Email", name: "formsubmit_email", widget: "string" }

  - name: "memberships"
    label: "Membership Plans"
    files:
      - name: "plans"
        label: "Wash Club Plans"
        file: "src/_data/memberships.json"
        fields:
          - label: "Intro Section"
            name: "intro"
            widget: "object"
            fields:
              - { label: "Title", name: "title", widget: "string" }
              - { label: "Subtitle", name: "subtitle", widget: "string" }
              - label: "Benefits"
                name: "benefits"
                widget: "list"
                fields:
                  - { label: "Icon", name: "icon", widget: "string" }
                  - { label: "Title", name: "title", widget: "string" }
                  - { label: "Description", name: "desc", widget: "string" }
          - label: "Plans"
            name: "plans"
            widget: "list"
            fields:
              - { label: "Plan Name", name: "name", widget: "string" }
              - { label: "Monthly Price", name: "price", widget: "string" }
              - { label: "First Month Price", name: "first_month", widget: "string" }
              - { label: "Featured", name: "featured", widget: "boolean", default: false }
              - { label: "Badge Text", name: "badge", widget: "string", required: false }
              - { label: "Features", name: "features", widget: "list", field: { label: "Feature", name: "feature", widget: "string" } }
              - { label: "Stripe Payment Link", name: "stripe_link", widget: "string", required: false }
          - label: "How It Works Steps"
            name: "how_it_works"
            widget: "list"
            fields:
              - { label: "Step Number", name: "step", widget: "number" }
              - { label: "Title", name: "title", widget: "string" }
              - { label: "Description", name: "desc", widget: "string" }

  - name: "pages"
    label: "Page Content"
    files:
      - name: "home"
        label: "Homepage"
        file: "src/_data/pages/home.json"
        fields:
          - label: "Hero"
            name: "hero"
            widget: "object"
            fields:
              - { label: "Title", name: "title", widget: "string" }
              - { label: "Subtitle", name: "subtitle", widget: "string" }
          - label: "Who We Are"
            name: "who_we_are"
            widget: "object"
            fields:
              - { label: "Label", name: "label", widget: "string" }
              - { label: "Title", name: "title", widget: "string" }
              - { label: "Paragraph 1", name: "text1", widget: "text" }
              - { label: "Paragraph 2", name: "text2", widget: "text" }
          - label: "Services"
            name: "services"
            widget: "list"
            fields:
              - { label: "Title", name: "title", widget: "string" }
              - { label: "Description", name: "desc", widget: "string" }
              - { label: "Image", name: "image", widget: "string" }
              - { label: "Link", name: "link", widget: "string" }

      - name: "about"
        label: "About Page"
        file: "src/_data/pages/about.json"
        fields:
          - { label: "Title", name: "title", widget: "string" }
          - { label: "Subtitle", name: "subtitle", widget: "string" }
          - label: "Our Story"
            name: "our_story"
            widget: "object"
            fields:
              - { label: "Heading", name: "heading", widget: "string" }
              - { label: "Paragraphs", name: "paragraphs", widget: "list", field: { label: "Paragraph", name: "p", widget: "text" } }
          - label: "Hybrid Wash"
            name: "hybrid_wash"
            widget: "object"
            fields:
              - { label: "Heading", name: "heading", widget: "string" }
              - { label: "Intro", name: "intro", widget: "text" }
              - { label: "Features", name: "features", widget: "list", field: { label: "Feature", name: "f", widget: "string" } }
              - { label: "Conclusion", name: "conclusion", widget: "text" }
          - label: "Differentiators"
            name: "differentiators"
            widget: "object"
            fields:
              - { label: "Heading", name: "heading", widget: "string" }
              - { label: "Items", name: "items", widget: "list", field: { label: "Item", name: "i", widget: "string" } }

      - name: "free_wash"
        label: "Free Wash Page"
        file: "src/_data/pages/free_wash.json"
        fields:
          - { label: "Title", name: "title", widget: "string" }
          - { label: "Subtitle", name: "subtitle", widget: "string" }
          - { label: "Wash Name", name: "wash_name", widget: "string" }
          - { label: "Wash Value", name: "wash_value", widget: "string" }
          - { label: "Redeem Steps", name: "redeem_steps", widget: "list", field: { label: "Step", name: "s", widget: "string" } }
          - { label: "Features", name: "features", widget: "list", field: { label: "Feature", name: "f", widget: "string" } }
'@ | Out-File -FilePath "admin/config.yml" -Encoding UTF8

Write-Host "Updated CMS config" -ForegroundColor Green

# ============================================================
# CREATE SAMPLE BLOG POST
# ============================================================

if (-not (Test-Path "src/posts")) {
    New-Item -ItemType Directory -Force -Path "src/posts" | Out-Null
}

@'
---
title: "Welcome to Our New Website"
date: 2025-01-01
description: "Introducing the new Uptown Car Wash website with online booking and membership signup."
keywords: "car wash, san diego, uptown car wash, new website"
featured_image: "/pexels-photo-6872150.jpeg"
excerpt: "We're excited to announce the launch of our brand new website!"
layout: layouts/post.njk
---

## Welcome!

We're thrilled to introduce our newly redesigned website. Here you can:

- Learn about our services
- Sign up for the Unlimited Wash Club
- Purchase gift cards online
- Read car care tips on our blog

Thank you for being part of the Uptown Car Wash family since 1988!
'@ | Out-File -FilePath "src/posts/welcome.md" -Encoding UTF8

Write-Host "Created sample blog post" -ForegroundColor Green

# ============================================================
# UPDATE PACKAGE.JSON
# ============================================================

@'
{
  "name": "uptown-carwash-site",
  "version": "2.0.0",
  "description": "Uptown Car Wash San Diego Website",
  "scripts": {
    "build": "eleventy",
    "start": "eleventy --serve",
    "debug": "DEBUG=Eleventy* eleventy"
  },
  "dependencies": {
    "@11ty/eleventy": "^2.0.1",
    "markdown-it": "^14.0.0"
  }
}
'@ | Out-File -FilePath "package.json" -Encoding UTF8

Write-Host "Updated package.json" -ForegroundColor Green

# ============================================================
# UPDATE NETLIFY CONFIG
# ============================================================

@'
[build]
  command = "npm run build"
  publish = "_site"

[build.environment]
  NODE_VERSION = "18"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200
  conditions = {Role = ["admin"]}
'@ | Out-File -FilePath "netlify.toml" -Encoding UTF8

Write-Host "Updated netlify.toml" -ForegroundColor Green

# ============================================================
# DONE
# ============================================================

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "CMS SETUP COMPLETE!" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Run: npm install" -ForegroundColor White
Write-Host "2. Run: npm run build (to test)" -ForegroundColor White
Write-Host "3. Push to GitHub/GitLab connected to Netlify" -ForegroundColor White
Write-Host "4. Enable Netlify Identity in Netlify dashboard" -ForegroundColor White
Write-Host "5. Go to yoursite.com/admin to log in" -ForegroundColor White
Write-Host ""
Write-Host "Your CMS will let you edit:" -ForegroundColor Yellow
Write-Host "- Blog posts" -ForegroundColor White
Write-Host "- Site settings (phone, email, hours)" -ForegroundColor White
Write-Host "- Membership plans & pricing" -ForegroundColor White
Write-Host "- Homepage content" -ForegroundColor White
Write-Host "- About page content" -ForegroundColor White
Write-Host "- Free wash offer details" -ForegroundColor White
Write-Host ""
