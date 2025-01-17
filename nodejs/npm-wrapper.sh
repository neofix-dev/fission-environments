#!/bin/sh
set -o pipefail
set -e
TMPFILE=$(mktemp "npm-wrapper.XXXXXX")

on_exit() {
  rm -f "$TMPFILE"
}
trap on_exit EXIT

if ! (npm "$@" 2>&1 | tee -a "$TMPFILE"); then
  logfile=$(grep "npm ERR.*\.log" "$TMPFILE" | awk -F' ' '{print $3}')
  if [ -n "$logfile" ]; then
    cat "$logfile"
  fi
  exit 1
fi
exit 0