module Tessera
  module Otrs
    class Article < Base
      attr_accessor :From, :To, :Subject, :Body, :ContentType, :CommunicationChannel,
                    :ArticleSend

      # rubocop:disable Metrics/ParameterLists
      def initialize(from:, to: nil, subject:, body:, communication_channel: 'Email',
                     article_send: 0)
        @From = from
        @To = to
        @Subject = subject
        @Body = body
        @ContentType = 'text/plain; charset=utf8'
        @CommunicationChannel = communication_channel
        @ArticleSend = article_send
      end
      # rubocop:enable Metrics/ParameterLists
    end
  end
end
