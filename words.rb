require 'open-uri/cached'
require 'trie'

class WordsFromDict
  @words = Trie.new

  def self.dict
    if File.exists?('dict')
      File.open('/tmp/dict', 'rb') do |f|
        file = f.read
        file.each_line do |line|
          line.delete!("\n")
          word = line.split(' ', 2)
          @words.insert(word[0], word[1])
          end
      end
    else
      open('https://raw.githubusercontent.com/cmusphinx/cmudict/master/cmudict.dict') do |f|
        f.each_line do |line|
          line.delete!("\n")
          word = line.split(' ', 2)
          @words.insert(word[0], word[1])
          end
        end

      File.open('/tmp/dict', 'wb') do |f|
        @words.each { |k, v| f.write("#{k.join} #{v}\n") }
        end
    end
    @words
  end
end
