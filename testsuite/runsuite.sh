#!/bin/bash

FAILED=0

PASSWD_BAK="./passwd.backup"


if [ "$(id -u)" != "0" ]; then
  echo "root needed"
  exit 1
fi

cp /etc/passwd $PASSWD_BAK

for i in ./test*.pl ; do
  echo
  echo "Starting $i"
  /usr/bin/perl $i
  if [ "$?" != "0" ]; then
    FAILED=1
  fi
done

if [ "$FAILED" = "0" ]; then
  echo "All tests passed successfully"
  rm $PASSWD_BAK
else
  echo "Some tests failed"
  echo "see $PASSWD_BAK for a copy of /etc/passwd before starting"
fi

exit $FAILED
