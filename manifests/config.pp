class shared-phishing-server::config inherits shared-phishing-server {
  include apt
  class { 'apache': mpm_module => 'prefork',}
  class { 'apache::mod::php': }
  class { 'apache::mod::ssl': }
  class { 'apache::mod::rewrite': }

  apache::listen { '80': }
  apache::listen { '443': }

  $lastoct = getlastoct()
  $hostip = "168.215.65.$lastoct"

  $blankvhost = "<html></html>"
  file { '/var/www/html/index.html' :
    require => Class['shared-phishing-server::install'],
    notify => Service['apache2'],
    ensure => present,
    owner => root,
    group => root,
    mode => '0644',
    content => $blankvhost,
  }

  $includelocalvhosts = 'IncludeOptional "/usr/local/src/apache2/sites-enabled/*.conf"
'

  file { '/usr/local/src/apache2/' :
    ensure => directory,
    owner => root,
    group => root,
    mode => '0664',
  }

  $userdomain_uc = upcase($userdomain)
  $apacheadmingroup_dc = downcase($apacheadmingroup)

  file { '/usr/local/src/apache2/sites-enabled/' :
    ensure => directory,
    owner => root,
    group => "$userdomain_uc\\$apacheadmingroup_dc",
    mode => '0666',
  }

  file { '/etc/apache2/sites-enabled/includelocal.conf' :
    require => Class['shared-phishing-server::install'],
    notify => Service['apache2'],
    ensure => present,
    owner => root,
    group => root,
    mode => '0644',
    content => $includelocalvhosts,
  }

  apache::vhost { $hostip:
    servername => $hostip,
    port    => '80',
    docroot => '/var/www/html',
    ssl     => false,
  }

$sudofile="#
# This file MUST be edited with the visudo command as root.
#
# Please consider adding local content in /etc/sudoers.d/ instead of
# directly modifying this file.
#
# See the man page for details on how to write a sudoers file.
#
Defaults        env_reset
Defaults        mail_badpass
Defaults        secure_path=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\"

# Host alias specification

# User alias specification

# Cmnd alias specification

# User privilege specification
root    ALL=(ALL:ALL) ALL

# Members of the admin group may gain root privileges
%admin ALL=(ALL) ALL

# Allow members of group sudo to execute any command
%sudo   ALL=(ALL:ALL) ALL

#Domain Admins
%$userdomain\\\\$sudoersgroup        ALL=(ALL:ALL) ALL
#apache admins
%$userdomain\\\\$apacheadmingroup        ALL=(ALL:ALL) /etc/init.d/apache2

# See sudoers(5) for more information on #include directives:

#includedir /etc/sudoers.d
"

  file { '/etc/sudoers' :
    ensure => present,
    owner => root,
    group => root,
    mode => '0440',
    content => "$sudofile"
  }

  $motdcont="Welcome to OptivLabs Phishing Engagment Server

Place your apache configs in /usr/local/src/apache2/sites-enabled/
and remove them when engagement is over,
be sure to include the Listen directive.
Files must end in .conf to take effect.
The internal DNS for this server is $hostname.$domain
The internal IP for this server is $ipaddress_eth0
The NAT external IP for this server is $hostip
"
  file { '/etc/motd' :
    ensure => present,
    owner => root,
    group => root,
    mode => '0644',
    content => $motdcont,
  }

}
