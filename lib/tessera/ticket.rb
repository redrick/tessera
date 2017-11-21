module Tessera
  class Ticket
    def initialize(result)
      @result = result
    end

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def self.find(ticket_id)
      ticket = if ticket_id.is_a? Array
                 ::Tessera::Api::TicketList.call(ticket_id)
               else
                 ::Tessera::Api::TicketGet.call(ticket_id)
               end
      if ticket['Error']
        raise TicketNotFound.new(ticket['Error']['ErrorMessage'],
                                 ticket['Error']['ErrorCode'])
      elsif ticket['Ticket'] && ticket['Ticket'].count > 1
        ticket['Ticket'].map do |ticket_json|
          ::Tessera::Model::Ticket.new(ticket_json)
        end
      else
        ::Tessera::Model::Ticket.new(ticket['Ticket'].first)
      end
    end
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/AbcSize

    def self.where(params)
      result = Tessera::Api::TicketSearch.call(params)
      ticket_ids = result['TicketID'] ? result['TicketID'] : []
      new(ticket_ids)
    end

    def ticket_ids
      @result.map(&:to_i)
    end

    def tickets
      return [] if @result.empty?
      @tickets ||= @result.map do |id|
        ::Tessera::Ticket.find(id)
      end
    end
  end
end
