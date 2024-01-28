#!/usr/bin/env sh
set -e
echo 'Contents of build/l10n_errors.json:'
tee /dev/tty <build/l10n_errors.json | jq -e '.=={}' >/dev/null
echo # Add newline to output from l10n_errors.json
