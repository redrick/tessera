RSpec.describe Tessera::Ticket do
  describe '.find' do
    it 'correctly returns parsed ticket found' do
      VCR.use_cassette 'ticket_find_success' do
        @ticket = Tessera::Ticket.find(1)
      end

      expect(@ticket).not_to be_nil
      expect(@ticket).to be_kind_of(Tessera::Model::Ticket)
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

    it 'correctly returns array of tickets if asked for it' do
      VCR.use_cassette 'ticket_array_find_success' do
        @tickets = Tessera::Ticket.find([1, 2, 3])
      end

      expect(@tickets).to be_kind_of(Array)
      expect(@tickets.size).to eq(3)
      expect(@tickets.first).to be_kind_of(Tessera::Model::Ticket)
      expect(@tickets.first.ticket_id).to eq(1)
      expect(@tickets.first(2).last.ticket_id).to eq(2)
      expect(@tickets.first(3).last.ticket_id).to eq(3)
    end
  end

  describe '.where' do
    describe '#ticket_ids' do
      it 'returns array of ticket IDs' do
        VCR.use_cassette 'ticket_where_ids_success' do
          @result = Tessera::Ticket.where(Title: 'Why%')
        end

        expect(@result.ticket_ids).to contain_exactly(10, 2)
      end
    end

    describe '#tickets' do
      it 'returns array of tickets' do
        VCR.use_cassette 'ticket_where_tickets_success' do
          result = Tessera::Ticket.where(Title: 'Why%')
          @tickets = result.tickets
        end

        expect(@tickets).to be_kind_of(Array)
        expect(@tickets.size).to eq(2)
        expect(@tickets.first).to be_kind_of(Tessera::Model::Ticket)
        expect(@tickets.first.ticket_id).to eq(10)
        expect(@tickets.first(2).last.ticket_id).to eq(2)
      end

      it 'returns array of tickets with different search' do
        VCR.use_cassette 'ticket_where_tickets_specific_success' do
          result = Tessera::Ticket
            .where(Queues: ['Raw'], States: ['new'])
          @tickets = result.tickets
        end

        expect(@tickets).to be_kind_of(Array)
        expect(@tickets.size).to eq(4)
        expect(@tickets.first).to be_kind_of(Tessera::Model::Ticket)
        expect(@tickets.map(&:ticket_number))
          .to contain_exactly("2018010410000233", "2018010410000224",
                              "2018010410000215", "2018010410000206")
      end
    end

    describe '#count' do
      it 'returns count of tickets found (Title)' do
        VCR.use_cassette 'ticket_where_count_success' do
          @result = Tessera::Ticket.where(Title: 'Why%')
        end

        expect(@result.count).to eq(2)
      end

      it 'returns count of tickets found (StateType)' do
        VCR.use_cassette 'ticket_where_another_count_success' do
          @result = Tessera::Ticket.where(StateType: 'new')
        end

        expect(@result.count).to eq(11)
      end
    end
  end

  describe 'create' do
    it 'can create ticket form given params' do
      params = {
        ticket: {
          title: 'New ticket',
          queue: 2,
          state: 'new',
          priority: 3,
          customer_user: 'andrej',
          customer_id: 'aaaaa'
        },
        article: {
          from: 'sender@gmail.com',
          subject: 'Hello World!',
          body: 'Hello body!',
        },
        attachment: {
          tempfile: Rack::Test::UploadedFile.new('spec/support/files/test.pdf')
        }
      }

      VCR.use_cassette 'ticket_create_success' do
        @result = Tessera::Ticket.create(params)
      end

      expect(@result).to eq({
        "ArticleID"=>166,
        "TicketID"=>"54",
        "TicketNumber"=>"2018010410000251"
      })
    end

    it 'fails creating ticket with OTRS error message (missing params)' do
      params = {
        ticket: {
          title: 'New ticket',
          queue: 2,
          state: 'new',
          priority: 3,
          customer_user: nil,
          customer_id: 'aaaaa'
        },
        article: {
          from: 'sender@gmail.com',
          subject: 'Hello World!',
          body: 'Hello body!',
        },
        attachment: {
          tempfile: Rack::Test::UploadedFile.new('spec/support/files/test.pdf')
        }
      }

      VCR.use_cassette 'ticket_create_failure' do
        @result = Tessera::Ticket.create(params)
      end

      expect(@result).to eq({
        "Error" => {
          "ErrorMessage"=>"TicketCreate: Ticket->CustomerUser parameter is missing!",
          "ErrorCode"=>"TicketCreate.MissingParameter"
        }
      })
    end

    it 'can create ticket sending article as email to `to` email' do
      params = {
        ticket: {
          title: 'New ticket',
          queue: 2,
          state: 'new',
          priority: 3,
          customer_user: 'andrej',
          customer_id: 'aaaaa'
        },
        article: {
          from: 'sender@gmail.com',
          to: 'receiver@destination.com',
          subject: 'Hello World!',
          body: 'Hello body!',
          article_send: 1
        },
        attachment: {
          tempfile: Rack::Test::UploadedFile.new('spec/support/files/test.pdf')
        }
      }

      VCR.use_cassette 'ticket_create_article_send_success' do
        @result = Tessera::Ticket.create(params)
      end

      expect(@result).to eq({
        "ArticleID"=>174,
        "TicketID"=>"58",
        "TicketNumber"=>"2018010410000297"
      })
    end

    it 'can create ticket sending article as email to multiple `to` email' do
      params = {
        ticket: {
          title: 'New ticket',
          queue: 2,
          state: 'new',
          priority: 3,
          customer_user: 'andrej',
          customer_id: 'aaaaa'
        },
        article: {
          from: 'sender@gmail.com',
          to: 'receiver@destination.com, second@email.com',
          subject: 'Hello World!',
          body: 'Hello body!',
          article_send: 1
        }
      }

      VCR.use_cassette 'ticket_create_article_send_multiple_success' do
        @result = Tessera::Ticket.create(params)
      end

      expect(@result).to eq({
        "ArticleID"=>176,
        "TicketID"=>"59",
        "TicketNumber"=>"2018010410000304"
      })
    end

    it 'can create ticket with multiple attachments' do
      params = {
        ticket: {
          title: 'New ticket',
          queue: 2,
          state: 'new',
          priority: 3,
          customer_user: 'andrej',
          customer_id: 'aaaaa'
        },
        article: {
          from: 'sender@gmail.com',
          subject: 'Hello World!',
          body: 'Hello body!',
        },
        attachment: [
          {
            tempfile: Rack::Test::UploadedFile.new('spec/support/files/test.pdf')
          },
          {
            tempfile: Rack::Test::UploadedFile.new('spec/support/files/test2.pdf')
          }
        ]
      }

      VCR.use_cassette 'ticket_create_attachments_success' do
        @result = Tessera::Ticket.create(params)
      end

      expect(@result).to eq({
        "ArticleID"=>168,
        "TicketID"=>"55",
        "TicketNumber"=>"2018010410000261"
      })
    end

    it 'can create ticket without attachment' do
      params = {
        ticket: {
          title: 'New ticket',
          queue: 2,
          state: 'new',
          priority: 3,
          customer_user: 'andrej',
          customer_id: 'aaaaa'
        },
        article: {
          from: 'sender@gmail.com',
          subject: 'Hello World!',
          body: 'Hello body!',
        }
      }

      VCR.use_cassette 'ticket_create_no_attachment_success' do
        @result = Tessera::Ticket.create(params)
      end

      expect(@result).to eq({
        "ArticleID"=>170,
        "TicketID"=>"56",
        "TicketNumber"=>"2018010410000279"
      })
    end
  end
end
