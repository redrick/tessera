##
#
#
#
module Tessera
  module Api
    class TicketGet
      def initialize(ticket_id)
        @ticket_id = ticket_id
      end

      def self.call(ticket_id)
        new(ticket_id).call
      end

      def call
        response = Tessera::Request.new(:GET, "Ticket/#{@ticket_id}", body).send
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
          TicketID: @ticket_id,
          SessionID: session_id
        }
      end
    end
  end
end
