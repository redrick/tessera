RSpec.describe Tessera::Api::TicketSearch do
  describe '.call' do
    it 'calls instance method' do
      getter = double
      allow(Tessera::Api::TicketSearch).to receive(:new).and_return(getter)
      expect(getter).to receive(:call)
      Tessera::Api::TicketSearch.call({})
    end
  end

  describe '#call' do
    it 'returns list of tickets' do
      VCR.use_cassette 'ticket_search_success' do
        @tickets = Tessera::Api::TicketSearch.call(Result: 'COUNT')
      end

      # TODO
    end
  end
end
