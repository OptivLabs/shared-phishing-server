# shared-phishing-server #

Puppet module to create a shared access phishing server on Ubuntu 14.04

Depends on https://github.com/walkerk1980/puppet-pbis unless you fork and fix syntax in config.pp to match non domain group names as below.  This will need to be done in a few places obviously and then you can comment out 'include puppet-pbis::join' in init.pp.

before:
    group => "$userdomain_uc\\$apacheadmingroup_dc",
after:
    group => "$apacheadmingroup_dc",
