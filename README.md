# erigrus-website

Static site hosting the public pages for [Erik Gruschka](mailto:info@erigrus.de)'s
iOS apps, served at **https://erigrus.de** via GitHub Pages.

Plain HTML — no build step. Edit a file, commit, push; it's live in ~1 minute.

## Deploys & PR previews

Production is published by GitHub Actions (`.github/workflows/deploy.yml`):
every push to `main` assembles the site and deploys it to the **`gh-pages`**
branch. Pushing to `main` is still "edit, push, live".

Every pull request gets a public **preview** at
`https://erigrus.de/pr-preview/pr-<N>/` (via
`.github/workflows/pr-preview.yml` + `rossjrw/pr-preview-action`); it's torn
down automatically when the PR closes. Previews include the PR's `/staging/`
mirror; production deploys exclude it, and a cleanup workflow
(`.github/workflows/clean-staging-on-main.yml`) auto-removes `staging/` if it
ever lands on `main`.

> **One-time setup:** in **Settings → Pages**, set the source to the
> **`gh-pages` branch / `root`**. Until that switch is made, the Actions
> publish to `gh-pages` but the live site keeps serving from `main` (no
> downtime). `CNAME` and `.nojekyll` are carried into `gh-pages` automatically.

Preview and `/staging/` paths are excluded from search via `robots.txt`.

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
