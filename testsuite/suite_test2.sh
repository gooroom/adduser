#!/bin/bash

. commons.sh

newUser
CMD="adduser --system --home /var/$USER $USER"
echo "Checking '$CMD'"

$CMD > /dev/null 2>&1

# expect:
#  - a new user $USER
#  - added to group nogroup
#  - a home directory /home/$USER

test_doesUserExist $USER
test_doesGroupExist nogroup
test_checkHomeDir /var/$USER

  


