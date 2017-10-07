##
#
# Request class
#
# Methods acepted:
#   GET
#   POST
#   PATCH
#
# (basically it uses Net::HTTP, but other methods are not supported by API anyway...)
#
# Endpoint is based on you yaml setting
# You can find a template in templates directory here in repository
#
# Body gets assembled in (put name of class here) class :) (not here yet) TODO
#
# return value is Net::HTTPResponse which has to be parsed TODO (put name of class here)
#
module Tessera
  class Request
    def initialize(method, endpoint, body)
      @method = method
      @endpoint = endpoint
      @body = body
    end

    def send
      net_http_send
      # Response.new(net_http_send)
    end

    protected

    def net_http_send
      uri = URI("#{Tessera.configuration.base_url}#{@endpoint}")

      request = net_http_class.new(uri)
      headers.each { |k, v| request[k] = v }
      request.body = @body.to_json

      Net::HTTP.start(uri.hostname, uri.port) do |http|
        # Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end
    end

    def net_http_class
      Kernel.const_get("Net::HTTP::#{@method.capitalize}")
    end

    def headers
      {
        'Accept-Encoding' => 'application/json',
        'Content-Type' => 'application/json'
      }
    end
  end
end
