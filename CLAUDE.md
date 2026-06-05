# CLAUDE.md

Guidance for AI coding sessions on this repo.

## What this is

Static site for **https://erigrus.de**, served by **GitHub Pages directly from
`main`**. No build step, no framework — edit an HTML/CSS file, commit, push, and
it's live in ~1 minute. Keep DE (`index.html`, `dashjam/…`) and EN
(`en/…`, `dashjam/en/…`) versions in sync. See `README.md` for the page map.

## Staging mirror protocol  ⚠️ read this every session

`/staging/` is an **unlisted, ephemeral, full-site mirror** used to preview the
current branch's version of the site. It is **never linked** from any page and
carries `<meta name="robots" content="noindex, nofollow">` on every page, so it's
reachable only by knowing the URL (`erigrus.de/staging/`) and stays out of search.

It is regenerated from the live pages by a script — do **not** hand-edit files
under `staging/`; edit the real pages and rebuild.

**Lifecycle — follow this in every PR / session:**

1. **Reactivate (start of work):** staging is removed before each merge to
   `main`, so a fresh PR branch will not have it. Regenerate it:

   ```bash
   ./scripts/build-staging.sh
   ```

   Commit the regenerated `staging/` on the feature branch so the preview is
   available for review.

2. **Keep it fresh:** after changing any public page, re-run
   `./scripts/build-staging.sh` so the mirror reflects your changes.

3. **Remove before merging to `main`:** staging must **never** ship to the live
   site. As the final step before the PR merges:

   ```bash
   ./scripts/clean-staging.sh
   ```

   Commit the removal. A CI guard
   (`.github/workflows/no-staging-on-main.yml`) fails the build if `staging/`
   ever lands on `main` — treat a red guard as "run clean-staging.sh".

In short: **every new PR reactivates `/staging/`; every merge to `main` removes
it.**
