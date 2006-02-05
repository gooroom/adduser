#!/bin/bash

. commons.sh

newUser

getUnusedUID 100
id=$getUnusedUID_uid

test_doesGroupExist "nogroup"
gid=$GROUP_GID


CMD="adduser --system --uid $id --gid $gid --home /var/$USER $USER"
echo "Checking '$CMD'"

$CMD > /dev/null 2>&1

# expect:
#  - a new user $USER with a uid of $uid and the gid of nogroup
#  - added to group nogroup
#  - a home directory /var/$USER

test_doesUserExist $USER

if [ "$id" != "$USER_UID" ]; then
  echo "haven't got the specified UID $id (but $USER_UID)"
  echo "$0 failed"
  exit 1
fi


test_doesGroupExist nogroup
if [ "$gid" != "$GROUP_GID" ]; then
  echo "  gid does not match the given one"
  echo "  $0 failed"
  exit 1
fi


test_checkHomeDir /var/$USER

  


