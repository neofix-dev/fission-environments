#!/bin/sh

env
TMPFILE=$(mktemp "npm-wrapper.XXXXXX")

on_exit() {
  rm -f "$TMPFILE"
}

output_log() {
  printf '[%s]\t%s\t%s\n' "${SRC_PKG}" "${1}" "${2}"
}
trap on_exit EXIT

echo Running npm "$@" > "$TMPFILE"

npm --quiet "$@" > $TMPFILE 2>&1
retval=$?

logfile=$(grep "npm ERR.*\.log" "$TMPFILE" | awk -F' ' '{print $3}')

while read -r line
do
  output_log info "$line"
done < "${TMPFILE}"

if [ -n "${logfile}" ]; then
  while read -r line
  do
    output_log debug "$line"
  done < "${logfile}"
fi
if [ -"$retval" -ne 0 ]; then
  output_log error STATUS_BUILD_FAILED
else
  output_log info STATUS_BUILD_SUCCESSFUL
fi

exit "$retval"