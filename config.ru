require './pronounce'
require './suggest'
require './words'


class EnglishApp
  def self.app
    @app ||= begin
      Rack::Builder.new do
        words ||= WordsFromDict.dict

        map '/pronounce' do
          run Pronounce.new(words)
        end

        map '/suggest' do
          run Suggest.new(words)
        end
      end
    end
  end
end


run EnglishApp.app
