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
        @ticket = Tessera::Api::TicketGet.call(1)
      end

      expect(@ticket).to eq({"Ticket"=>
        [{"Owner"=>"root@localhost",
            "SLAID"=>"",
            "UntilTime"=>0,
            "CustomerUserID"=>nil,
            "Queue"=>"Raw",
            "ArchiveFlag"=>"n",
            "ChangeBy"=>1,
            "CustomerID"=>nil,
            "EscalationUpdateTime"=>0,
            "StateType"=>"new",
            "UnlockTimeout"=>0,
            "RealTillTimeNotUsed"=>0,
            "StateID"=>1,
            "TypeID"=>1,
            "ResponsibleID"=>1,
            "Lock"=>"unlock",
            "OwnerID"=>1,
            "Title"=>"Welcome to OTRS!",
            "Type"=>"Unclassified",
            "EscalationSolutionTime"=>0,
            "EscalationResponseTime"=>0,
            "EscalationTime"=>0,
            "Created"=>"2015-07-15 08:30:30",
            "CreateBy"=>1,
            "GroupID"=>1,
            "Changed"=>"2017-11-04 08:17:21",
            "TicketID"=>1,
            "ServiceID"=>"",
            "State"=>"new",
            "Priority"=>"3 normal",
            "Responsible"=>"root@localhost",
            "TicketNumber"=>"2015071510123456",
            "PriorityID"=>3,
            "LockID"=>1,
            "QueueID"=>2,
            "CreateTimeUnix"=>1436949030,
            "Age"=>72839794}]})
    end

    it 'returns error if ticket not present' do
      VCR.use_cassette 'ticket_get_fail' do
        @ticket = Tessera::Api::TicketGet.call(999)
      end

      expect(@ticket).to eq({"Error"=>
        {"ErrorMessage"=>"TicketGet: User does not have access to the ticket!",
         "ErrorCode"=>"TicketGet.AccessDenied"}})
    end
  end
end
