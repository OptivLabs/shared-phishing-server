class phishingservers::install inherits phishingservers {
  include apt
  include apache
  include puppet-pbis::join
 
  exec { 'phish-update-apt':
    command => '/usr/bin/apt-get update',
    refreshonly => true,
  }

#  package { 'apache2' :
#    #require => Class['phishingservers::setup'],
#    ensure => installed,
#    provider => apt,
#  }

}
