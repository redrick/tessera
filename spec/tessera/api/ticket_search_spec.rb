RSpec.describe Tessera::Api::TicketSearch do
  describe '.call' do
    it 'calls instance method' do
      getter = double
      allow(Tessera::Api::TicketSearch).to receive(:new).and_return(getter)
      expect(getter).to receive(:call)
      Tessera::Api::TicketSearch.call
    end
  end

  describe '#call' do
    it 'returns ticket IDs' do
      VCR.use_cassette 'ticket_search_success' do
        @tickets = Tessera::Api::TicketSearch.call(Title: 'Why%')
      end

      expect(@tickets).to eq({"TicketID"=>["10", "2"]})
    end

    it 'returns nothing (would expect error...??)' do
      VCR.use_cassette 'ticket_search_failure' do
        @tickets = Tessera::Api::TicketSearch.call(Types: ['why'])
      end

      expect(@tickets).to eq({})
    end
  end
end
