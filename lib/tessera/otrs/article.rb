module Tessera
  module Otrs
    class Article < Base
      attr_accessor :From, :Subject, :Body, :ContentType, :CommunicationChannel

      def initialize(from:, subject:, body:, communication_channel: 'Email')
        @From = from
        @Subject = subject
        @Body = body
        @ContentType = 'text/plain; charset=utf8'
        @CommunicationChannel = communication_channel
      end
    end
  end
end
