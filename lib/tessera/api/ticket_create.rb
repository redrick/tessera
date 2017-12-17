##
#
#
#
module Tessera
  module Api
    class TicketCreate
      def initialize(body_content)
        @body = body.merge(body_content)
      end

      def self.call(body_content)
        new(body_content).call
      end

      def call
        response = Tessera::Request.new(:POST, 'Ticket', @body).send
        JSON.parse(response.body)
      end

      def session_id
        session = Session.create
        # TODO: solve token creation failure with error
        session.session_id
      end

      private

      def body
        {
          SessionID: session_id
        }
      end
    end
  end
end
