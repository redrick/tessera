RSpec.describe Tessera::Api::TicketList do
  describe '.call' do
    it 'calls instance method' do
      getter = double
      allow(Tessera::Api::TicketList).to receive(:new).and_return(getter)
      expect(getter).to receive(:call)
      Tessera::Api::TicketList.call([])
    end
  end

  describe '#call' do
    it 'returns list of tickets' do
      VCR.use_cassette 'ticket_list_success' do
        @tickets = Tessera::Api::TicketList.call([1, 2, 3])
      end

      expect(@tickets).to eq({"Ticket"=>
        [{"ResponsibleID"=>1,
          "TicketID"=>1,
          "CustomerID"=>nil,
          "Title"=>"Welcome to OTRS!",
          "StateID"=>1,
          "UntilTime"=>0,
          "Type"=>"Unclassified",
          "ChangeBy"=>1,
          "Responsible"=>"root@localhost",
          "Queue"=>"Raw",
          "UnlockTimeout"=>0,
          "ServiceID"=>"",
          "EscalationTime"=>0,
          "StateType"=>"new",
          "ArchiveFlag"=>"n",
          "PriorityID"=>3,
          "Lock"=>"unlock",
          "CreateBy"=>1,
          "TicketNumber"=>"2015071510123456",
          "LockID"=>1,
          "OwnerID"=>1,
          "CreateTimeUnix"=>1436949030,
          "SLAID"=>"",
          "RealTillTimeNotUsed"=>0,
          "TypeID"=>1,
          "QueueID"=>2,
          "GroupID"=>1,
          "EscalationResponseTime"=>0,
          "CustomerUserID"=>nil,
          "State"=>"new",
          "Age"=>72965088,
          "Priority"=>"3 normal",
          "Created"=>"2015-07-15 08:30:30",
          "EscalationUpdateTime"=>0,
          "Changed"=>"2017-11-05 19:41:34",
          "EscalationSolutionTime"=>0,
          "Owner"=>"root@localhost"},
          {"ResponsibleID"=>1,
          "TicketID"=>2,
          "CustomerID"=>"678",
          "Title"=>"Do not get out of your house!",
          "StateID"=>1,
          "UntilTime"=>0,
          "Type"=>"Unclassified",
          "ChangeBy"=>1,
          "Responsible"=>"root@localhost",
          "Queue"=>"Raw",
          "UnlockTimeout"=>0,
          "ServiceID"=>"",
          "EscalationTime"=>0,
          "StateType"=>"new",
          "ArchiveFlag"=>"n",
          "PriorityID"=>3,
          "Lock"=>"unlock",
          "CreateBy"=>1,
          "TicketNumber"=>"2017110548000019",
          "OwnerID"=>1,
          "LockID"=>1,
          "CreateTimeUnix"=>1509914092,
          "SLAID"=>"",
          "RealTillTimeNotUsed"=>0,
          "TypeID"=>1,
          "QueueID"=>2,
          "GroupID"=>1,
          "State"=>"new",
          "EscalationResponseTime"=>0,
          "CustomerUserID"=>"205@example-sales.net",
          "Age"=>26,
          "Priority"=>"3 normal",
          "Created"=>"2017-11-05 20:34:52",
          "EscalationUpdateTime"=>0,
          "Changed"=>"2017-11-05 20:34:53",
          "EscalationSolutionTime"=>0,
          "Owner"=>"root@localhost"},
          {"ResponsibleID"=>1,
          "TicketID"=>3,
          "CustomerID"=>"617",
          "Title"=>"and we go an very long way to home",
          "StateID"=>1,
          "UntilTime"=>0,
          "Type"=>"Unclassified",
          "ChangeBy"=>1,
          "Responsible"=>"root@localhost",
          "Queue"=>"Raw",
          "UnlockTimeout"=>0,
          "ServiceID"=>"",
          "EscalationTime"=>0,
          "StateType"=>"new",
          "ArchiveFlag"=>"n",
          "PriorityID"=>4,
          "Lock"=>"unlock",
          "CreateBy"=>1,
          "TicketNumber"=>"2017110548000028",
          "OwnerID"=>1,
          "LockID"=>1,
          "CreateTimeUnix"=>1509914093,
          "SLAID"=>"",
          "RealTillTimeNotUsed"=>0,
          "TypeID"=>1,
          "QueueID"=>2,
          "GroupID"=>1,
          "State"=>"new",
          "EscalationResponseTime"=>0,
          "CustomerUserID"=>"985@slow-company-example.com",
          "Age"=>25,
          "Priority"=>"4 high",
          "Created"=>"2017-11-05 20:34:53",
          "EscalationUpdateTime"=>0,
          "Changed"=>"2017-11-05 20:34:54",
          "EscalationSolutionTime"=>0,
          "Owner"=>"root@localhost"}]})
    end

    it 'returns error if ticket not present' do
      VCR.use_cassette 'ticket_list_fail' do
        @tickets = Tessera::Api::TicketList.call([999, 1000, 1110])
      end

      expect(@tickets).to eq({"Error"=>
        {"ErrorMessage"=>"TicketGet: User does not have access to the ticket!",
         "ErrorCode"=>"TicketGet.AccessDenied"}})
    end
  end
end
