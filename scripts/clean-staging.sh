#!/usr/bin/env bash
#
# clean-staging.sh — remove the /staging/ mirror.
#
# Run this before merging a PR into `main`: staging is a preview only and must
# never ship to the live site. See CLAUDE.md → "Staging mirror protocol".
#
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if [ -d staging ]; then
  rm -rf staging
  echo "Removed /staging/."
else
  echo "No /staging/ to remove."
fi
