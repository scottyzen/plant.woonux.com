#!/usr/bin/env bash
# Usage: scripts/update-woonuxt.sh [tag]   (defaults to the latest release)
# Replaces woonuxt_base/ with the upstream version so `git diff` shows exactly what changed.
set -euo pipefail

REPO="scottyzen/woonuxt"
cd "$(dirname "$0")/.."

if [[ -n "$(git status --porcelain)" ]]; then
  echo "Working tree not clean. Commit or stash first so the update is reviewable." >&2
  exit 1
fi

TAG="${1:-$(gh release view --repo "$REPO" --json tagName -q .tagName)}"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "Fetching $REPO@$TAG..."
git clone -q --depth 1 --branch "$TAG" "https://github.com/$REPO.git" "$TMP/woonuxt" 2>/dev/null

# Generated GraphQL SDK is backend-specific and git-ignored, so keep it.
rsync -a --delete --exclude='app/gql/default.ts' --exclude='app/gql/schema.ts' \
  "$TMP/woonuxt/woonuxt_base/" woonuxt_base/

echo
echo "woonuxt_base updated to $TAG. Changed files:"
git --no-pager diff --stat -- woonuxt_base
echo
echo "Root package.json differences (local vs upstream; merge deps by hand, keep your tweaks):"
diff package.json "$TMP/woonuxt/package.json" || true
echo
echo "Next: review 'git diff', re-apply any local base patches (see docs/woonuxt-store-setup-hurdles.md),"
echo "then run: npm install && npm run typecheck && npm run build"
