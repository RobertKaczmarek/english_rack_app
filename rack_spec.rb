require './pronounce'
require './suggest'
require 'rack/test'
require 'rspec'


describe 'the app' do
  include Rack::Test::Methods

  def app
    Rack::Builder.new do
      words = Trie.new.insert('a', 'AH0')
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


  context '/pronounce' do
    before do
      get '/pronounce'
    end

    it 'returns the status 200' do
      expect(last_response.status).to eq 200
    end

    it 'returns json' do
      expect(last_response.header).to include('Content-Type' => 'application/json')
    end

    it 'returns pronunciation' do
      get '/pronounce/a'
      expect(last_response.body).to include('AH0')
    end
  end

  context '/suggest' do
    before do
      get '/suggest'
    end

    it 'returns the status 200' do
      expect(last_response.status).to eq 200
    end

    it 'returns json' do
      expect(last_response.header).to include('Content-Type' => 'application/json')
    end

    it 'returns 10 words' do
      get '/suggest/a'
      expect(last_response.body).to include('a', 'a(2)0', 'a(2)1', 'a(2)2', 'a(2)3', 'a(2)4', 'a(2)5', 'a(2)6', 'a(2)7', 'a(2)8')
    end
  end
end
