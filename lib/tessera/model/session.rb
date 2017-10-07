module Tessera
  module Model
    class Session < Base
      attr_accessor :session_id

      def parse_attributes
        @session_id = parsed_body['SessionID']
      end
    end
  end
end
