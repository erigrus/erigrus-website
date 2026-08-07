# CLAUDE.md

Guidance for AI coding sessions on this repo.

## What this is

Static site for **https://erigrus.de**. No build step, no framework — edit an
HTML/CSS file, commit, push. Keep DE (`index.html`, `dashjam/…`) and EN
(`en/…`, `dashjam/en/…`) versions in sync. See `README.md` for the page map.

**Deploys:** GitHub Actions publishes the site. `main` is deployed to the
`gh-pages` branch (`.github/workflows/deploy.yml`); Pages serves `gh-pages`.
Each PR is previewed at `https://erigrus.de/pr-preview/pr-<N>/`
(`.github/workflows/pr-preview.yml`), removed automatically on close.

Merging a PR also deletes its head branch and purges its preview directory —
see "A merged PR leaves nothing behind" in `README.md`. Those workflows fire on
`pull_request: closed`, **not** on `push` alone: a merge made through the API
with a GitHub App or Actions token produces no workflow-triggering `push`
event. Keep that trigger if you touch them, or merges from tooling stop
deploying.

**Verifying a deploy:** a green `deploy.yml` run only proves `gh-pages` was
written. The site is live once GitHub's own `pages build and deployment` run
succeeds on top of it — check that one before reporting anything as published.

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

3. **Removal is automated:** staging must **never** ship to the live site, and
   two safety nets enforce that without manual steps:

   - the production deploy (`.github/workflows/deploy.yml`) excludes
     `staging/` from the published site, so it can't reach erigrus.de even if
     it lands on `main`;
   - an auto-cleanup workflow
     (`.github/workflows/clean-staging-on-main.yml`) deletes `staging/` from
     `main` right after any merge that still contains it.

   Running `./scripts/clean-staging.sh` and committing the removal as the
   final step before merging is still welcome (it keeps the cleanup commit out
   of `main`'s history), but forgetting it no longer breaks anything.

In short: **every new PR reactivates `/staging/`; every merge to `main` removes
it.**
