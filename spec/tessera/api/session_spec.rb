RSpec.describe Tessera::Api::Session do
  describe '.create' do
    it 'calls instance method' do
      creator = double
      allow(Tessera::Api::Session).to receive(:new).and_return(creator)
      expect(creator).to receive(:create)
      Tessera::Api::Session.create
    end
  end

  describe '#create' do
    it 'returns new session hash' do
      VCR.use_cassette 'session_create_success' do
        @session = Tessera::Api::Session.create
      end

      expect(@session.code).to eq('200')
      expect(@session.errors).to be_nil
      expect(@session.session_id).to eq('Sg9SlOIOXNT6JTq0slcxAMy61H4CnwYz')
    end

    it 'returns errors' do
      allow(Tessera)
        .to receive_message_chain(:configuration, :password)
        .and_return('wrong_pwd')
      allow(Tessera)
        .to receive_message_chain(:configuration, :username)
        .and_return('tester')
      allow(Tessera)
        .to receive_message_chain(:configuration, :base_url)
        .and_return('http://localhost/otrs/nph-genericinterface.pl/'\
                    'Webservice/tickets/')

      VCR.use_cassette 'session_create_failure' do
        @session = Tessera::Api::Session.create
      end

      expect(@session.errors)
        .to eq('ErrorCode' => 'SessionCreate.AuthFail',
               'ErrorMessage' => 'SessionCreate: Authorization failing!')
      expect(@session.session_id).to be_nil
    end
  end
end
