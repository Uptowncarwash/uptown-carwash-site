# Accessibility (WCAG 2.0 AA)

**Status 2026-10-27: 0 automated WCAG 2.0/2.1 A + AA violations on all 26 public pages** (axe-core 4.8.4,
`wcag2a` + `wcag2aa` rule tags, run against the built `_site/` in headless Chromium).
Before the fix: 73 contrast failures plus unlabeled form fields, an untitled iframe and no skip link.

Why it matters: the EPLI insurance application (Rockwood, Q III.A.7) asks whether the public website
complies with WCAG 2.0. Website-accessibility (ADA) suits are an employment-practices-adjacent exposure.

## What was fixed
| Issue | WCAG | Fix |
|---|---|---|
| Brand orange `#ea580c` with white text = 3.55:1 (needs 4.5:1), 73 places | 1.4.3 | `--color-accent` → `#c2410c` (5.18:1) |
| Orange links on the navy help panel = 3.23:1 | 1.4.3 | `.help-option a` → `#fb923c` (5.08:1) |
| White outline buttons on light sections (white on white) | 1.4.3 | navy text/border in `.blog-listing`, `.blog-post`, `.alt-bg`, `.contact-page-content`, `.membership-section` |
| Home contact form fields had placeholders only | 1.3.1, 4.1.2 | `aria-label` + `autocomplete` on name/email/phone/message |
| Free-wash offer iframe had no title | 4.1.2 | `title="Free wash offer sign-up form"` |
| No way to skip the navigation | 2.4.1 | `.skip-link` → `<main id="main">` in `base.njk` |
| Form fields removed the focus outline | 2.4.7 | global `:focus-visible` outline |

## Keep it compliant
- **New colors:** text must be ≥ 4.5:1 against its background (≥ 3:1 for 24px+ / 18.66px+ bold). Do not
  put white text on the old `#ea580c`.
- **New images:** every `<img>` needs `alt` (empty `alt=""` only for pure decoration).
- **New form fields:** a `<label for>` or `aria-label`; placeholders alone do not count.
- **New embeds/iframes:** give each a `title`.
- **Re-check after design changes:** build, serve `_site/`, run axe with tags `wcag2a,wcag2aa` on every
  `index.html` (the 2026-10-27 run script is a ~40-line Playwright + axe-core loop).

Not covered by an automated scan: meaningful alt-text wording, reading order, caption needs for any future
video. Third-party embeds (FlexWash gift cards, wmoffer free-wash form, Elfsight reviews) are the vendors' own pages.
