require './pronounce'
require './suggest'
require 'rack/test'
require 'rspec'
require 'open-uri/cached'



describe 'the app' do
  include Rack::Test::Methods

  def app
    Rack::Builder.new do
      words = Trie.new
      words.insert("a", 'AH0')
      for i in 0..9
        words.insert("a(2)#{i}", 'smt')
      end

      map '/pronounce' do
        run Pronounce.new(words)
      end

      map '/suggest' do
        run Suggest.new(words)
        end
    end.to_app
  end

  context 'get to /pronounce' do
    it 'returns the status 200' do
      get '/pronounce'
      expect(last_response.status).to eq 200
    end

    it 'returns pronunciation' do
      get '/pronounce/a'
      expect(last_response.body).to include('AH0')
    end
  end

  context 'get to /suggest' do
    it 'returns the status 200' do
      get '/suggest'
      expect(last_response.status).to eq 200
    end

    it 'returns 10 words' do
      get '/suggest/a'
      expect(last_response.body).to include('a', 'a(2)0', 'a(2)1', 'a(2)2', 'a(2)3', 'a(2)4', 'a(2)5', 'a(2)6', 'a(2)7', 'a(2)8')
    end
  end
end
