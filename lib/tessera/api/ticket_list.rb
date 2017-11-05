##
#
#
#
module Tessera
  module Api
    class TicketList
      def self.call(ticket_ids)
        new(ticket_ids).call
      end

      def initialize(ticket_ids)
        @ticket_ids = ticket_ids
      end

      def call
        response = Tessera::Request.new(:GET, 'TicketList', body).send
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
          TicketID: @ticket_ids,
          SessionID: session_id
        }
      end
    end
  end
end
