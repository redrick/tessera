RSpec.describe Tessera::Api::TicketList do
  describe '.call' do
    it 'calls instance method' do
      getter = double
      allow(Tessera::Api::TicketList).to receive(:new).and_return(getter)
      expect(getter).to receive(:call)
      Tessera::Api::TicketList.call
    end
  end
end
