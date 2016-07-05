# Class: shared-phishing-server
#
# This module manages shared-phishing-server
#
# Parameters: 
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class shared-phishing-server (
  #$example = $shared-phishing-server::params::example,
  $userdomain = $shared-phishing-server::params::userdomain,
  $apacheadmingroup = $shared-phishing-server::params::apacheadmingroup,
  $sudoersgroup = $shared-phishing-server::params::sudoersgroup,

) inherits shared-phishing-server::params {

}
