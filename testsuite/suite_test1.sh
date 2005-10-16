#!/bin/bash

. commons.sh

newUser
CMD="adduser --system $USER"
echo "Checking '$CMD'"

$CMD > /dev/null 2>&1

# expect:
#  - a new user $USER
#  - added to group nogroup
#  - a home directory /home/$USER

test_doesUserExist $USER
test_doesGroupExist nogroup
test_checkHomeDir /home/$USER

CMD="deluser --remove-home $USER "
echo "  Checking $CMD"
result=`$CMD 2>&1`

if echo $result | grep -q  perl-modules ; then
  echo "  Disabling check for removed homedir, because File::Find is not present"
else
  test_checkNoHomeDir /home/$USER
fi

test_doesUserNotExist $USER


