##
#
# requires outside this gem folder
#
require 'net/http'

##
#
# requires of this gem classes
#
require 'tessera/version'
require 'tessera/configuration'

require 'tessera/utils/errors'

require 'tessera/request'

##
#
# Main module of OTRS wrapper
#
# See 'tessera/configuration.rb' for more explanation how to set configuration
#
module Tessera
  class << self
    attr_accessor :configuration
  end

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
