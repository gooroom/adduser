#!/usr/bin/perl -w
#

use strict;

use lib_test;

my $username = find_unused_username(); 
my $cmd = "adduser --gecos test --disabled-password --add_extra_groups $username";

my %config;

preseed_config(("/etc/adduser.conf"),\%config);

if (!defined (getpwnam($username))) {
	print "Testing $cmd... ";
	`$cmd`;
	my $error = $?;
	if ($error) {
	  print "failed\n  adduser returned an errorcode != 0 ($error)\n";
	  exit $error;
	}
	assert(check_user_exist ($username));

        foreach my $group (split ' ', $config{"extra_groups"}) {
          assert(check_user_in_group($username,$group));
        }
	print "ok\n";
}

my $newgroup = find_unused_username();

$cmd = "addgroup $newgroup";
unless (defined getgrnam($newgroup)) {
        print "Testing $cmd... ";
        `$cmd`;
        my $error = $?;
        if ($error) {
            print "failed\n  addgroup returned an errorcode != 0 ($error)\n";
            exit $error;
        }
        assert(check_group_exist ($newgroup));
        print "ok\n";
}

$cmd = "adduser $username $newgroup";
if (defined (getpwnam($username))) {
   print "Testing $cmd... ";
   `$cmd`;
   my $error = $?;
   if ($error) {
     print "failed\n  adduser returned an errorcode != 0 ($error)\n";
     exit $error;
   }
   assert(check_user_in_group ($username,$newgroup));
   print "ok\n";
}

$cmd = "deluser --remove-home $username";
if (defined (getpwnam($username))) {
	print "Testing $cmd... ";
	`$cmd`;
	my $error = $?;
	if ($error) {
	  print "failed\n  adduser returned an errorcode != 0 ($error)\n";
	  exit $error;
	}
	assert(check_user_not_exist ($username));
	print "ok\n";
}

$cmd = "delgroup $newgroup";
unless (!defined getgrnam($newgroup)) {
        print "Testing $cmd... ";
        `$cmd`;
        my $error = $?;
        if ($error) {
            print "failed\n  delgroup returned an errorcode != 0 ($error)\n";
            exit $error;
        }
        assert(!check_group_exist ($newgroup));
        print "ok\n";
}

my $sysusername = find_unused_username(); 
$cmd = "adduser --system --gecos test --disabled-password --add_extra_groups $sysusername";

if (!defined (getpwnam($sysusername))) {
	print "Testing $cmd... ";
	`$cmd`;
	my $error = $?;
	if ($error) {
	  print "failed\n  adduser returned an errorcode != 0 ($error)\n";
	  exit $error;
	}
	assert(check_user_exist ($sysusername));

        foreach my $group (split ' ', $config{"extra_groups"}) {
          assert(!check_user_in_group($username,$group));
        }
	print "ok\n";
}
