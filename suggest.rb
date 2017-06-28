require './words'
require 'json'
require 'trie'

class Suggest

  def call(env)
    @trie ||= WordsFromDict.dict
    req = Rack::Request.new(env)

    prefix = req.path_info.gsub('/', '').to_s

    suggest = {}
    @trie.find_prefix(prefix).each do |k, v|
      word = "#{prefix}#{k.join}"
      suggest[word] = v
    end

    [200, { 'Content-Type' => 'application/json' }, [suggest.first(10).to_json(root: false)] ]
  end
end
