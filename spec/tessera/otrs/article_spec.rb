RSpec.describe Tessera::Otrs::Article do
  describe 'initialize' do
    it 'can initialize object with deafult an given values' do
      article = Tessera::Otrs::Article
        .new(from: 'test@me.com', subject: nil, body: 'Body here please',
             communication_channel: 'Internal', article_send: 1)

      expect(article.From).to eq('test@me.com')
      expect(article.To).to be_nil
      expect(article.Subject).to be_nil
      expect(article.Body).to eq('Body here please')
      expect(article.ContentType).to eq('text/plain; charset=utf8')
      expect(article.CommunicationChannel).to eq('Internal')
      expect(article.ArticleSend).to eq(1)
    end
  end

  describe '#to_hash' do
    it 'correctly converts to hash' do
      article = Tessera::Otrs::Article
        .new(from: 'test@me.com', to: 'a@email.cz', subject: nil, body: 'Body here please')

      expect(article.to_hash).to eq(
        {
          :From=>"test@me.com",
          :To=> 'a@email.cz',
          :Subject=>nil,
          :Body=>"Body here please",
          :ContentType=>"text/plain; charset=utf8",
          :CommunicationChannel=>'Email',
          :ArticleSend=>0
        }
      )
    end
  end
end
