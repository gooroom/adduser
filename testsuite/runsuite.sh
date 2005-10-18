#!/bin/bash

FAILED=0

if [ "$(id -u)" != "0" ]; then
  echo "root needed"
  exit 1
fi

echo "Starting test suite"
for i in ./suite*.sh ; do
  sh $i
  if [ "$?" != "0" ]; then
    FAILED=1
  fi
done

if [ "$FAILED" = "0" ]; then
  echo "All tests passed successfully"
else
  echo "Some tests failed"
fi

exit $FAILED
