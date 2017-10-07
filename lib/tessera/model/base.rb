module Tessera
  module Model
    class Base
      attr_accessor :response, :errors, :code

      def initialize(response)
        @response = response
        @code = @response.code
        parse_errors if parsed_body
        parse_attributes if parsed_body
      end

      protected

      def parse_errors
        @errors = parsed_body['Error']
      end

      def parsed_body
        JSON.parse(@response.body) if @response.body
      end

      def parse_attributes
        raise NotImplementedError, 'Model must implement attribute mapping'
      end
    end
  end
end
