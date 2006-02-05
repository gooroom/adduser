#!/bin/bash

. commons.sh

newUser

getUnusedUID 100
id=$getUnusedUID_uid

test_doesGroupExist "nogroup"
gid=$GROUP_GID

OTHERHOME=/var/otherhome
mkdir -p $OTHERHOME
let "owner=$id-1"
let "group=$gid-1"
chown $owner:$group $OTHERHOME

CMD="adduser --system --uid $id --gid $gid --home $OTHERHOME $USER"
echo "Checking '$CMD'"

result=`$CMD 2>&1`
#echo $result

# expect:
#  - a new user $USER with a uid of $uid and the gid of nogroup
#  - added to group nogroup
#  - a warning that the home directory belongs to another user

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

echo $result | grep -q -i Warning
warnings=$?

if [ "$warnings" -ne 0 ]; then
  echo "  no warning occured when giving an already existing homedir with wrong owner"
  echo "  $0 failed"
  exit 1
fi

rm -rf "$OTHERHOME"


