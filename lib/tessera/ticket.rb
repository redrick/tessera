module Tessera
  class Ticket
    def self.find(ticket_id)
      ticket = ::Tessera::Api::TicketGet.call(ticket_id)
      if ticket['Error']
        raise TicketNotFound.new(ticket['Error']['ErrorMessage'],
                                 ticket['Error']['ErrorCode'])
      else
        ::Tessera::Model::Ticket.new(ticket['Ticket'].first)
      end
    end
  end
end
