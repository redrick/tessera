module Tessera
  module Otrs
    class Article < Base
      attr_accessor :From, :Subject, :Body, :ContentType

      def initialize(from:, subject:, body:)
        @From = from
        @Subject = subject
        @Body = body
        @ContentType = 'text/plain; charset=utf8'
      end
    end
  end
end
