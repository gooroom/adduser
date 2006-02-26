#!/usr/bin/perl -w
#

use strict;

use lib_test;

my $groupname = "nogroup";
my $username = find_unused_username();
my $homedir = "/var/$username";
my $cmd = "adduser --system --home $homedir $username";


if (!defined (getpwnam($username))) {
	print "Testing $cmd...";
	`$cmd`;
	my $error = $?;
	if (!$error) {
	  print "failed\n  adduser returned an errorcode != 0 ($error)\n";
	  exit $error;
	}
	assert(check_user_exist ($username));
	assert(check_homedir_exist($username,$homedir));	
	assert(check_group_exist($groupname));
	assert(check_user_in_group ($username,$groupname));
	print "ok\n";
}
  
