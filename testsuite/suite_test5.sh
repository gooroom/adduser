#!/bin/bash

. commons.sh

newUser

getUnusedUID 100
id=$getUnusedUID_uid

CMD="adduser --system --uid $id --home /var/$USER $USER"
echo "Checking '$CMD'"

$CMD > /dev/null 2>&1

# expect:
#  - a new user $USER with a uid of $uid
#  - added to group nogroup
#  - a home directory /var/$USER

test_doesUserExist $USER

if [ "$id" != "$USER_UID" ]; then
  echo "haven't got the specified UID $id (but $USER_UID)"
  echo "$0 failed"
  exit 1
fi


test_doesGroupExist nogroup
test_checkHomeDir /var/$USER

  


