#!/usr/bin/env zsh

set -euo pipefail

# --- Parse arguments ---
if [[ $# -ne 2 ]]; then
  echo "Usage: diff-checker <source_dir> <target_dir>"
  exit 1
fi

src_dir="$1"
tgt_dir="$2"

# --- Check if dirs exist ---
if [[ ! -d "$src_dir" || ! -d "$tgt_dir" ]]; then
  echo "❌ Error: One or both directories do not exist"
  exit 1
fi

# --- Create temp files ---
src_files=$(mktemp)
tgt_files=$(mktemp)

echo "[1/2] Comparing file structure..."

# --- Find files relative to root, excluding macOS metadata and generated files ---
(
  cd "$src_dir"
  find . -type f \
    ! -name '.DS_Store' \
    ! -name '._*' \
    | sort > "$src_files"
)

(
  cd "$tgt_dir"
  find . -type f \
    ! -name '.DS_Store' \
    ! -name '._*' \
    | sort > "$tgt_files"
)

# --- Compare file structure ---
if ! diff -q "$src_files" "$tgt_files" > /dev/null; then
  echo "❌ File structure mismatch between source and target."
  echo "Diff (first 20 lines):"
  diff "$src_files" "$tgt_files" | head -n 20
  exit 1
fi

echo "✅ File structure identical."

echo "[2/2] Verifying file contents with sha256sum..."

# --- Hash and compare each file ---
while IFS= read -r rel_path; do
  src_file="$src_dir/$rel_path"
  tgt_file="$tgt_dir/$rel_path"

  # Quote to handle spaces and special chars
  src_hash=$(sha256sum "$src_file" | awk '{print $1}')
  tgt_hash=$(sha256sum "$tgt_file" | awk '{print $1}')

  if [[ "$src_hash" != "$tgt_hash" ]]; then
    echo "❌ Hash mismatch: $rel_path"
    echo "Source: $src_hash"
    echo "Target: $tgt_hash"
    exit 1
  fi

  echo "✔ $rel_path"
done < "$src_files"

echo "🎉 All files match. Verification successful."

# --- Clean up ---
rm -f "$src_files" "$tgt_files"

