#!/bin/sh

TMPFILE=$(mktemp "npm-wrapper.XXXXXX")

on_exit() {
  rm -f "$TMPFILE"
}
trap on_exit EXIT

echo Running npm "$@"
npm "$@" 2>&1 | tee -a "$TMPFILE"
logfile=$(grep "npm ERR.*\.log" "$TMPFILE" | awk -F' ' '{print $3}')
if [ -n "$logfile" ]; then
    cat "$logfile"
fi
