##
# Class for searching through tickets
#  as params hash any of these in official docs could be used:
#  http://doc.otrs.com/doc/api/otrs/5.0/Perl/Kernel/GenericInterface/Operation/Ticket/TicketSearch.pm.html
#
module Tessera
  module Api
    class TicketSearch
      def self.call(params = nil)
        new(params).call
      end

      def initialize(params)
        @params = params
      end

      def call
        response = Tessera::Request.new(:GET, 'Ticket', body).send
        JSON.parse(response.body)
      end

      def session_id
        session = Session.create
        # TODO: solve token creation failure with error
        session.session_id
      end

      private

      def body
        @params.to_h.merge(SessionID: session_id)
      end
    end
  end
end
