RSpec.describe Tessera::Otrs::Attachment do
  describe 'initialize' do
    it 'can initialize object with deafult an given values' do
      tempfile = Rack::Test::UploadedFile.new('spec/support/files/test.pdf')
      attachment = Tessera::Otrs::Attachment.new(tempfile)

      expect(attachment.ContentType).to eq('text/plain')
      expect(attachment.Filename).to eq('test.pdf')
    end
  end
end
