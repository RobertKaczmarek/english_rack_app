require 'json'
require 'trie'

class Pronounce
  def initialize(words)
    @trie = words
  end

  def call(env)
    req = Rack::Request.new(env)

    word = req.path_info.gsub('/', '').to_s
    pronunciation = @trie.find(word).values.join
    hash = { word: "#{word}", pronunciation: "#{pronunciation}"}
    [200, { 'Content-Type' => 'application/json' }, [hash.to_json] ]
  end
end
