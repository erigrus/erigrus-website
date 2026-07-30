#!/usr/bin/env bash
#
# build-staging.sh — (re)generate the unlisted /staging/ mirror of the site.
#
# /staging/ is an EPHEMERAL, full-site preview of the current branch. It is
# never meant to live on `main` (see CLAUDE.md → "Staging mirror protocol").
# Run this in a PR/session to "reactivate" staging; run clean-staging.sh to
# remove it before merging to main.
#
# What it does:
#   - copies every public page into staging/
#   - rewrites root-absolute internal links (href="/...", src="/...") into the
#     /staging/ namespace so the mirror is self-contained and navigable
#   - keeps shared assets at the real /assets/ root (no duplication)
#   - adds <meta name="robots" content="noindex, nofollow"> to every page
#
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

# Top-level public content to mirror (exclude infra + staging itself).
PAGES=(index.html en dashjam febra impressum datenschutz)

rm -rf staging
mkdir -p staging
for item in "${PAGES[@]}"; do
  cp -r "$item" "staging/$item"
done

while IFS= read -r -d '' f; do
  # Push root-absolute internal links into the staging namespace...
  sed -i 's#\(href\|src\)="/#\1="/staging/#g' "$f"
  # ...but keep shared assets served from the real root.
  sed -i 's#="/staging/assets/#="/assets/#g' "$f"
  # Mark every staging page noindex (idempotent: skip if already present).
  if ! grep -q 'name="robots"' "$f"; then
    sed -i 's#\(<meta name="viewport"[^>]*>\)#\1\n  <meta name="robots" content="noindex, nofollow" />#' "$f"
  fi
done < <(find staging -name '*.html' -print0)

echo "Staging mirror rebuilt → /staging/ ($(find staging -name '*.html' | wc -l | tr -d ' ') pages)"
