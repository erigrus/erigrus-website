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
/                       index.html        — studio landing (DE)
/en/                    index.html        — studio landing (EN)
/dashjam/               index.html        — DashJam app page
/dashjam/privacy/       index.html        — DashJam privacy policy (App Store URL)
/dashjam/support/       index.html        — DashJam support (App Store URL)
/dashjam/en/…           index.html        — English DashJam pages
/febra/                 index.html        — Febra app page
/febra/privacy/         index.html        — Febra privacy policy (App Store URL)
/febra/support/         index.html        — Febra support (App Store URL)
/febra/en/…             index.html        — English Febra pages
/assets/                style.css, icons
CNAME                   custom domain (erigrus.de)
.nojekyll               serve files as-is, skip Jekyll
404.html                not-found page
```

## App Store Connect URLs

**DashJam** — on the App Store at
<https://apps.apple.com/de/app/dashjam/id6777179664> (app ID `6777179664`),
linked from `/dashjam/` and `/dashjam/en/`.

| Field | URL |
|---|---|
| Privacy Policy URL (EN) | `https://erigrus.de/dashjam/en/privacy/` |
| Support URL (EN) | `https://erigrus.de/dashjam/en/support/` |
| Marketing URL (EN) | `https://erigrus.de/dashjam/en/` |
| Privacy Policy URL (DE) | `https://erigrus.de/dashjam/privacy/` |
| Support URL (DE) | `https://erigrus.de/dashjam/support/` |
| Marketing URL (DE) | `https://erigrus.de/dashjam/` |

English (U.S.) is DashJam's primary App Store locale, so the EN pages are the
default URLs and the DE pages go on the German localization.

The DashJam page content is kept in sync with the source drafts in the app repo
at `apps/ios/docs/app-store/{privacy-policy,privacy-policy.de,support,support.de}.md`;
the listing copy those pages echo lives in `apps/ios/docs/app-store/README.md`.

**Febra** — German is the primary App Store locale, so the DE pages are the
default URLs and the EN pages go on the English (U.S.) localization.

| Field | URL |
|---|---|
| Privacy Policy URL (DE) | `https://erigrus.de/febra/privacy/` |
| Support URL (DE) | `https://erigrus.de/febra/support/` |
| Marketing URL (DE) | `https://erigrus.de/febra/` |
| Privacy Policy URL (EN) | `https://erigrus.de/febra/en/privacy/` |
| Support URL (EN) | `https://erigrus.de/febra/en/support/` |
| Marketing URL (EN) | `https://erigrus.de/febra/en/` |

The Febra page content is kept in sync with the source drafts in the
[FebraApp](https://github.com/erigrus/FebraApp) repo at
`docs/{privacy-policy,privacy-policy.de,support}.md`; the listing copy those
pages echo lives in `docs/app-store-submission.md`.

## Adding a new app

Copy the `dashjam/` folder, rename, edit content, and link it from `index.html`.
