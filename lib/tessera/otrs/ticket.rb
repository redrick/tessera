module Tessera
  module Otrs
    class Ticket < Base
      attr_accessor :Title, :QueueID, :State, :PriorityID, :CustomerUser, :CustomerID

      # rubocop:disable Metrics/ParameterLists
      def initialize(title:, queue:, state:, priority:, customer_user:, customer_id:)
        @Title = title
        @QueueID = queue
        @State = state
        @PriorityID = priority
        @CustomerUser = customer_user
        @CustomerID = customer_id
      end
      # rubocop:enable Metrics/ParameterLists
    end
  end
end
