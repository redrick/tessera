##
#
# This is configuration class that allows you to set your config like so:
#
# Tessera.configure do |config|
#   config.username = 'jon'
#   config.password = 'SuperSecret'
#   config.base_url = 'https://otrs.com/otrs/nph-genericinterface.pl/Webservice/rest/'
# end
#
# or
#
# by simply assigning params by themself:
#
# config = Tessera::Configuration.new
# config.username = 'jon'
# config.password = 'SuperSecret'
# config.base_url = 'https://otrs.com/otrs/nph-genericinterface.pl/Webservice/rest/'
# Tessera.configuration = config
#
module Tessera
  class Configuration
    attr_writer :username, :password, :base_url

    def initialize
      @username = nil
      @password = nil
      @base_url = nil
    end

    def username
      raise ConfigNotSet, 'username' unless @username
      @username
    end

    def password
      raise ConfigNotSet, 'password' unless @password
      @password
    end

    def base_url
      raise ConfigNotSet, 'base_url' unless @base_url
      @base_url
    end
  end
end
