#!/bin/bash

. commons.sh

newUser
CMD="adduser --disabled-login --gecos testuser $USER"
echo "Checking '$CMD'"

testfile="foo'bar"

touch /etc/skel/$testfile

$CMD > /dev/null 2>&1

# expect:
#  - a new user $USER
#  - added to group named $USER
#  - a home directory /home/$USER
#  - a file from /etc/skel named /home/$USER/$testfile

test_doesUserExist $USER
test_doesGroupExist $USER
test_checkHomeDir /home/$USER

test_DoesFileExist "/home/$USER/$testfile"

CMD="deluser --remove-home $USER "
echo "  Checking $CMD" 
$CMD #>/dev/null 2>&1

test_doesUserNotExist $USER
test_checkNoHomeDir /home/$USER
  


