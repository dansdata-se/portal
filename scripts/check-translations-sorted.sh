#!/usr/bin/env sh
set -e
for f in lib/app/l10n/*.arb; do
  echo "$f"
  jq -e '
    keys_unsorted == (
      keys_unsorted | sort_by(
        # put `@@locale` first
        sub("^@@"; "\u0000")
        # put `key` before `@key`
        | sub("^@(?<name>.+)"; "\(.name)_")
      )
    )
  ' <"$f"
done
