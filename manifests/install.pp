class shared-phishing-server::install inherits shared-phishing-server {
  include apt
  include apache
  include puppet-pbis::join
 
  exec { 'phish-update-apt':
    command => '/usr/bin/apt-get update',
    refreshonly => true,
  }

#  package { 'apache2' :
#    #require => Class['shared-phishing-server::setup'],
#    ensure => installed,
#    provider => apt,
#  }

}
