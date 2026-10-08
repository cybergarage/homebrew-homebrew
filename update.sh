#!/usr/bin/env bash
#
# update.sh - Update formulae to the latest Git tag of their upstream repository.
#
# Usage:
#   ./update.sh [-n] [-c] [formula ...]
#
#   formula  Formula name(s) (e.g. uecho, mupnp++). Defaults to all *.rb files.
#   -n       Dry run: show what would change without modifying files.
#   -c       Commit each updated formula ("Update <name> to <tag>").
#
set -euo pipefail

cd "$(dirname "$0")"

DRY_RUN=0
COMMIT=0
while getopts "nch" opt; do
  case "$opt" in
    n) DRY_RUN=1 ;;
    c) COMMIT=1 ;;
    h) sed -n '3,12p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) exit 1 ;;
  esac
done
shift $((OPTIND - 1))

if [ $# -eq 0 ]; then
  set -- *.rb
fi

sha256() {
  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | awk '{print $1}'
  else
    sha256sum "$1" | awk '{print $1}'
  fi
}

# Print the latest release tag (x.y.z or vx.y.z, pre-releases excluded).
latest_tag() {
  GIT_TERMINAL_PROMPT=0 git ls-remote --tags --refs "https://github.com/$1" |
    sed 's|.*refs/tags/||' |
    grep -E '^v?[0-9]+(\.[0-9]+)*$' |
    awk '{ v = $0; sub(/^v/, "", v); n = split(v, a, ".");
           printf "%08d.%08d.%08d.%08d\t%s\n", a[1], a[2], a[3], a[4], $0 }' |
    sort | tail -1 | cut -f2
}

TMPDIR_UPDATE="$(mktemp -d)"
trap 'rm -rf "$TMPDIR_UPDATE"' EXIT

updated=0
failed=0

for arg in "$@"; do
  file="${arg%.rb}.rb"
  name="${file%.rb}"
  if [ ! -f "$file" ]; then
    echo "[$name] ERROR: $file not found" >&2
    failed=$((failed + 1)); continue
  fi

  cur_url="$(sed -nE 's/^[[:space:]]*url "([^"]+)".*/\1/p' "$file" | head -1)"
  repo="$(printf '%s' "$cur_url" | sed -nE 's|^https://github.com/([^/]+/[^/]+)/archive/.*|\1|p')"
  if [ -z "$repo" ]; then
    echo "[$name] SKIP: url is not a GitHub archive URL ($cur_url)" >&2
    continue
  fi
  cur_tag="$(printf '%s' "$cur_url" | sed -E 's|.*/archive/(refs/tags/)?||; s|\.tar\.gz$||')"

  tag="$(latest_tag "$repo" || true)"
  if [ -z "$tag" ]; then
    echo "[$name] ERROR: no release tags found in $repo" >&2
    failed=$((failed + 1)); continue
  fi

  if [ "$tag" = "$cur_tag" ]; then
    echo "[$name] up to date ($tag)"
    continue
  fi

  new_url="https://github.com/$repo/archive/refs/tags/$tag.tar.gz"
  if [ "$DRY_RUN" -eq 1 ]; then
    echo "[$name] $cur_tag -> $tag (dry run)"
    continue
  fi

  tarball="$TMPDIR_UPDATE/$name-$tag.tar.gz"
  if ! curl -fsSL -o "$tarball" "$new_url"; then
    echo "[$name] ERROR: failed to download $new_url" >&2
    failed=$((failed + 1)); continue
  fi
  new_sha="$(sha256 "$tarball")"

  # Portable in-place edit (works with both BSD and GNU tools).
  NEW_URL="$new_url" NEW_SHA="$new_sha" perl -i -pe '
    s/^(\s*url\s+")[^"]+(")/$1$ENV{NEW_URL}$2/;
    s/^(\s*sha256\s+")[0-9a-f]+(")/$1$ENV{NEW_SHA}$2/;
  ' "$file"

  echo "[$name] $cur_tag -> $tag"
  updated=$((updated + 1))

  if [ "$COMMIT" -eq 1 ]; then
    git add "$file"
    git commit -q -m "Update $name to $tag"
  fi
done

echo "Done: $updated updated, $failed failed."
[ "$failed" -eq 0 ]
