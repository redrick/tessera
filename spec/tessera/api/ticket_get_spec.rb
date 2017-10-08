RSpec.describe Tessera::Api::TicketGet do
  describe '.call' do
    it 'calls instance method' do
      getter = double
      allow(Tessera::Api::TicketGet).to receive(:new).and_return(getter)
      expect(getter).to receive(:call)
      Tessera::Api::TicketGet.call(1)
    end
  end

  describe '#call' do
    it 'returns desired ticket' do
      VCR.use_cassette 'ticket_get_success' do
        @session = Tessera::Api::TicketGet.call(1)
      end

      # expect(@session.code).to eq('200')
      # expect(@session.errors).to be_nil
    end
  end
end
