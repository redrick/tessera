RSpec.describe Tessera::Ticket do
  describe '.find' do
    it 'correctly returns parsed ticket found' do
      VCR.use_cassette 'ticket_find_success' do
        @ticket = Tessera::Ticket.find(1)
      end

      expect(@ticket).not_to be_nil
      expect(@ticket.age).to eq(72840582)
      expect(@ticket.archive_flag).to eq("n")
      expect(@ticket.changed).to eq("2017-11-04 08:17:21")
      expect(@ticket.changed_by).to eq(nil)
      expect(@ticket.create_tim_nix).to eq(1436949030)
      expect(@ticket.created).to eq("2015-07-15 08:30:30")
      expect(@ticket.created_by).to eq(1)
      expect(@ticket.customer_id).to eq(nil)
      expect(@ticket.customer_user_id).to eq(nil)
      expect(@ticket.escalation_response_time).to eq(0)
      expect(@ticket.escalation_solution_time).to eq(0)
      expect(@ticket.escalation_time).to eq(0)
      expect(@ticket.escalation_update_time).to eq(0)
      expect(@ticket.group_id).to eq(1)
      expect(@ticket.lock).to eq("unlock")
      expect(@ticket.lock_id).to eq(1)
      expect(@ticket.owner).to eq("root@localhost")
      expect(@ticket.owner_id).to eq(1)
      expect(@ticket.priority).to eq("3 normal")
      expect(@ticket.priority_id).to eq(3)
      expect(@ticket.queue).to eq("Raw")
      expect(@ticket.queue_id).to eq(2)
      expect(@ticket.real_till_time_not_used).to eq(0)
      expect(@ticket.responsible).to eq("root@localhost")
      expect(@ticket.responsible_id).to eq(1)
      expect(@ticket.service_id).to eq("")
      expect(@ticket.slaid).to eq("")
      expect(@ticket.state).to eq("new")
      expect(@ticket.state_id).to eq(1)
      expect(@ticket.state_type).to eq("new")
      expect(@ticket.ticket_id).to eq(1)
      expect(@ticket.ticket_number).to eq("2015071510123456")
      expect(@ticket.title).to eq("Welcome to OTRS!")
      expect(@ticket.type).to eq("Unclassified")
      expect(@ticket.type_id).to eq(1)
      expect(@ticket.unlock_timeout).to eq(0)
      expect(@ticket.until_time).to eq(0)
    end

    it 'correctly returns parsed ticket found' do
      expect do
        VCR.use_cassette 'ticket_find_failure' do
          @ticket = Tessera::Ticket.find(999)
        end
      end.to raise_error { Tessera::TicketNotFound }
    end
  end
end