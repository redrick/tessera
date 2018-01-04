RSpec.describe Tessera::Otrs::Ticket do
  describe 'initialize' do
    it 'can initialize object with deafult an given values' do
      ticket = Tessera::Otrs::Ticket
        .new(title: 'Title', queue: 22, state: 'new', priority: 2,
             customer_user: 'user@customer.com', customer_id: 234)

      expect(ticket.Title).to eq('Title')
      expect(ticket.QueueID).to eq(22)
      expect(ticket.State).to eq('new')
      expect(ticket.PriorityID).to eq(2)
      expect(ticket.CustomerUser).to eq('user@customer.com')
      expect(ticket.CustomerID).to eq(234)
    end
  end

  describe '#to_hash' do
    it 'correctly converts to hash' do
      ticket = Tessera::Otrs::Ticket
        .new(title: 'Title', queue: 22, state: 'new', priority: 2,
             customer_user: 'user@customer.com', customer_id: 234)

      expect(ticket.to_hash).to eq(
        {
          :Title=>"Title",
          :QueueID=>22,
          :State=>"new",
          :PriorityID=>2,
          :CustomerUser=>"user@customer.com",
          :CustomerID=>234
        }
      )
    end
  end
end
