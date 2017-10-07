##
#
# requires outside this gem folder
#
require 'net/http'
require 'json'

##
#
# requires of this gem classes
#
require 'tessera/version'
require 'tessera/configuration'

require 'tessera/utils/errors'

require 'tessera/request'

require 'tessera/api/session'
require 'tessera/api/ticket'

require 'tessera/model/base'
require 'tessera/model/session'
require 'tessera/model/ticket'

##
#
# Main module of OTRS wrapper
#
# See 'tessera/configuration.rb' for more explanation how to set configuration
#
module Tessera
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
