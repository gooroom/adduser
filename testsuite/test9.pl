#!/usr/bin/perl -w
#

use strict;

use lib_test;

my $error;
my $groupname = find_unused_groupname();
my $cmd = "addgroup $groupname";

if (!defined (getgrnam($groupname))) {
	print "Testing $cmd... ";
	`$cmd`;
	my $error = ($?>>8);
	if ($error) {
	  print "failed\n  $cmd returned an errorcode != 0 ($error)\n";
	  exit $error;
	}
	assert(check_group_exist ($groupname));

	print "ok\n";
}

# now testing whether adding the group again fails as it should

print "Testing $cmd... ";
`$cmd`;
$error = ($?>>8);
if ($error ne 1) {
  print "failed\n  $cmd returned an errorcode != 1 ($error)\n";
  exit 1;
}
print "ok\n";

# now testing whether adding the group again (as a system group)
# fails as it should (#405905)

$cmd = "addgroup --system $groupname";
print "Testing $cmd... ";
`$cmd`;
$error = ($?>>8);
if ($error ne 1) {
  print "failed\n  $cmd returned an errorcode != 1 ($error)\n";
  exit $error;
}
print "ok\n";

my $sysgroupname = find_unused_groupname();
$cmd = "addgroup --system $sysgroupname";

if (!defined (getgrnam($sysgroupname))) {
	print "Testing $cmd... ";
	`$cmd`;
	$error = ($?>>8);
	if ($error) {
	  print "failed\n  $cmd returned an errorcode != 0 ($error)\n";
	  exit $error;
	}
	assert(check_group_exist ($sysgroupname));

	print "ok\n";
}

# now testing whether adding the group again passes as it should
# ("already exists as a system group")

print "Testing $cmd... ";
`$cmd`;
$error = ($?>>8);
if ($error) {
  print "failed\n  $cmd returned an errorcode != 0 ($error)\n";
  exit $error;
}
print "ok\n";

# now testing whether adding the group again (as a normal group)
# fails as it should

$cmd = "addgroup $sysgroupname";
print "Testing $cmd... ";
`$cmd`;
$error = ($?>>8);
if ($error ne 1) {
  print "failed\n  $cmd returned an errorcode != 1 ($error)\n";
  exit 1;
}
print "ok\n";

