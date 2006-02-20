#!/usr/bin/perl -w

use strict;


sub assert {
  my ($cond) = @_;
  if ($cond) {
    print "Test failed; aborting test suite\n";
    exit $cond;
  }
}

sub check_user_exist {
  my ($username,$uid) = @_;
  
  my @ent = getpwname ($username);
  if (!@ent) {
	print "user $username does not exist\n";
	exit 1;
  }
  if ((defined($uid)) && ($ent[2] == $uid)) {
	print "uid $uid does not match %s",$ent[2];
	return 1;
  }
  return 0;
}

sub check_homedir_exist {
  my ($username) = @_;
  my $dir = (getpwnam($username))[7];
  if (! -f $dir) {
    print "check_homedir: there's no home directory $dir\n";
    return 1;
  }
  return 0;
}

sub check_group_exist {
  my ($groupname) = @_;
  if (!defined(getgrnam($groupname))) {
    print "check_group_exist: Group $groupname does not exist\n";
    return 1;
  }
  return 0;
}

return 1
