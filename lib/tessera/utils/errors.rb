##
#
# Collection of errors used in this library
#
module Tessera
  class Error < StandardError; end

  class ConfigNotSet < Error
    def initialize(param)
      msg = "Please check if you set #{param}, seems it is missing."
      super(msg)
    end
  end
end
