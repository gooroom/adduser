#!/usr/bin/perl -w
#

use strict;

use lib_test;

my $username = find_unused_username();

my $cmd = "adduser --system $username";


if (!defined (getpwnam($username))) {
	print "Testing $cmd...";
	`$cmd`;
	my $error = $?;
	if ($error) {
	  print "failed\n  adduser returned an errorcode != 0 ($error)\n";
	  exit $error;
	}
	`$cmd`;
	my $error = $?;
	if ($error) {
          print "failed\n double execution with same parameters showed an error (return code $error)\n";
	  exit $error;
	}

# expect:
#  - a new user $USER
#  - added to group nogroup
#  - a home directory

	assert(check_user_exist ($username,0));
	assert(check_homedir_exist ($username));
	print "ok\n";
}
  
