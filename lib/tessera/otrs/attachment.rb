module Tessera
  module Otrs
    class Attachment < Base
      attr_accessor :Content, :ContentType, :Filename

      def initialize(tempfile:)
        tempfile.rewind
        @Content = Base64.encode64(tempfile.read)
        @ContentType = tempfile.content_type
        @Filename = tempfile.original_filename
      end
    end
  end
end
