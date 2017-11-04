RSpec.describe Tessera::Model::Ticket do
  describe '.new' do
    it 'can correctly initialize' do
      json = {
        "Owner"=>"root@localhost",
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
        "Age"=>72839794
      }

      ticket = Tessera::Model::Ticket.new(json)

      expect(ticket).not_to be_nil
      expect(ticket.age).to eq(72839794)
      expect(ticket.archive_flag).to eq("n")
      expect(ticket.changed).to eq("2017-11-04 08:17:21")
      expect(ticket.changed_by).to eq(nil)
      expect(ticket.create_tim_nix).to eq(1436949030)
      expect(ticket.created).to eq("2015-07-15 08:30:30")
      expect(ticket.created_by).to eq(1)
      expect(ticket.customer_id).to eq(nil)
      expect(ticket.customer_user_id).to eq(nil)
      expect(ticket.escalation_response_time).to eq(0)
      expect(ticket.escalation_solution_time).to eq(0)
      expect(ticket.escalation_time).to eq(0)
      expect(ticket.escalation_update_time).to eq(0)
      expect(ticket.group_id).to eq(1)
      expect(ticket.lock).to eq("unlock")
      expect(ticket.lock_id).to eq(1)
      expect(ticket.owner).to eq("root@localhost")
      expect(ticket.owner_id).to eq(1)
      expect(ticket.priority).to eq("3 normal")
      expect(ticket.priority_id).to eq(3)
      expect(ticket.queue).to eq("Raw")
      expect(ticket.queue_id).to eq(2)
      expect(ticket.real_till_time_not_used).to eq(0)
      expect(ticket.responsible).to eq("root@localhost")
      expect(ticket.responsible_id).to eq(1)
      expect(ticket.service_id).to eq("")
      expect(ticket.slaid).to eq("")
      expect(ticket.state).to eq("new")
      expect(ticket.state_id).to eq(1)
      expect(ticket.state_type).to eq("new")
      expect(ticket.ticket_id).to eq(1)
      expect(ticket.ticket_number).to eq("2015071510123456")
      expect(ticket.title).to eq("Welcome to OTRS!")
      expect(ticket.type).to eq("Unclassified")
      expect(ticket.type_id).to eq(1)
      expect(ticket.unlock_timeout).to eq(0)
      expect(ticket.until_time).to eq(0)
    end
  end
end
