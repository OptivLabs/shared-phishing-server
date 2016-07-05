module Puppet::Parser::Functions
  newfunction(:getlastoct, :type => :rvalue) do |args|
    #lookupvar('ipaddress').to_s
    lookupvar('ipaddress_eth0').slice(-lookupvar('ipaddress_eth0').reverse.index(".")..13)
  end
end


