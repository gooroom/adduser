#!/bin/bash

. commons.sh

newUser
CMD="adduser --disabled-login --gecos testuser $USER"
echo "Checking '$CMD'"

$CMD > /dev/null 2>&1

# expect:
#  - a new user $USER
#  - added to group named $USER
#  - a home directory /home/$USER
#  - a file from /etc/skel named /home/$USER/$testfile

test_doesUserExist $USER
test_doesGroupExist $USER
test_checkHomeDir /home/$USER


CMD="deluser --remove-home --backup $USER "
echo "  Checking $CMD" 
result=`$CMD 2>&1`

test_doesUserNotExist $USER

if echo $result | grep -q perl-modules ; then
  echo "  Disabling check, because File::Find is not present"
  echo "  Please install perl-modules for proper checking" 
  
else
  test_checkNoHomeDir /home/$USER

  if [ -e /usr/bin/bzip2 ]; then
    BACKUP_FILE="./$USER.tar.bz2"
  elif [ -e /bin/gzip ]; then
    BACKUP_FILE="./$USER.tar.gz"
  else
    BACKUP_FILE="./$USER.tar"
  fi
  test_DoesFileExist $BACKUP_FILE

  rights=`stat -c "%a" $BACKUP_FILE`
  if [ "$rights" -ne "600" ]; then
    echo "  backup file has wrong permissions >$rights<"
    echo "  $0 failed"
    exit 1
  fi

  rights=`stat -c "%u:%g" $BACKUP_FILE`
  if [ "$rights" != "0:0" ]; then
    echo "  backup file has wrong permissions >$rights<"
    echo "  $0 failed"
    exit 1
  fi
fi
  
rm $BACKUP_FILE  


