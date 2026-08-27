#!/bin/sh
# Installs the versioned pre-commit hook into this clone (idempotent).
# Run from the vault root: sh "99 System/policy/hooks/install.sh"
set -e
root="$(git rev-parse --show-toplevel)"
src="$root/99 System/policy/hooks/pre-commit"
dst="$root/.git/hooks/pre-commit"
cp "$src" "$dst" && chmod +x "$dst"
echo "pre-commit installed: $dst"
