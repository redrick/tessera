RSpec.describe Tessera::Model::Session do
  describe 'initialize' do
    it 'will properly initialize empty response' do
      response = double('Response', code: '200', body: nil)

      session = Tessera::Model::Session.new(response)

      expect(session.code).to eq('200')
      expect(session.session_id).to be_nil
      expect(session.errors).to be_nil
    end

    it 'will properly initialize' do
      response = double('Response', code: '200', body: { SessionID: 'XXX' }.to_json)

      session = Tessera::Model::Session.new(response)

      expect(session.code).to eq('200')
      expect(session.session_id).to eq('XXX')
      expect(session.errors).to be_nil
    end

    it 'will properly initialize with errors' do
      response = double('Response', code: '200',
                        body: {
        'Error': { 
          'ErrorCode': 'Y', 'ErrorMessage': 'Failure'
        } 
      }.to_json)

      session = Tessera::Model::Session.new(response)

      expect(session.code).to eq('200')
      expect(session.session_id).to be_nil
      expect(session.errors).to eq({
        'ErrorCode' => 'Y', 'ErrorMessage' => 'Failure'
      })
    end
  end
end
