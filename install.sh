#!/usr/bin/env bash
# Copy the SDLC skills into another repo's .claude/skills/ (alternative to installing the plugin).
# Usage: ./install.sh <path-to-repo | git-url> [branch]
set -euo pipefail
target="${1:?usage: install.sh <path-to-repo | git-url> [branch]}"
branch="${2:-}"
here="$(cd "$(dirname "$0")" && pwd)"
tmp=""
if [[ "$target" =~ ^(https?://|git@) ]]; then
  tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
  git clone --depth 1 "$target" "$tmp/repo"
  [[ -n "$branch" ]] && git -C "$tmp/repo" checkout -B "$branch"
  target="$tmp/repo"
fi
[[ -d "$target" ]] || { echo "not a directory: $target" >&2; exit 1; }
mkdir -p "$target/.claude/skills"
for s in "$here"/skills/*/; do
  name="sdlc-$(basename "$s")"   # prefix so copies don't clash with project skills
  rm -rf "$target/.claude/skills/$name"
  cp -R "$s" "$target/.claude/skills/$name"
  sed -i "s/^name: .*/name: $name/" "$target/.claude/skills/$name/SKILL.md"
done
echo "Installed $(ls "$here"/skills | wc -l) skills into $target/.claude/skills (prefix sdlc-)."
[[ -n "$tmp" ]] && echo "Cloned copy at $target - commit and push it yourself."
