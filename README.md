# erigrus-website

Static site hosting the public pages for [Erik Gruschka](mailto:info@erigrus.de)'s
iOS apps, served at **https://erigrus.de** via GitHub Pages.

Plain HTML — no build step. Edit a file, commit, push; it's live in ~1 minute.

## Structure

```
/                       index.html        — studio landing
/dashjam/               index.html        — DashJam app page
/dashjam/privacy/       index.html        — DashJam privacy policy (App Store URL)
/dashjam/support/       index.html        — DashJam support (App Store URL)
/assets/                style.css, icons
CNAME                   custom domain (erigrus.de)
.nojekyll               serve files as-is, skip Jekyll
404.html                not-found page
```

## App Store Connect URLs

| Field | URL |
|---|---|
| Privacy Policy URL | `https://erigrus.de/dashjam/privacy/` |
| Support URL | `https://erigrus.de/dashjam/support/` |

The DashJam page content is kept in sync with the source drafts in the app repo
at `apps/ios/docs/app-store/{privacy-policy,support}.md`.

## Adding a new app

Copy the `dashjam/` folder, rename, edit content, and link it from `index.html`.
