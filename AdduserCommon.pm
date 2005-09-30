use vars qw(@EXPORT $VAR1);


# Common functions that are used in adduser and deluser
# Copyright (C) 2000 Roland Bauerschmidt <rb@debian.org>

# Most of the functions are adopted from the original adduser
# Copyright (C) 1997, 1998, 1999 Guy Maor <maor@debian.org>
# Copyright (C) 1995 Ted Hajek <tedhajek@boombox.micro.umn.edu>
#                     Ian A. Murdock <imurdock@gnu.ai.mit.edu>
#

@EXPORT = qw(invalidate_nscd _ dief warnf read_config get_users_groups get_group_members s_print s_printf systemcall);

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
    my $nscdpid = "/var/run/nscd.pid";
    # this function replaces startnscd and stopnscd (closes: #54726)
    if(defined($nscd) && -f $nscdpid)
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

sub _ {
    return gettext(@_);
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
    my ($conf_file, %config) = @_;
    my ($var, $lcvar, $val);

    if (! -f $conf_file) {
	printf _("%s: %s doesn't exist.  Using defaults.\n"),$0,$conf_file if $verbose;
	return;
    }

    open (CONF, $conf_file) || dief("%s: %s\n",$conf_file,$!);
    while (<CONF>) {
	chomp;
	next if /^#/ || /^\s*$/;

	if ((($var, $val) = /^\s*(\S+)\s*=\s*(.*)/) != 2) {
	    warnf(_("Couldn't parse %s:%s.\n"),$conf_file,$.);
	    next;
	}
	$lcvar = lc $var;
	if (!defined($config{$lcvar})) {
	    warnf(_("Unknown variable `%s' at %s:%s.\n"),$var,$conf_file,$.);
	    next;
	}

	$val =~ s/^"(.*)"$/$1/;
	$val =~ s/^'(.*)'$/$1/;

	$config{$lcvar} = $val;
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
    printf(@_)
	if($verbose);
}

sub d_printf
{
    printf(@_)
    	if((defined($verbose) && $verbose > 1) || (defined($debugging) && $debugging == 1));
}

sub systemcall {
    my $c = join(' ', @_);
    print "$c\n" if $verbose==2;
    if (system(@_)) {
        die("$0: `$c' returned error code " . ($?>>8) . ".  Aborting.\n")
          if ($?>>8);
        die("$0: `$c' exited from signal " . ($?&255) . ".  Aborting.\n");
    }
}

# preseed the configuration variables 
# then read the config file /etc/adduser and overwrite the data hardcoded here
sub preseed_config {
  my $default_configuration = $1;
  my %config;
  $config{"system"} = 0;
  $config{"only_if_empty"} = 0;
  $config{"remove_home"} = 0;
  $config{"home"} = "";
  $config{"remove_all_files"} = 0;
  $config{"backup"} = 0;
  $config{"backup_to"} = ".";
  $config{"dshell"} = "/bin/bash";
  $config{"first_system_uid"} = 100;
  $config{"last_system_uid"} = 999;
  $config{"first_uid"} = 1000;
  $config{"last_uid"} = 29999;
  $config{"first_system_gid"} = 100;
  $config{"last_system_gid"} = 999;
  $config{"first_gid"} = 1000;
  $config{"last_gid"} = 29999;
  $config{"dhome"} = "/home";
  $config{"skel"} = "/etc/skel";
  $config{"usergroups"} = "yes";
  $config{"users_gid"} = "100";
  $config{"grouphomes"} = "no";
  $config{"letterhomes"} = "no";
  $config{"quotauser"} = "";
  $config{"dir_mode"} = "0755";
  $config{"setgid_home"} = "no";
  $config{"no_del_paths"} = "^/$ ^/lost+found/.* ^/media/.* ^/mnt/.* ^/etc/.* ^/bin/.* ^/boot/.* ^/dev/.* ^/lib/.* ^/proc/.* ^/root/.* ^/sbin/.* ^/tmp/.* ^/sys/.* ^/srv/.* ^/opt/.* ^/initrd/.* ^/usr/.* ^/var/.*";
  $config{"name_regex"} = "^[a-z][-a-z0-9]*\$";

  read_config($default_configuration,%config);
  return %config;
}

# Local Variables:
# mode:cperl
# End:
