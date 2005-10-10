#!/bin/bash

userid_file="./userid"
user_prefix="testsuite"





######################################
# public interface #
####################

# Username
USER=""
USER_UID=0
USER_GID=0

# gid of the group we checked with test_doesGroupExist
GROUP_GID=0

function test_doesUserExist () {
  local user=$1
  if [ ! `grep $user /etc/passwd` ]; then
    echo "User $user doesn't exist"
    echo "$0 failed"
    exit 1
  fi
  USER_UID=`grep $user /etc/passwd | cut -d : -f 3`
  USER_GID=`grep $user /etc/passwd | cut -d : -f 4`
}

function test_doesUserNotExist () {
  local user=$1
  if [ `grep $user /etc/passwd` ]; then
    echo "User $user doesn't exist"
    echo "$0 failed"
    exit 1
  fi
}


function test_doesGroupExist () {
  local group=$1
  if [ ! `grep $group /etc/group` ]; then
    echo "group $group does not exist"
    echo "$0 failed"
    exit 1
  fi
  GROUP_GID=`grep $group /etc/group | cut -d : -f 3`
}

function test_checkHomeDir () {
  local dir=$1
  if [ ! -d $dir ]; then
    echo "  homedirectory $dir does not exist"
    echo "  $0 failed"
    exit 1
  fi
  local uid=`stat -c %u $dir`
  local gid=`stat -c %g $dir`
  if [ $uid != $USER_UID ]; then
    echo "  homedir has not the right owner permissions"
    echo "  $0 failed"
    exit 1
  fi
  if [ $gid != $USER_GID ]; then
    echo "  homedir has not the right group permissions"
    echo "  $0 failed"
    exit 1
  fi
}

function test_DoesFileExist () {
  local file=$1
  if [ ! -e $file ]; then
    echo "  file $file does not exist"
    echo "  $0 failed"
    exit 1
  fi
}


function test_checkNoHomeDir () {
  local dir=$1
  if [ -d $dir ]; then
    echo "  homedir $dir exists, but it shouldn't"
    echo "  $0 failed"
    exit 1
  fi
}

# parameter: lower boundary ( > 0)
# find the lowest new used uid > $1
function getUnusedUID () {
  local uid=0
  let "uid=$1-1"
  local available=`cat /etc/passwd | cut -d : -f 3 | sort -g | tr "\n" " "`
  local used=1
  while [ $used == 1 ]; do
    used=0
    let "uid=$uid+1"
    for i in $available; do
      if [ $i == $uid ]; then
	used=1
      fi
    done
  done
  getUnusedUID_uid=$uid 
}

function newUser() {
  local id=`cat $userid_file`
  let "id = $id+1"
  echo $id > $userid_file
  USER="$user_prefix$id"
}


