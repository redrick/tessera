##
#
# Parsed Response class
#
# provides easy access to response methods and usefull data like:
#
# state (HTTP states)
# body (raw body of response)
# (put other method names here) TODO
#
module Tessera
  class Response
    def initialize(response)
      @response = response
    end

    def state
      response.state
    end

    def body
      response.body
    end
  end
end
