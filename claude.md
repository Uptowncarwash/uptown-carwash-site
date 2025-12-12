# Uptown Car Wash Website

## Project Overview
Static website for Uptown Car Wash, a full-service car wash and detailing business in San Diego, CA. In business since 1988.

**Now powered by Eleventy (11ty) with Decap CMS for easy content editing.**

## Business Info
- **Name**: Uptown Car Wash
- **Address**: 4157 Normal St, San Diego, CA 92103
- **Phone**: (619) 297-9274
- **Email**: uptowncarwashsd@gmail.com
- **Domain**: uptowncarwashsandiego.com

## Tech Stack
- **Static Site Generator**: Eleventy (11ty) v2.0.1
- **CMS**: Decap CMS (formerly Netlify CMS)
- **Templating**: Nunjucks (.njk)
- **Styling**: CSS in `css/styles.css`
- **Hosting**: Netlify with Netlify Identity
- **Forms**: FormSubmit.co (free, no account needed)
- **Reviews Widget**: Elfsight Google Reviews
- **Analytics**: Google Analytics (G-YRRZRP31SW)

## Project Structure
```
/
├── src/                        # Source files (Eleventy processes these)
│   ├── _data/                  # Global data files (JSON)
│   │   ├── settings.json       # Business info, hours, contact
│   │   ├── memberships.json    # Wash club plans and pricing
│   │   └── pages/              # Page-specific content
│   │       ├── home.json
│   │       ├── about.json
│   │       └── free_wash.json
│   ├── _includes/
│   │   └── layouts/            # Nunjucks layouts
│   │       ├── base.njk        # Base HTML template
│   │       └── post.njk        # Blog post layout
│   ├── pages/                  # Site pages (.njk templates)
│   └── posts/                  # Blog posts (.md files)
├── admin/                      # Decap CMS admin panel
│   ├── index.html              # CMS entry point
│   └── config.yml              # CMS configuration
├── css/                        # Stylesheets
├── images/                     # Image assets
├── _site/                      # Built site (git-ignored)
├── .eleventy.js                # Eleventy configuration
├── package.json                # Node dependencies
└── netlify.toml                # Netlify build config
```

## Development Commands
```bash
npm install          # Install dependencies
npm run build        # Build site to _site/
npm start            # Start dev server at localhost:8080
```

## CMS Content Editing
The CMS is accessible at `/admin/` after deployment. Editable content:

### Via CMS Admin Panel:
- **Blog Posts**: Create, edit, delete blog articles
- **Site Settings**: Business name, phone, email, hours, address
- **Membership Plans**: Wash club pricing and features
- **Homepage Content**: Hero text, services, "Who We Are" section
- **About Page**: Our story, hybrid wash info, differentiators
- **Free Wash Page**: Promo details and features

### Pages (Edit .njk files directly):
- Car Wash Services pricing
- Detailing Services pricing
- Ceramic Coatings packages
- Headlight Restoration info
- Gift Cards page
- Contact page
- Terms & Privacy pages

## Deployment to Netlify

### Step 1: Push to GitHub
```bash
git add .
git commit -m "Initial CMS setup"
git push origin main
```

### Step 2: Connect to Netlify
1. Go to [app.netlify.com](https://app.netlify.com)
2. Click "Add new site" > "Import an existing project"
3. Connect your GitHub repo
4. Build settings are auto-configured from netlify.toml

### Step 3: Enable Netlify Identity
1. In Netlify dashboard, go to Site Settings > Identity
2. Click "Enable Identity"
3. Under Registration, select "Invite only"
4. Invite yourself (your email) as a user
5. Check your email and set up your password

### Step 4: Enable Git Gateway
1. Go to Site Settings > Identity > Services
2. Click "Enable Git Gateway"
3. This allows the CMS to commit changes to your repo

### Step 5: Test CMS
1. Visit `yoursite.netlify.app/admin/`
2. Log in with your Netlify Identity credentials
3. Test creating/editing a blog post

## Key Data Files

### settings.json
Business-wide settings used across all pages:
- Business name, phone, email, address
- Hours (summer/winter schedules)
- Google Maps URL
- FormSubmit email endpoint

### memberships.json
Wash club membership data:
- Plan names, pricing, features
- "How it works" steps
- Stripe payment links (empty - add when ready)

## Forms
All forms use FormSubmit.co:
```html
<form action="https://formsubmit.co/uptowncarwashsd@gmail.com" method="POST">
```
- No account needed
- Emails go directly to the business email
- Includes honeypot spam protection

## Integrations

| Integration                     | Status  | Notes                                         |
|---------------------------------|---------|-----------------------------------------------|
| Google Analytics (G-YRRZRP31SW) | Active  | In base.njk layout                            |
| ElfSight Google Reviews         | Active  | Homepage                                      |
| Square Appointments             | Active  | Detailing, Coatings, Headlights pages         |
| Loopz Gift Cards                | Active  | Gift Cards page                               |
| FormSubmit.co                   | Active  | All contact forms                             |
| Decap CMS                       | Active  | Admin panel at /admin/                        |
| Stripe Payments                 | Pending | Add payment links to memberships.json         |

## Reference Files (Do Not Edit)
- `*.html` files in root - Original static pages (kept for reference)
- `webpage1_files/` - Original site assets
- `deploy/` - Old deployment folder

## Stripe Integration (Future)
When ready to add Stripe payment links:
1. Create products/prices in Stripe Dashboard
2. Get the Payment Link URLs
3. Edit `src/_data/memberships.json` via CMS or directly
4. Add URLs to each plan's `stripe_link` field
