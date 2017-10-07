##
#
#
#
module Tessera
  module Api
    class Ticket
      def self.get(ticket_id)
        new.get(ticket_id)
      end

      def create
        response = Tessera::Request.new(:post, 'Session', body).send
        Tessera::Model::Session.new(response)
      end

      def session_id
        session = Session.create
        # TODO: solve token creation failure with error
        session.session_id
      end

      private

      def body
        {
          UserLogin: Tessera.configuration.username,
          Password: Tessera.configuration.password
        }
      end
    end
  end
end
