require './words'
require 'json'
require 'trie'

class Pronounce

  def call(env)
    @trie ||= WordsFromDict.dict

  req = Rack::Request.new(env)

    word = req.path_info.gsub('/', '').to_s
    [200, { 'Content-Type' => 'application/json' }, [{ "#{word}": @trie.find("#{word}").values }.to_json] ]
  end
end
