# Class: phishingservers
#
# This module manages phishingservers
#
# Parameters: 
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class phishingservers (
  #$example = $phishingservers::params::example,
  $userdomain = $phishingservers::params::userdomain,
  $apacheadmingroup = $phishingservers::params::apacheadmingroup,
  $sudoersgroup = $phishingservers::params::sudoersgroup,

) inherits phishingservers::params {

}
