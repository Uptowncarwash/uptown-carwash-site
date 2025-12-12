# Uptown Car Wash - Blog CMS Setup Guide

This guide will help you deploy the site to Netlify and set up the blog CMS for your GM.

## Step 1: Push Code to GitHub

1. Create a new repository on GitHub (e.g., `uptown-carwash-site`)
2. Push this code to that repository:
   ```bash
   git init
   git add .
   git commit -m "Initial commit with Decap CMS"
   git remote add origin https://github.com/YOUR_USERNAME/uptown-carwash-site.git
   git push -u origin main
   ```

## Step 2: Deploy to Netlify

1. Go to [netlify.com](https://netlify.com) and sign up/log in (use GitHub login)
2. Click "Add new site" → "Import an existing project"
3. Select GitHub and choose your repository
4. Netlify will auto-detect the settings from `netlify.toml`:
   - Build command: `npm run build`
   - Publish directory: `_site`
5. Click "Deploy site"

## Step 3: Enable Netlify Identity (for CMS login)

1. In Netlify dashboard, go to your site
2. Click **Site settings** → **Identity**
3. Click **Enable Identity**
4. Under **Registration**, select **Invite only** (so only you can add users)
5. Under **Services** → **Git Gateway**, click **Enable Git Gateway**

## Step 4: Invite Your GM

1. Go to **Identity** tab in Netlify dashboard
2. Click **Invite users**
3. Enter your GM's email address
4. They'll receive an email to set up their password

## Step 5: Set Up Custom Domain (Optional)

1. In Netlify, go to **Domain settings**
2. Click **Add custom domain**
3. Enter `uptowncarwash.com`
4. Update your GoDaddy DNS to point to Netlify (Netlify will provide instructions)

---

## How Your GM Uses the Blog

1. Go to `yoursite.netlify.app/admin/` (or `uptowncarwash.com/admin/` after domain setup)
2. Log in with email/password
3. Click **Blog Posts** → **New Blog Post**
4. Fill in:
   - **Title**: The blog post title
   - **Publish Date**: When to publish
   - **Meta Description**: Short description for Google (150-160 chars)
   - **Keywords**: Comma-separated SEO keywords
   - **Featured Image**: Upload or select an image
   - **Excerpt**: Short preview shown on blog listing
   - **Body**: Write the blog post content (supports formatting)
5. Click **Save** (creates a draft)
6. When ready, change status to **Ready** then **Publish**

The site will automatically rebuild and the new post will be live within 1-2 minutes.

---

## Local Development (for developers)

```bash
# Install dependencies
npm install

# Run local development server
npm start

# Build for production
npm run build
```

---

## File Structure

```
uptown-carwash-site/
├── admin/              # Decap CMS admin panel
│   ├── index.html
│   └── config.yml
├── css/
│   └── styles.css
├── src/
│   ├── _layouts/
│   │   └── post.njk    # Blog post template
│   ├── posts/          # Markdown blog posts (CMS writes here)
│   │   └── *.md
│   └── blog.njk        # Blog listing page
├── .eleventy.js        # 11ty config
├── netlify.toml        # Netlify config
├── package.json
└── [static HTML files]
```

---

## Support

For issues with the CMS, check:
- [Decap CMS Docs](https://decapcms.org/docs/)
- [Netlify Docs](https://docs.netlify.com/)
- [11ty Docs](https://www.11ty.dev/docs/)
