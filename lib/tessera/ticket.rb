module Tessera
  class Ticket
    class << self
      # rubocop:disable Metrics/AbcSize
      # rubocop:disable Metrics/MethodLength
      def find(ticket_id)
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

      def where(params)
        result = Tessera::Api::TicketSearch.call(params)
        ticket_ids = result['TicketID'] ? result['TicketID'] : []
        new(ticket_ids)
      end

      # rubocop:disable Metrics/AbcSize
      # rubocop:disable Metrics/MethodLength
      def create(params)
        ticket = Tessera::Otrs::Ticket.new(params[:ticket]).to_hash
        article = Tessera::Otrs::Article.new(params[:article]).to_hash
        attachment = if params[:attachment] && params[:attachment].is_a?(Hash)
                       Tessera::Otrs::Attachment.new(params[:attachment]).to_hash
                     elsif params[:attachment] && params[:attachment].is_a?(Array)
                       params[:attachment].map do |a|
                         Tessera::Otrs::Attachment.new(a).to_hash
                       end
                     end
        body = { Ticket: ticket }
        body = body.merge(Article: article)
        body = body.merge(Attachment: attachment) if attachment

        Tessera::Api::TicketCreate.call(body)
      end
      # rubocop:enable Metrics/MethodLength
      # rubocop:enable Metrics/AbcSize
    end

    def initialize(result)
      @result = result
    end

    def count
      @result.size
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
