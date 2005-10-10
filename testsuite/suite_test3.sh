#!/bin/bash

. commons.sh

newUser
CMD="adduser --system --no-create-home $USER"
echo "Checking '$CMD'"

$CMD > /dev/null 2>&1

# expect:
#  - a new user $USER
#  - added to group nogroup
#  - no home directory /home/$USER

test_doesUserExist $USER
test_doesGroupExist nogroup

if [ -d /home/$USER ]; then
  echo "Found a homedirectory but I don't want one"
  echo "$0 failed"
  export FAILED=1
  exit
fi

  


