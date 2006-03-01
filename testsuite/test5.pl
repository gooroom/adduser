#!/usr/bin/perl -w
#

use strict;

use lib_test;

my $groupname = "nogroup";
my $username = find_unused_username();
my $want_uid = find_unused_uid("system");

my $cmd = "adduser --system --uid $want_uid $username";


if (!defined (getpwnam($username))) {
	print "Testing $cmd... ";
	`$cmd`;
	my $error = $?;
	if ($error) {
	  print "failed\n  adduser returned an errorcode != 0 ($error)\n";
	  exit $error;
	}

# expect:
#  - a new user $USER with uid $want_uid
#  - added to group nogroup
#  - a home directory /home/$USER

	assert(check_user_exist ($username, $want_uid));
	assert(check_homedir_exist ($username));
	assert(check_group_exist($groupname));
	assert(check_user_in_group($username,$groupname));
	print "ok\n";
}
  
