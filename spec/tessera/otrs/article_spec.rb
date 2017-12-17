RSpec.describe Tessera::Otrs::Article do
  describe 'initialize' do
    it 'can initialize object with deafult an given values' do
      article = Tessera::Otrs::Article
        .new('test@me.com', nil, 'Body here please')

      expect(article.From).to eq('test@me.com')
      expect(article.Subject).to be_nil
      expect(article.Body).to eq('Body here please')
      expect(article.ContentType).to eq('text/plain; charset=utf8')
    end
  end

  describe '#to_hash' do
    it 'correctly converts to hash' do
      article = Tessera::Otrs::Article
        .new('test@me.com', nil, 'Body here please')

      expect(article.to_hash).to eq(
        {
          :From=>"test@me.com",
          :Subject=>nil,
          :Body=>"Body here please",
          :ContentType=>"text/plain; charset=utf8"
        }
      )
    end
  end
end
