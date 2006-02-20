use vars qw(@EXPORT $VAR1);


# Common functions that are used in adduser and deluser
# Copyright (C) 2000 Roland Bauerschmidt <rb@debian.org>

# Most of the functions are adopted from the original adduser
# Copyright (C) 1997, 1998, 1999 Guy Maor <maor@debian.org>
# Copyright (C) 1995 Ted Hajek <tedhajek@boombox.micro.umn.edu>
#                     Ian A. Murdock <imurdock@gnu.ai.mit.edu>
#

@EXPORT = qw(invalidate_nscd gtx dief warnf read_config get_users_groups get_group_members s_print s_printf systemcall);

sub invalidate_nscd {
    # Check if we need to do make -C /var/yp for NIS
    my $nisconfig;
    if(-f "/etc/default/nis") {
        $nisconfig = "/etc/default/nis";
    } elsif(-f "/etc/init.d/nis") {
        $nisconfig = "/etc/init.d/nis";
    }
    if(defined($nisconfig) && -f "/var/yp/Makefile" &&
        -x "/usr/bin/rpcinfo" && grep(/ypserv/, qx{/usr/bin/rpcinfo -p})) {
	open(NISCONFIG, "<$nisconfig");
	if(grep(/^NISSERVER=master/, <NISCONFIG>)) {
            system("make", "-C", "/var/yp");
	}
	close(NISCONFIG);
    }
 
    # Check if we need to invalidate the NSCD cache
    my $nscd;
    if(-e "/usr/sbin/nscd") {
        $nscd = "/usr/sbin/nscd";
    } elsif(-e "/usr/bin/nscd") {
        $nscd = "/usr/bin/nscd";
    }
    # this function replaces startnscd and stopnscd (closes: #54726)
    # We are ignoring any error messages given by nscd here since we
    # cannot expect the nscd maintainer and upstream to document their
    # interfaces. See #330929.
    if(defined($nscd) && -x $nscd)
      {
	    my $table = shift;
	    if ($table)
	      {
	        system ($nscd, "-i", $table);
	      }
	    else
	      {
	        # otherwise we invalidate passwd and group table
	        system ($nscd, "-i", "passwd");
	        system ($nscd, "-i", "group");
	      }
      }
}

sub gtx {
    return gettext( shift );
}

sub dief {
    my ($form,@argu)=@_;
    printf STDERR "$0: $form",@argu;
    exit 1;
}

sub warnf {
    my ($form,@argu)=@_;
    printf STDERR "$0: $form",@argu;
}

# parse the configuration file
# parameters:
#  -- filename of the configuration file
#  -- a hash for the configuration data
sub read_config {
    my ($conf_file, $configref) = @_;
    my ($var, $lcvar, $val);

    if (! -f $conf_file) {
	printf gtx("%s: `%s' doesn't exist.  Using defaults.\n"),$0,$conf_file if $verbose;
	return;
    }

    open (CONF, $conf_file) || dief ("%s: `%s'\n",$conf_file,$!);
    while (<CONF>) {
	chomp;
	next if /^#/ || /^\s*$/;

	if ((($var, $val) = /^\s*([_a-zA-Z0-9]+)\s*=\s*(.*)/) != 2) {
	    warnf gtx("Couldn't parse `%s':%s.\n"),$conf_file,$.;
	    next;
	}
	$lcvar = lc $var;
	if (!defined($configref->{$lcvar})) {
	    warnf gtx("Unknown variable `%s' at `%s':%s.\n"),$var,$conf_file,$.;
	    next;
	}

	$val =~ s/^"(.*)"$/$1/;
	$val =~ s/^'(.*)'$/$1/;

	$configref->{$lcvar} = $val;
    }

    close CONF || die "$!";
}

# return a user's groups
sub get_users_groups {
    my($user) = @_;
    my($name,$members,@groups);
    setgrent;
    while (($name,$members) = (getgrent)[0,3]) {
	for (split(/ /, $members)) {
	    if ($user eq $_) {
		push @groups, $name;
		last;
	    }
	}
    }
    endgrent;
    @groups;
}

# return a group's members
sub get_group_members
  {
      my $group = shift;
      my @members;
      foreach (split(/ /, (getgrnam($group))[3])) {
	  if( getpwnam($_) ) {
	      push @members, $_;
	  }
      }
      return @members;
  }

sub s_print
{
    print join(" ",@_)
	if($verbose);
}

sub s_printf
{
    printf @_
	if($verbose);
}

sub d_printf
{
    printf @_
    	if((defined($verbose) && $verbose > 1) || (defined($debugging) && $debugging == 1));
}

sub systemcall {
    my $c = join(' ', @_);
    print ("$c\n") if $verbose==2;
    if (system(@_)) {
        die ("$0: `$c' returned error code " . ($?>>8) . ".  Aborting.\n")
          if ($?>>8);
        die ("$0: `$c' exited from signal " . ($?&255) . ".  Aborting.\n");
    }
}

# preseed the configuration variables 
# then read the config file /etc/adduser and overwrite the data hardcoded here
sub preseed_config {
  my ($conflistref, $configref) = @_;
  $configref->{"system"} = 0;
  $configref->{"only_if_empty"} = 0;
  $configref->{"remove_home"} = 0;
  $configref->{"home"} = "";
  $configref->{"remove_all_files"} = 0;
  $configref->{"backup"} = 0;
  $configref->{"backup_to"} = ".";
  $configref->{"dshell"} = "/bin/bash";
  $configref->{"first_system_uid"} = 100;
  $configref->{"last_system_uid"} = 999;
  $configref->{"first_uid"} = 1000;
  $configref->{"last_uid"} = 29999;
  $configref->{"first_system_gid"} = 100;
  $configref->{"last_system_gid"} = 999;
  $configref->{"first_gid"} = 1000;
  $configref->{"last_gid"} = 29999;
  $configref->{"dhome"} = "/home";
  $configref->{"skel"} = "/etc/skel";
  $configref->{"usergroups"} = "yes";
  $configref->{"users_gid"} = "100";
  $configref->{"grouphomes"} = "no";
  $configref->{"letterhomes"} = "no";
  $configref->{"quotauser"} = "";
  $configref->{"dir_mode"} = "0755";
  $configref->{"setgid_home"} = "no";
  $configref->{"no_del_paths"} = "^/$ ^/lost+found/.* ^/media/.* ^/mnt/.* ^/etc/.* ^/bin/.* ^/boot/.* ^/dev/.* ^/lib/.* ^/proc/.* ^/root/.* ^/sbin/.* ^/tmp/.* ^/sys/.* ^/srv/.* ^/opt/.* ^/initrd/.* ^/usr/.* ^/var/.*";
  $configref->{"name_regex"} = "^[a-z][-a-z0-9]*\$";
  $configref->{"exclude_fstypes"} = "(proc|sysfs|usbfs|devpts|tmpfs)";

  foreach( @$conflistref ) {
      read_config($_,$configref);
  }
}

# Local Variables:
# mode:cperl
# End:
