##
#
#
#
module Tessera
  module Api
    class Session
      def self.create
        new.create
      end

      def create
        response = Tessera::Request.new(:post, 'Session', credentials).send
        Tessera::Model::Session.new(response)
      end

      private

      def credentials
        {
          UserLogin: Tessera.configuration.username,
          Password: Tessera.configuration.password
        }
      end
    end
  end
end
