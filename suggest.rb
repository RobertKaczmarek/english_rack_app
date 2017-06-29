require 'json'
require 'trie'

class Suggest
  def initialize(words)
    @trie = words
  end

  def call(env)
    req = Rack::Request.new(env)

    prefix = req.path_info.gsub('/', '').to_s

    suggest = []
    @trie.find_prefix(prefix).each do |k, v|
      word = { word: "#{prefix}#{k.join}", pronunciation: v }
      suggest << word
    end

    [200, { 'Content-Type' => 'application/json' }, [suggest.take(10).to_json] ]
  end
end
