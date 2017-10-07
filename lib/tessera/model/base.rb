module Tessera
  module Model
    class Base
      attr_accessor :response, :errors, :code

      def initialize(response)
        @response = response
        @code = @response.code
        parse_errors
        parse_attributes
      end

      protected

      def parse_errors
        @errors = parsed_body['Error']
      end

      def parsed_body
        JSON.parse(@response.body)
      end

      def parse_attributes
        raise NotImplementedError, 'Model must implement attribute mapping'
      end
    end
  end
end
